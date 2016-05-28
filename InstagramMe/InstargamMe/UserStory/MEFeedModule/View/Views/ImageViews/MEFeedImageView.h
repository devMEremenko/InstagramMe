//
//  MEFeedImageView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEImageView.h"

@class InstagramMedia;

@interface MEFeedImageView : MEImageView

- (void)setupWithMedia:(InstagramMedia *)media;

@end
