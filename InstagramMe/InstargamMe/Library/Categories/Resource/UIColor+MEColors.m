//
//  UIColor+MEColors.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#define DIV 255.f
#define UIColorWithRGB(r, g, b, a) [UIColor colorWithRed:r/DIV green:g/DIV blue:b/DIV alpha:a]

#import "UIColor+MEColors.h"

@implementation UIColor (MEColors)

// Feed

+ (UIColor *)me_feedBarColor
{
    return UIColorWithRGB(250, 250, 250, 1);
}

+ (UIColor *)me_feedUserColor
{
    return UIColorWithRGB(38, 38, 38, 1);
}

+ (UIColor *)me_feedImageCornerColor
{
    return  UIColorWithRGB(155, 155, 155, 1);
}

+ (UIColor *)me_feedHeaderSeparatorColor
{
    return UIColorWithRGB(230, 230, 230, 1);
}

+ (UIColor *)me_commentsColor
{
    return UIColorWithRGB(38, 38, 38, 1);
}

+ (UIColor *)me_commentSeperatorColor
{
    return UIColorWithRGB(230, 230, 230, 1);
}

+ (UIColor *)me_feedImageColor
{
    return UIColorWithRGB(204, 221, 255, 1);
}

+ (UIColor *)me_viewAllButtonTitleColor
{
    return UIColorWithRGB(171, 173, 174, 1);
}

+ (UIColor *)me_viewAllButtonHighlightedColor
{
    return UIColorWithRGB(141, 143, 144, 1);
}

+ (UIColor *)me_hashTagsColor
{
    return UIColorWithRGB(0, 53, 105, 1);
}

+ (UIColor *)me_userLinksColor
{
    return UIColorWithRGB(64, 93, 230, 1);
}

+ (UIColor *)me_truncationColor
{
    return UIColorWithRGB(0, 0, 0, 0.3);
}

@end
