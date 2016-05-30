//
//  STTweetLabel.m
//  STTweetLabel
//
//  Created by Sebastien Thiebaud on 09/29/13.
//  Copyright (c) 2013 Sebastien Thiebaud. All rights reserved.
//

#import "STTweetLabel.h"
#import "ANHelperFunctions.h"

#define URL_REGEXPRESSION @"(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:'\".,<>?«»“”‘’]))"

@interface STTweetLabel () <UITextViewDelegate>

@property (strong, nonatomic) NSRegularExpression *urlRegex;

@property (strong, nonatomic) NSTextStorage *textStorage;
@property (strong, nonatomic) NSLayoutManager *layoutManager;
@property (strong, nonatomic) NSTextContainer *textContainer;

@property (strong, nonatomic) NSString *cleanText;
@property (copy,nonatomic) NSAttributedString *cleanAttributedText;

@property (strong, nonatomic) NSMutableArray *rangesOfHotWords;

@property (strong, nonatomic) NSDictionary *attributesText;
@property (strong, nonatomic) NSDictionary *attributesHandle;
@property (strong, nonatomic) NSDictionary *attributesHashtag;
@property (strong, nonatomic) NSDictionary *attributesLink;

@property (strong, nonatomic) UITextView *textView;

@property (assign, nonatomic) BOOL isTouchesMoved;
@property (assign, nonatomic) NSRange selectableRange;
@property (assign, nonatomic) NSInteger firstCharIndex;
@property (assign, nonatomic) CGPoint firstTouchLocation;
@end

@implementation STTweetLabel
@synthesize validProtocols = _validProtocols;

#pragma mark - Life Cycle

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.numberOfLines = 0;
    self.leftToRight = YES;
    
    [self textView];
    [self textStorage];
}

#pragma mark - Responder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:[_cleanText substringWithRange:_selectableRange]];
    
    @try {
        [_textStorage removeAttribute:NSBackgroundColorAttributeName range:_selectableRange];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception);
    }
}

#pragma mark -

- (void)determineHotWords
{
    if (_cleanText == nil)
    {
        return;
    }
    ANDispatchBlockToBackgroundQueue(^{
        [self _determineHotWords];
    });
}

- (void)_determineHotWords
{
    NSMutableString *tmpText = [[NSMutableString alloc] initWithString:_cleanText];
    
    if (!_leftToRight)
    {
        tmpText = [[NSMutableString alloc] init];
        [tmpText appendString:@"\u200F"];
        [tmpText appendString:_cleanText];
    }
    
    NSString *hotCharacters = @"@#";
    NSCharacterSet *hotCharactersSet = [NSCharacterSet characterSetWithCharactersInString:hotCharacters];
    
    NSMutableCharacterSet *validCharactersSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [validCharactersSet removeCharactersInString:@"!@#$%^&*()-={[]}|;:',<>.?/"];
    [validCharactersSet addCharactersInString:@"_"];
    
    _rangesOfHotWords = [NSMutableArray array];
    
    while ([tmpText rangeOfCharacterFromSet:hotCharactersSet].location < tmpText.length)
    {
        NSRange range = [tmpText rangeOfCharacterFromSet:hotCharactersSet];
        
        STTweetHotWord hotWord;
        
        switch ([tmpText characterAtIndex:range.location]) {
            case '@':
                hotWord = STTweetHandle;
                break;
            case '#':
                hotWord = STTweetHashtag;
                break;
            default:
                break;
        }
        
        [tmpText replaceCharactersInRange:range withString:@"%"];
        
        NSInteger charIndex = [tmpText characterAtIndex:range.location - 1];
        BOOL isMember = [validCharactersSet characterIsMember:charIndex];
        
        if (range.location > 0 && isMember)
        {
            continue;
        }
        
        NSInteger length = (int)range.length;
        
        while (range.location + length < tmpText.length)
        {
            NSInteger index = [tmpText characterAtIndex:range.location + length];
            BOOL charIsMember = [validCharactersSet characterIsMember:index];
            
            if (charIsMember)
            {
                length++;
            }
            else
            {
                break;
            }
        }
        
        // Register the hot word and its range
        if (length > 1)
        {
            NSValue* rangeValue = [NSValue valueWithRange:NSMakeRange(range.location, length)];
            [_rangesOfHotWords addObject:@{@"hotWord": @(hotWord),
                                           @"range": rangeValue}];
        }
    }
    [self determineLinks];
    [self updateText];
}

- (void)determineLinks
{
    NSMutableString *tmpText = [[NSMutableString alloc] initWithString:_cleanText];

    [self.urlRegex
     enumerateMatchesInString:tmpText
     options:0
     range:NSMakeRange(0, tmpText.length)
     usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
         
         NSString *link = [tmpText substringWithRange:result.range];
         NSRange  protocolRange = [link rangeOfString:@":"];
         
         NSString *protocol = nil;
         if (protocolRange.location != NSNotFound)
         {
             protocol = [link substringToIndex:protocolRange.location];
         }

         if ([_validProtocols containsObject:protocol.lowercaseString])
         {
             [_rangesOfHotWords addObject:@{ @"hotWord" : @(STTweetLink),
                                             @"protocol" : protocol,
                                             @"range" : [NSValue valueWithRange:result.range]
                                             }];
         }
    }];
}

- (void)updateText
{
    NSAttributedString *attributedString = _cleanAttributedText ?: [[NSMutableAttributedString alloc] initWithString:_cleanText];
    
    ANDispatchBlockToMainQueue(^{
        
        [self.textStorage beginEditing];
        
        [self.textStorage setAttributedString:attributedString];
        [self.textStorage setAttributes:self.attributesText
                                  range:NSMakeRange(0, attributedString.length)];

        for (NSDictionary *dictionary in self.rangesOfHotWords)
        {
            NSRange range = [dictionary[@"range"] rangeValue];
            STTweetHotWord hotWord = [dictionary[@"hotWord"] integerValue];
            [self.textStorage setAttributes:[self attributesForHotWord:hotWord] range:range];
        }
        
        [self.textStorage endEditing];
    });
}

#pragma mark - Public methods

- (CGSize)suggestedFrameSizeToFitEntireStringConstrainedToWidth:(CGFloat)width
{
    if (_cleanText == nil)
        return CGSizeZero;

    return [_textView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
}

- (CGSize) intrinsicContentSize
{
    CGSize size = [self suggestedFrameSizeToFitEntireStringConstrainedToWidth:CGRectGetWidth(self.frame)];
    return CGSizeMake(size.width, size.height + 1);
}

#pragma mark - Private methods

- (NSArray *)hotWordsList {
    return _rangesOfHotWords;
}

#pragma mark - Setters

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self invalidateIntrinsicContentSize];
}

- (void)setText:(NSString *)text
{
    [super setText:@""];
    self.cleanText = text;
    self.selectableRange = NSMakeRange(NSNotFound, 0);
    [self determineHotWords];
    [self invalidateIntrinsicContentSize];
}

- (void)setValidProtocols:(NSArray *)validProtocols
{
    _validProtocols = validProtocols;
    [self determineHotWords];
}

- (void)setAttributes:(NSDictionary *)attributes
{
    [self setAttributes:attributes hotWord:-1];
}

- (void)setAttributes:(NSDictionary *)attributes hotWord:(STTweetHotWord)hotWord
{
    if (!attributes[NSFontAttributeName])
    {
        NSMutableDictionary *copy = [attributes mutableCopy];
        copy[NSFontAttributeName] = self.font;
        attributes = [NSDictionary dictionaryWithDictionary:copy];
    }
    
    if (!attributes[NSForegroundColorAttributeName])
    {
        NSMutableDictionary *copy = [attributes mutableCopy];
        copy[NSForegroundColorAttributeName] = self.textColor;
        attributes = [NSDictionary dictionaryWithDictionary:copy];
    }
    
    switch (hotWord)  {
        case STTweetHandle:
            _attributesHandle = attributes;
            break;
        case STTweetHashtag:
            _attributesHashtag = attributes;
            break;
        case STTweetLink:
            _attributesLink = attributes;
            break;
        default:
            _attributesText = attributes;
            break;
    }
    
    [self determineHotWords];
}

- (void)setLeftToRight:(BOOL)leftToRight {
    _leftToRight = leftToRight;

    [self determineHotWords];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    _textView.textAlignment = textAlignment;
}

- (void)setDetectionBlock:(MEDetectionBlock)detectionBlock
{
    if (detectionBlock) {
        _detectionBlock = [detectionBlock copy];
        self.userInteractionEnabled = YES;
    } else {
        _detectionBlock = nil;
        self.userInteractionEnabled = NO;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _cleanAttributedText = [attributedText copy];
    self.text = _cleanAttributedText.string;
}

#pragma mark - Getters

- (NSString *)text {
    return _cleanText;
}

- (NSDictionary *)attributes {
    return _attributesText;
}

- (NSDictionary *)attributesForHotWord:(STTweetHotWord)hotWord {
    switch (hotWord) {
        case STTweetHandle:
            return _attributesHandle;

        case STTweetHashtag:
            return _attributesHashtag;

        case STTweetLink:
            return _attributesLink;

        default:
            break;
    }
    return nil;
}

- (BOOL)isLeftToRight
{
    return _leftToRight;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self touchedHotword:touches])
    {
        [super touchesBegan:touches withEvent:event];
    }
    
    self.isTouchesMoved = NO;
    
    @try
    {
        [self.textStorage removeAttribute:NSBackgroundColorAttributeName range:self.selectableRange];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception);
    }
    
    self.selectableRange = NSMakeRange(0, 0);
    self.firstTouchLocation = [[touches anyObject] locationInView:self.textView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self touchedHotword:touches])
    {
        [super touchesMoved:touches withEvent:event];
    }
    
    if (!self.textSelectable)
    {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        [menuController setMenuVisible:NO animated:YES];
        return;
    }
    
    self.isTouchesMoved = YES;
    
    CGPoint point = [[touches anyObject] locationInView:self.textView];
    NSInteger charIndex = [self charIndexAtLocation:point];
    
    if (charIndex == NSNotFound)
    {
        return;
    }

    [_textStorage beginEditing];

    @try
    {
        [_textStorage removeAttribute:NSBackgroundColorAttributeName range:_selectableRange];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception);
    }
    
    if (_selectableRange.length == 0)
    {
        _selectableRange = NSMakeRange(charIndex, 1);
        _firstCharIndex = charIndex;
    }
    else if (charIndex > _firstCharIndex)
    {
        _selectableRange = NSMakeRange(_firstCharIndex, charIndex - _firstCharIndex + 1);
    }
    else if (charIndex < _firstCharIndex)
    {
        _firstTouchLocation = [[touches anyObject] locationInView:_textView];
        _selectableRange = NSMakeRange(charIndex, _firstCharIndex - charIndex);
    }

    NSAssert(_selectableRange.location >= 0, @"range < 0");
    NSAssert(NSMaxRange(_selectableRange) < _textStorage.length, @"range > max");

    @try
    {
        [_textStorage addAttribute:NSBackgroundColorAttributeName
                             value:_selectionColor range:_selectableRange];
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@", exception);
    }

    [_textStorage endEditing];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInView:self];

    if (self.textSelectable && _isTouchesMoved)
    {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        CGRect rect = CGRectMake(self.firstTouchLocation.x, self.firstTouchLocation.y, 1.0, 1.0);
        
        [menuController setTargetRect:rect inView:self];
        [menuController setMenuVisible:YES animated:YES];
        [self becomeFirstResponder];
        return;
    }
    
    if (!CGRectContainsPoint(_textView.frame, touchLocation))
    {
        return;
    }

    id touchedHotword = [self touchedHotword:touches];
    if(touchedHotword && self.detectionBlock)
    {
        NSRange range = [[touchedHotword objectForKey:@"range"] rangeValue];
        STTweetHotWord hotWord = [touchedHotword[@"hotWord"]integerValue];
        NSString* protocol = touchedHotword[@"protocol"];
        NSString* string = [_cleanText substringWithRange:range];
        
        self.detectionBlock(hotWord, string, protocol, range);
    }
    else
    {
        [super touchesEnded:touches withEvent:event];
    }
}

- (NSInteger)charIndexAtLocation:(CGPoint)touchLocation
{
    NSUInteger glyphIndex = [self.layoutManager glyphIndexForPoint:touchLocation
                                                   inTextContainer:self.textView.textContainer];
    NSRange range = NSMakeRange(glyphIndex, 1);
    
    CGRect boundingRect = [_layoutManager boundingRectForGlyphRange:range
                                                    inTextContainer:self.textView.textContainer];
    
    if (CGRectContainsPoint(boundingRect, touchLocation))
    {
        return [_layoutManager characterIndexForGlyphAtIndex:glyphIndex];
    }
    else
    {
        return NSNotFound;
    }
}

- (id)touchedHotword:(NSSet *)touches
{
    CGPoint point = [[touches anyObject] locationInView:self.textView];
    NSInteger charIndex = [self charIndexAtLocation:point];

    if (charIndex != NSNotFound)
    {
        for (id obj in self.rangesOfHotWords)
        {
            NSRange range = [obj[@"range"] rangeValue];

            if (charIndex >= range.location && charIndex < range.location + range.length)
            {
                return obj;
            }
        }
    }
    return nil;
}

#pragma mark - Lazy Load

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [[UITextView alloc] initWithFrame:self.bounds textContainer:_textContainer];
        _textView.delegate = self;
        _textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textContainer.lineFragmentPadding = 0;
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.userInteractionEnabled = NO;
        [self addSubview:_textView];
    }
    return _textView;
}

- (NSTextContainer *)textContainer
{
    if (!_textContainer)
    {
        _textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)];
    }
    return _textContainer;
}

- (NSLayoutManager *)layoutManager
{
    if (!_layoutManager)
    {
        _layoutManager = [NSLayoutManager new];
        [_layoutManager addTextContainer:self.textContainer];
    }
    return _layoutManager;
}

- (NSTextStorage *)textStorage
{
    if (!_textStorage)
    {
        _textStorage = [NSTextStorage new];
        [_textStorage addLayoutManager:self.layoutManager];
    }
    return _textStorage;
}

- (NSArray *)validProtocols
{
    if (!_validProtocols)
    {
        _validProtocols = @[@"http", @"https"];
    }
    return _validProtocols;
}

- (NSRegularExpression *)urlRegex
{
    if (_urlRegex)
    {
        _urlRegex = [NSRegularExpression regularExpressionWithPattern:URL_REGEXPRESSION options:0 error:nil];
    }
    return _urlRegex;
}

@end
