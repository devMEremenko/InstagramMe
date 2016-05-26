//
//  MECommentLabel.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MECommentLabel.h"
#import "NSString+MEStringSize.h"

NSString* const kMETruncationString = @"... More";

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
        self.truncationToken = kMETruncationString;
        
        [self enableHashTagDetectionWithAttributes:[NSString me_hashTagsAttributes]];
    }
    return self;
}

@end
