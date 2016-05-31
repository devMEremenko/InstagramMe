//
//  MEShareContentView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEShareContentView.h"

CGFloat const kMEDefaultButtonSide = 25.f;
CGFloat const kMEDefaultLeftOffset = 19.f;
CGFloat const kMEButtonWidthOffset = 18.f;
CGFloat const kMEButtonHeightOffset = 4.f;
CGFloat const kMESeparatorLeftRightOffset = 16.f;

@implementation MEShareContentView

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
        [self likeButton];
        [self commentsButton];
        [self replyButton];
        [self separator];
    }
    return self;
}

- (void)setupWithMedia:(InstagramMedia *)media
{
    [self.likeButton setupWithMedia:media];
}

#pragma mark - Lazy Load

- (MELikeButton *)likeButton
{
    if (!_likeButton)
    {
        _likeButton = [MELikeButton new];
        [self addSubview:_likeButton];
        
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(kMEDefaultLeftOffset);
            make.centerY.equalTo(self);
            make.height.equalTo(@(kMEDefaultButtonSide));
            make.width.equalTo(@(kMEDefaultButtonSide));
        }];
    }
    return _likeButton;
}

- (MECommentsButton *)commentsButton
{
    if (!_commentsButton)
    {
        _commentsButton = [MECommentsButton new];
        [self addSubview:_commentsButton];
        
        [_commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@(kMEDefaultButtonSide));
            make.width.equalTo(@(kMEDefaultButtonSide));
            make.left.equalTo(_likeButton.mas_right).offset(kMEButtonWidthOffset);
        }];
    }
    return _commentsButton;
}

- (MEReplyButton *)replyButton
{
    if (!_replyButton)
    {
        _replyButton = [MEReplyButton new];
        [self addSubview:_replyButton];
        
        [_replyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@(kMEDefaultButtonSide));
            make.width.equalTo(@(kMEDefaultButtonSide));
            make.left.equalTo(_commentsButton.mas_right).offset(kMEButtonWidthOffset);
        }];
    }
    return _replyButton;
}

- (UIView *)separator
{
    if (!_separator)
    {
        _separator = [UIView new];
        _separator.backgroundColor = [UIColor me_commentSeperatorColor];
        [self addSubview:_separator];
        
        [_separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.bottom.equalTo(self);
            make.left.equalTo(self).with.offset(kMESeparatorLeftRightOffset);
            make.right.equalTo(self).with.offset(-kMESeparatorLeftRightOffset);
        }];
    }
    return _separator;
}

@end
