//
//  MECommentsContentView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//
@class InstagramMedia;

#import "MECommentLabel.h"

@interface MECommentsContentView : UIView

@property (strong, nonatomic) UIButton* viewAllCommentsButton;

@property (strong, nonatomic) MECommentLabel* firstCommentLabel;
@property (strong, nonatomic) MECommentLabel* secondCommentLabel;

+ (CGFloat)heightWithMedia:(InstagramMedia *)media inSize:(CGSize)inSize;

- (void)setupWithMedia:(InstagramMedia *)media;

@end
