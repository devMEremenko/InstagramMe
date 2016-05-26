//
//  NSString+MEString.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "NSString+MEStringSize.h"

@implementation NSString (MEString)

- (CGRect)me_commentsBoundingWithSize:(CGSize)size
{
    return [self calulateBoundingRectWithSize:size attributes:[[self class] me_feedCommentsAttributes]];
}

#pragma mark - Attributes

+ (NSDictionary *)me_feedCommentsAttributes
{
    return @{NSForegroundColorAttributeName : [UIColor me_commentsColor],
             NSFontAttributeName : [UIFont me_commentsFont]};
}

+ (NSDictionary *)me_hashTagsAttributes
{
    return @{NSForegroundColorAttributeName : [UIColor me_hashTagsColor],
             NSFontAttributeName : [UIFont me_hashTagsFont]};
}

+ (NSDictionary *)me_userLinksAttributes
{
    return @{NSForegroundColorAttributeName : [UIColor me_userLinksColor],
             NSFontAttributeName : [UIFont me_userLinksFont]};
}

+ (NSAttributedString *)me_truncationAttributedString
{
    return [[NSAttributedString alloc]initWithString:@" [...]" attributes:[self me_truncationAttributes]];
}

+ (NSDictionary *)me_truncationAttributes
{
    return @{NSForegroundColorAttributeName : [UIColor me_truncationColor],
             NSFontAttributeName : [UIFont me_truncationFont]};
}

#pragma mark - Calculations

- (CGRect)calulateBoundingRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size
                              options:[self options]
                           attributes:attributes
                              context:nil];
}

#pragma mark -

- (NSStringDrawingOptions)options
{
    return NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
}

@end
