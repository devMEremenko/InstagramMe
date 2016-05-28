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
            [self layoutIfNeeded];
        });
    });
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

@end
