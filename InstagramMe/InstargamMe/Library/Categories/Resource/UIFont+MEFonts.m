//
//  UIFont+MEFonts.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "UIFont+MEFonts.h"

NSString* const kMESemiboldFontName = @"SFUIText-Semibold";
NSString* const kMERegularFontName = @"SFUIText-Regular";

@implementation UIFont (MEFonts)

+ (UIFont *)me_commentsFont
{
    return [UIFont fontWithName:kMERegularFontName size:16];
}

+ (UIFont *)me_feedUserFont
{
    return [UIFont fontWithName:kMESemiboldFontName size:16];
}

+ (UIFont *)me_viewAllButtonFont
{
    return [UIFont fontWithName:kMERegularFontName size:16];
}

+ (UIFont *)me_hashTagsFont
{
    return [UIFont fontWithName:kMERegularFontName size:16];
}

+ (UIFont *)me_userLinksFont
{
    return [UIFont fontWithName:kMERegularFontName size:16];
}

+ (UIFont *)me_truncationFont
{
    return [UIFont fontWithName:kMERegularFontName size:16];
}

@end
