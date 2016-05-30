//
//  MECommentsContentView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//
@class InstagramMedia;
@class ASTextNode;

#import "MEViewAllButton.h"
#import "InstagramMe-Swift.h"
#import "MESTCommentLabel.h"
#import "MECommentLabel.h"

@interface MECommentsContentView : UIView

@property (strong, nonatomic) MEViewAllButton* allCommentsButton;

@property (strong, nonatomic) MECommentLabel* firstCommentLabel; // or use MESTCommentLabel
@property (strong, nonatomic) MECommentLabel* secondCommentLabel; // or use MESTCommentLabel

+ (CGFloat)heightWithMedia:(InstagramMedia *)media inSize:(CGSize)inSize;

- (void)setupWithMedia:(InstagramMedia *)media;

- (void)handleTapOnCommentLabel:(MECommentLabel *)label;

@end
