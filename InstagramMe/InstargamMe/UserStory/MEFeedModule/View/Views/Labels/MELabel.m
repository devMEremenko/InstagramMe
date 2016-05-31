//
//  MELabel.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELabel.h"

@interface MELabel ()

@property (strong, nonatomic) NSTextContainer* container;
@property (strong, nonatomic) NSLayoutManager* layoutManager;
@property (strong, nonatomic) NSTextStorage* storage;
@end

@implementation MELabel
@synthesize contentAlignment = _contentAlignment;

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
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
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
}

#pragma mark - Layouts

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)setNeedsDisplay
{
    ANDispatchBlockToMainQueue(^{
        [super setNeedsDisplay];
    });
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (!self.attributedText)
    {
        return;
    }
    
    NSTextContainer* container = [self containerWithUpdatingAttributes];
    container.size = rect.size;
    
    NSRange glyphRange = [self.layoutManager glyphRangeForTextContainer:container];
    CGRect frame = [self.layoutManager usedRectForTextContainer:container];
    CGPoint point = [self alignOffset:rect.size containerSize:CGRectIntegral(frame).size];

    [self.layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:point];
    [self.layoutManager drawGlyphsForGlyphRange:glyphRange atPoint:point];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (!self.attributedText)
    {
        return [super sizeThatFits:size];
    }
    
    NSTextContainer* container = [self containerWithUpdatingAttributes];
    container.size = size;
    [self.storage setAttributedString:self.attributedText];
    
    CGRect frame = [self.layoutManager usedRectForTextContainer:container];
    return CGRectIntegral(frame).size;
}

- (void)sizeToFit
{
    CGSize size = CGSizeMake(self.bounds.size.width, CGFLOAT_MAX);
    CGRect frame = self.frame;
    frame.size = [self sizeThatFits:size];
    self.frame = frame;
}

- (NSTextContainer *)containerWithUpdatingAttributes
{
    NSTextContainer* container = self.container;
    container.lineBreakMode = self.lineBreakMode;
    container.lineFragmentPadding = self.padding;
    container.maximumNumberOfLines = self.numberOfLines;
    return container;
}

#pragma mark - Setters

- (void)setText:(NSString *)text
{
    _text = text;
    
    if (text)
    {
        self.attributedText = [[NSAttributedString alloc]initWithString:text];
    }
    else
    {
        self.attributedText = nil;
    }
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    [self.storage setAttributedString:self.attributedText];
    [self setNeedsDisplay];
}

- (void)setNumberOfLines:(NSInteger)numberOfLines
{
    _numberOfLines = numberOfLines;
    [self setNeedsDisplay];
}

- (void)setContentAlignment:(MEContentAlignment)contentAlignment
{
    _contentAlignment = contentAlignment;
    [self setNeedsDisplay];
}

- (void)setPadding:(CGFloat)padding
{
    _padding = padding;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self setNeedsDisplay];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    _lineBreakMode = lineBreakMode;
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self setNeedsDisplay];
}

- (void)setParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    _paragraphStyle = paragraphStyle;
    [self setNeedsDisplay];
}

- (void)setShadow:(NSShadow *)shadow
{
    _shadow = shadow;
    [self setNeedsDisplay];
}

#pragma mark - Getters

- (MEContentAlignment)contentAlignment
{
    if (_contentAlignment == ContentAlignmentNone)
    {
        _contentAlignment = ContentAlignmentTopLeft;
    }
    return _contentAlignment;
}

- (NSLayoutManager *)layoutManager
{
    if (!_layoutManager)
    {
        _layoutManager = [NSLayoutManager new];
        [_layoutManager addTextContainer:self.container];
    }
    return _layoutManager;
}

- (NSTextContainer *)container
{
    if (!_container)
    {
        _container = [NSTextContainer new];
    }
    return _container;
}

- (NSTextStorage *)storage
{
    if (!_storage)
    {
        _storage = [NSTextStorage new];
        [_storage addLayoutManager:self.layoutManager];
    }
    return _storage;
}

#pragma mark -

- (CGPoint)alignOffset:(CGSize)viewSize containerSize:(CGSize)containerSize
{
    CGFloat xMargin = viewSize.width - containerSize.width;
    CGFloat yMargin = viewSize.height = containerSize.height;
    
    switch (self.contentAlignment)
    {
        case ContentAlignmentCenter: return CGPointMake(MAX(xMargin / 2, 0), MAX(yMargin / 2, 0)); break;
        case ContentAlignmentTop: return CGPointMake(MAX(xMargin / 2, 0), 0); break;
        case ContentAlignmentBottom: return CGPointMake(MAX(xMargin / 2, 0), MAX(yMargin, 0)); break;
        case ContentAlignmentLeft: return CGPointMake(0, MAX(yMargin / 2, 0)); break;
        case ContentAlignmentTopLeft: return CGPointMake(0, 0); break;
        case ContentAlignmentTopRight: return CGPointMake(MAX(xMargin, 0), 0); break;
        case ContentAlignmentBottomLeft: return CGPointMake(0, MAX(yMargin, 0)); break;
        case ContentAlignmentBottomRight: return CGPointMake(MAX(xMargin, 0), MAX(yMargin, 0)); break;
        default: break;
    }
    return CGPointZero;
}

@end
