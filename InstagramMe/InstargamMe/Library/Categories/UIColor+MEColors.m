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

+ (UIColor *)me_commentsColor
{
    return [UIColor colorWithWhite:0.f alpha:0.6];
}

+ (UIColor *)me_commentSeperatorColor
{
    return [UIColor colorWithWhite:0.f alpha:0.2];
}

+ (UIColor *)me_hashTagsColor
{
    return UIColorWithRed(64, 93, 230, 1);
}

@end
