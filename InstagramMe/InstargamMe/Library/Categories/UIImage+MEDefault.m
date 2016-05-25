//
//  UIImage+MEDefault.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "UIImage+MEDefault.h"

static NSString* const kLikeImageName = @"like_button";
static NSString* const kLikeHighlightedImageName = @"like_button_highlighted";
static NSString* const kCommentsImageName = @"comments_button";
static NSString* const kReplyImageName = @"reply_button";

@implementation UIImage (MEDefault)

+ (UIImage *)me_likeImage
{
    return [UIImage imageNamed:kLikeImageName];
}

+ (UIImage *)me_likeHighlightedImage
{
    return [UIImage imageNamed:kLikeHighlightedImageName];
}

+ (UIImage *)me_replyImage
{
    return [UIImage imageNamed:kReplyImageName];
}

+ (UIImage *)me_commentsImage
{
    return [UIImage imageNamed:kCommentsImageName];
}

@end
