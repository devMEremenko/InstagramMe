//
//  MEFeedHeaderImageView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEImageView.h"
#import "MEInstagramKit.h"

@interface MEFeedHeaderImageView : MEImageView

- (void)setupWithMedia:(InstagramMedia *)media;

@end
