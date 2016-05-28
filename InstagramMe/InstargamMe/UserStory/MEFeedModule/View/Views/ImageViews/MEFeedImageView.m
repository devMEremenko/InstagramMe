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

@implementation MEFeedImageView

- (void)setupWithMedia:(InstagramMedia *)media
{
    [self yy_setImageWithURL:media.standardResolutionImageURL
                     options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
}

@end
