//
//  MESTCommentLabel.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MESTCommentLabel.h"
#import "NSString+MEString.h"

@implementation MESTCommentLabel

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setAttributes:[NSString me_feedCommentsAttributes]];
        [self setAttributes:[NSString me_hashTagsAttributes] hotWord:STTweetHashtag];
        [self setAttributes:[NSString me_userLinksAttributes] hotWord:STTweetHandle];
        [self setAttributes:[NSString me_userLinksAttributes] hotWord:STTweetLink];
    }
    return self;
}

@end
