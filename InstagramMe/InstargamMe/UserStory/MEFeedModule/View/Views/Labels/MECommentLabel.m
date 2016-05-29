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

@interface MECommentLabel ()

@property (strong, nonatomic) UITapGestureRecognizer* tapGesture;
@property (strong, nonatomic) UIView* overlayView;
@property (strong, nonatomic) MASConstraint* overlayTopConstraint;
@property (weak, nonatomic) InstagramComment* comment;

@end

@implementation MECommentLabel

#pragma mark - Initialization

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

- (void)setup
{
    self.numberOfLines = 0;
    self.opaque = NO;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    [self tapGesture];
    [self overlayView];
}

- (void)setupWithComment:(InstagramComment *)comment
{
    self.comment = comment;
    self.userInteractionEnabled = YES;
    [self setAttributedTitle:comment.text];
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
        
        ANDispatchBlockToMainQueue(^{
            self.attributedText = attributedComment;
        });
    });
}

#pragma mark - Layouts

- (void)layoutSubviews
{
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
    [UIView animateWithDuration:0.6
                          delay:0
         usingSpringWithDamping:0.3
          initialSpringVelocity:2
                        options:0
                     animations:^{
                         [self.overlayView layoutIfNeeded];
                     } completion:nil];
}

#pragma mark - Lazy Load

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
