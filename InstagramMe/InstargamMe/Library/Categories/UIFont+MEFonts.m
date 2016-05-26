//
//  UIFont+MEFonts.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "UIFont+MEFonts.h"

NSString* const kMEHelveticaRegularFont = @"Helvetica";
NSString* const kMEHelveticaBoldFont = @"Helvetica-Bold";

@implementation UIFont (MEFonts)

+ (UIFont *)me_commentsFont
{
    return [UIFont fontWithName:kMEHelveticaRegularFont size:18];
}

+ (UIFont *)me_hashTagsFont
{
    return [UIFont fontWithName:kMEHelveticaBoldFont size:18];
}

@end
