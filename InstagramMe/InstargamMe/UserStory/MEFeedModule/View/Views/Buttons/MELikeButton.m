//
//  MELikeButton.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELikeButton.h"

@implementation MELikeButton

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setImage:[UIImage me_likeImage] forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateHighlighted];
    }
    return self;
}


@end
