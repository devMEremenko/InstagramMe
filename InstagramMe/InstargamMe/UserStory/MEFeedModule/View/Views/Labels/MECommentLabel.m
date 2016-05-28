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
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    [self tapGesture];
    [self overlayView];
}

- (void)setupWithComment:(InstagramComment *)comment
{
    self.comment = comment;
    self.userInteractionEnabled = YES;
    [self setAttributedTitle:comment.text];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
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
        
        ANDispatchBlockToMainQueue(^{
            self.attributedText = attributedComment;
            [self layoutIfNeeded];
        });
    });
}

- (void)updateConstraints
{
    [self.overlayView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).with.offset(CGRectGetHeight(self.bounds));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    if (self.comment.isExtended)
    {
        [UIView animateWithDuration:0.2
                         animations:^{
                             [self.overlayView layoutIfNeeded];
                         }];
    }
    
    [super updateConstraints];
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
        _overlayView.backgroundColor = [UIColor grayColor];
        [self addSubview:_overlayView];
    }
    return _overlayView;
}

@end
