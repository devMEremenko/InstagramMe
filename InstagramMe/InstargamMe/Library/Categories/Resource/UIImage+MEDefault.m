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

static NSString* const kDoubleLikeName = @"white_like";

static NSString* const kLogoImageName = @"insta-logo";
static NSString* const kDirectImageName = @"direct_button";
static NSString* const kAdditionallyImageName = @"additionally-button";

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

+ (UIImage *)me_doubleLikeImage
{
    return [UIImage imageNamed:kDoubleLikeName];
}

+ (UIImage *)me_logoImage
{
    return [UIImage imageNamed:kLogoImageName];
}

+ (UIImage *)me_directImage
{
    return [UIImage imageNamed:kDirectImageName];
}

+ (UIImage *)me_additionallyImage
{
    return [UIImage imageNamed:kAdditionallyImageName];
}

@end
