//
//  MEReplyButton.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEReplyButton.h"

@implementation MEReplyButton

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setImage:[UIImage me_replyImage] forState:UIControlStateNormal];
    }
    return self;
}

@end
