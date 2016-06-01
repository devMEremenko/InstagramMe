//
//  MEFeedHeaderView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedHeaderView.h"

@implementation MEFeedHeaderView

NSInteger const kMEImageLeftOffset = 18;
NSInteger const kMEImageSide = 36;

NSInteger const kMEUserLabelLeftOffset = 10;
NSInteger const kMEUserLabelRightOffset = 10;
NSInteger const kMEUserLabelHeight = 36;

NSInteger const kMEAdditionallyButtonRightOffset = 20;
NSInteger const kMEAdditionallyButtonSide = 18;

NSInteger const KMESeparatorHeight = 1;

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self additionallyButton];
        [self separator];
    }
    return self;
}

#pragma mark - Public

- (void)setupWithMedia:(InstagramMedia *)media
{
    self.userNameLabel.text = media.user.username;
    [self.imageView setupWithMedia:media];
    
    [self layoutSubviews];
}

#pragma mark - Layouts

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(kMEImageLeftOffset,
                                  CGRectGetMidY(self.bounds) - kMEImageSide / 2,
                                  kMEImageSide, kMEImageSide);
    
    CGFloat xButton = CGRectGetWidth(self.bounds) - kMEAdditionallyButtonRightOffset - kMEAdditionallyButtonSide;
    
    _additionallyButton.frame = CGRectMake(xButton,
                                           CGRectGetMidY(self.bounds) - kMEAdditionallyButtonSide / 2,
                                           kMEAdditionallyButtonSide, kMEAdditionallyButtonSide);
    
    CGFloat labelOffsets = CGRectGetMaxX(_imageView.frame) + kMEUserLabelLeftOffset + CGRectGetWidth(_additionallyButton.frame) + kMEAdditionallyButtonRightOffset + kMEUserLabelRightOffset;
    
    CGFloat labelWidth = CGRectGetWidth(self.bounds) - labelOffsets;
    
    _userNameLabel.frame = CGRectMake(CGRectGetMaxX(_imageView.frame) + kMEUserLabelLeftOffset,
                                      CGRectGetMidY(_imageView.frame) - kMEImageSide / 2,
                                      labelWidth, kMEUserLabelHeight);
    
    _separator.frame = CGRectMake(0,
                                  CGRectGetHeight(self.bounds) - KMESeparatorHeight,
                                  CGRectGetWidth(self.bounds), KMESeparatorHeight);
}

#pragma mark - Lazy Load

- (UILabel *)userNameLabel
{
    if (!_userNameLabel)
    {
        _userNameLabel = [UILabel new];
        _userNameLabel.font = [UIFont me_feedUserFont];
        _userNameLabel.textColor = [UIColor me_feedUserColor];
        [self addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

- (MEFeedHeaderImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [MEFeedHeaderImageView new];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (MEAdditionallyButton *)additionallyButton
{
    if (!_additionallyButton)
    {
        _additionallyButton = [MEAdditionallyButton new];
        [self addSubview:_additionallyButton];
    }
    return _additionallyButton;
}

- (UIView *)separator
{
    if (!_separator)
    {
        _separator = [UIView new];
        _separator.backgroundColor = [UIColor me_feedHeaderSeparatorColor];
        [self addSubview:_separator];
    }
    return _separator;
}

@end
