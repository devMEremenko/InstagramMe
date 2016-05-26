//
//  MECommentLabel.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MECommentLabel.h"
#import "NSString+MEStringSize.h"

@implementation MECommentLabel

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.numberOfLines = 0;
        self.font = [UIFont me_commentsFont];
        self.textColor = [UIColor me_commentsColor];
        self.customTruncationEnabled = YES;
        
        [self enableHashTagDetectionWithAttributes:[NSString me_hashTagsAttributes]];
        [self enableUserHandleDetectionWithAttributes:[NSString me_userLinksAttributes]];
        [self setAttributedTruncationToken:[NSString me_truncationAttributedString]];
    }
    return self;
}

@end
