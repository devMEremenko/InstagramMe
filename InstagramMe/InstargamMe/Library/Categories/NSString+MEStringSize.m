//
//  NSString+MEStringSize.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "NSString+MEStringSize.h"

@implementation NSString (MEStringSize)

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
