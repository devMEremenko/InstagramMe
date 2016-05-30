//
//  MEFeedImageView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedImageView.h"
#import "MEInstagramKit.h"
#import "YYWebImage.h"

CGFloat const kMEMaxLikeSide = 280.f;
CGFloat const kMELikeSideScale = 2.25f;

@implementation MEFeedImageView

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self likeImageView];
}

- (void)setup
{
    self.backgroundColor = [UIColor me_feedImageColor];
    [self addGestureRecognizers];
}

#pragma mark - Gestures

- (void)actionDidDoubleTapGesture:(UITapGestureRecognizer *)recognizer
{
    [self.likeImageView showLike];
    
    if ([self.delegate respondsToSelector:@selector(feedImageView:didPressLikeImageView:)])
    {
        [self.delegate feedImageView:self didPressLikeImageView:self.likeImageView];
    }
}

- (void)setupWithMedia:(InstagramMedia *)media
{
    [self yy_setImageWithURL:media.standardResolutionImageURL options:[self options]];
}

#pragma mark - Helpers

- (void)addGestureRecognizers
{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* tapGesture = [UITapGestureRecognizer new];
    tapGesture.numberOfTapsRequired = 2;
    [tapGesture addTarget:self action:@selector(actionDidDoubleTapGesture:)];
    
    [self addGestureRecognizer:tapGesture];
}

- (YYWebImageOptions)options
{
    return YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation;
}

#pragma mark - Lazy Load

- (MELikeImageView *)likeImageView
{
    if (!_likeImageView)
    {
        _likeImageView = [MELikeImageView new];
        _likeImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_likeImageView];
        
        [_likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            CGFloat side = ceilf(CGRectGetWidth(self.bounds) / kMELikeSideScale);
            side = side < kMEMaxLikeSide ? side : kMEMaxLikeSide;
            
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.height.equalTo(@(side));
            make.width.equalTo(@(side));
        }];
    }
    return _likeImageView;
}

@end
