//
//  MECommentLabel.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MECommentLabel.h"
#import "MEInstagramKit.h"
#import "MEStringBuilder.h"
#import "AsyncDisplayKit.h"
#import "METextNode.h"
#import "NSString+MEString.h"

NSInteger const kMEWordsPerSecond = 200;

@interface MECommentLabel () <ASTextNodeDelegate>

@property (strong, nonatomic) UITapGestureRecognizer* tapGesture;
@property (strong, nonatomic) UIView* overlayView;
@property (strong, nonatomic) MASConstraint* overlayTopConstraint;
@property (weak, nonatomic) InstagramComment* comment;

@property (strong, nonatomic) METextNode* textNode;

@end

@implementation MECommentLabel

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    [self tapGesture];
    [self textNode];
    [self overlayView];
}

#pragma mark - Public

- (void)setupWithComment:(InstagramComment *)comment
{
    self.comment = comment;
    self.userInteractionEnabled = YES;
    [self setAttributedTitle:comment.text];
    
    [self updateConstraints];
}

#pragma mark - Actions

- (void)actionDidTapLabel:(UITapGestureRecognizer *)tapGesture
{
    self.comment.extended = YES;
    self.userInteractionEnabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(didTapCommentLabel:)])
    {
        [self.delegate didTapCommentLabel:self];
    }
}

#pragma mark - Setters

- (void)setAttributedTitle:(NSString *)text
{
    if (!text)
    {
        return;
    }
    
    ANDispatchBlockToBackgroundQueue(^{
        
        NSAttributedString* attributedComment = [MEStringBuilder buildCommentsString:text];
        self.textNode.attributedText = attributedComment;
    });
}

#pragma mark - Layouts

- (void)layoutSubviews
{
    CGSize size = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGRect textRect = [self.comment.text me_commentsBoundingWithSize:size];
    
    self.textNode.frame = me_ceilRect(textRect);
    
    [super layoutSubviews];
    [self updateConstraints];
}

- (void)updateConstraints
{
    [self.overlayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(CGRectGetHeight(self.bounds)).priorityHigh();
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    if (self.comment.isExtended)
    {
        [self animateOverlayView];
    }
    [super updateConstraints];
}

#pragma mark - Animation

- (void)animateOverlayView
{
    CGFloat duration = kMEWordsPerSecond / (self.comment.text.length + 1);
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.65
          initialSpringVelocity:2
                        options:0
                     animations:^{
                         [self.overlayView layoutIfNeeded];
                     } completion:nil];
}

#pragma mark - Lazy Load

- (METextNode *)textNode
{
    if (!_textNode)
    {
        _textNode = [METextNode new];
        _textNode.delegate = self;
        _textNode.layerBacked = YES;
        _textNode.backgroundColor = [UIColor clearColor];
        
        [self addSubnode:_textNode];
    }
    return _textNode;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture)
    {
        _tapGesture = [UITapGestureRecognizer new];
        [_tapGesture addTarget:self action:@selector(actionDidTapLabel:)];
        [self addGestureRecognizer:_tapGesture];
    }
    return _tapGesture;
}

- (UIView *)overlayView
{
    if (!_overlayView)
    {
        _overlayView = [UIView new];
        _overlayView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_overlayView];
    }
    return _overlayView;
}

@end
