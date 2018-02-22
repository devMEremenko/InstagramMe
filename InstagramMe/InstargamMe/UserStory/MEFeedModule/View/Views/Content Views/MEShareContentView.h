//
//  MEShareContentView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELikeButton.h"
#import "MEReplyButton.h"
#import "MECommentsButton.h"
#import "MEInstagramKit.h"

@interface MEShareContentView : UIView

@property (strong, nonatomic) MELikeButton* likeButton;
@property (strong, nonatomic) MECommentsButton* commentsButton;
@property (strong, nonatomic) MEReplyButton* replyButton;

@property (strong, nonatomic) UIView* separator;

- (void)setupWithMedia:(InstagramMedia *)media;

@end
