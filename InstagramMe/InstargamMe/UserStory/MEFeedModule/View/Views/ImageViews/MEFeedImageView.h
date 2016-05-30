//
//  MEFeedImageView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEImageView.h"
#import "MELikeImageView.h"

@class InstagramMedia;
@protocol MEFeedImageViewDelegate;

@interface MEFeedImageView : MEImageView

@property (strong, nonatomic) MELikeImageView* likeImageView;
@property (weak, nonatomic) id <MEFeedImageViewDelegate> delegate;

- (void)setupWithMedia:(InstagramMedia *)media;

@end

@protocol MEFeedImageViewDelegate <NSObject>
@optional

- (void)feedImageView:(MEFeedImageView *)feedImage didPressLikeImageView:(MELikeImageView *)imageView;

@end