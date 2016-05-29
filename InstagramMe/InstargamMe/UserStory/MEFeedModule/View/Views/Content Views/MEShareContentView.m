//
//  MEShareContentView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEShareContentView.h"

CGFloat const kDefaultButtonSide = 25.f;
CGFloat const kDefaultLeftOffset = 20.f;
CGFloat const kButtonWidthOffset = 18.f;
CGFloat const kButtonHeightOffset = 4.f;

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

#pragma mark - Lazy Load

- (MELikeButton *)likeButton
{
    if (!_likeButton)
    {
        _likeButton = [MELikeButton new];
        [self addSubview:_likeButton];
        
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(kDefaultLeftOffset);
            make.centerY.equalTo(self);
            make.height.equalTo(@(kDefaultButtonSide));
            make.width.equalTo(@(kDefaultButtonSide));
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
            make.height.equalTo(@(kDefaultButtonSide));
            make.width.equalTo(@(kDefaultButtonSide));
            make.left.equalTo(_likeButton.mas_right).offset(kButtonWidthOffset);
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
            make.height.equalTo(@(kDefaultButtonSide));
            make.width.equalTo(@(kDefaultButtonSide));
            make.left.equalTo(_commentsButton.mas_right).offset(kButtonWidthOffset);
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
            make.left.equalTo(self).with.offset(kButtonWidthOffset);
            make.right.equalTo(self).with.offset(-kButtonWidthOffset);
        }];
    }
    return _separator;
}

@end
