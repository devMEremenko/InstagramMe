//
//  MELikeButton.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@class InstagramMedia;

@interface MELikeButton : UIButton

- (void)setupWithMedia:(InstagramMedia *)media;

- (void)setUnlikedStyle;

- (void)setLikedStyleAnimated:(BOOL)animated;

@end
