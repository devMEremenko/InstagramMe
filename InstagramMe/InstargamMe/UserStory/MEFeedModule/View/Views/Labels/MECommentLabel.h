//
//  MECommentLabel.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@class InstagramComment;
@protocol MECommentLabelDelegate;

#import "MELabel.h"

@interface MECommentLabel : UIView

@property (weak, nonatomic) id <MECommentLabelDelegate> delegate;

- (void)setupWithComment:(InstagramComment *)comment;

@end

@protocol MECommentLabelDelegate <NSObject>
@optional

- (void)didTapCommentLabel:(MECommentLabel *)label;

@end