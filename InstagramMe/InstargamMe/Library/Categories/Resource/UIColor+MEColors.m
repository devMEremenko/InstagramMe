//
//  UIColor+MEColors.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#define DIV 255.f
#define UIColorWithRed(r, g, b, a) [UIColor colorWithRed:r/DIV green:g/DIV blue:b/DIV alpha:a]

#import "UIColor+MEColors.h"

@implementation UIColor (MEColors)

// Feed

+ (UIColor *)me_feedBarColor
{
    return UIColorWithRed(250, 250, 250, 1);
}

+ (UIColor *)me_feedUserColor
{
    return UIColorWithRed(38, 38, 38, 1);
}

+ (UIColor *)me_feedImageCornerColor
{
    return  UIColorWithRed(155, 155, 155, 1);
}

+ (UIColor *)me_feedHeaderSeparatorColor
{
    return UIColorWithRed(230, 230, 230, 1);
}

+ (UIColor *)me_commentsColor
{
    return UIColorWithRed(38, 38, 38, 1);
}

+ (UIColor *)me_commentSeperatorColor
{
    return UIColorWithRed(230, 230, 230, 1);
}

+ (UIColor *)me_feedImageColor
{
    return UIColorWithRed(204, 221, 255, 1);
}

+ (UIColor *)me_viewAllButtonTitleColor
{
    return UIColorWithRed(64, 93, 230, 1);
}

+ (UIColor *)me_viewAllButtonHighlightedColor
{
    return UIColorWithRed(34, 63, 240, 1);
}

+ (UIColor *)me_hashTagsColor
{
    return UIColorWithRed(0, 53, 105, 1);
}

+ (UIColor *)me_userLinksColor
{
    return UIColorWithRed(64, 93, 230, 1);
}

+ (UIColor *)me_truncationColor
{
    return UIColorWithRed(0, 0, 0, 0.3);
}

@end
