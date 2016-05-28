//
//  NSString+MEString.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@interface NSString (MEString)

- (CGRect)me_commentsBoundingWithSize:(CGSize)size;

+ (NSAttributedString *)me_truncationAttributedString;

#pragma mark - Attributes

+ (NSDictionary *)me_feedCommentsAttributes;
+ (NSDictionary *)me_hashTagsAttributes;
+ (NSDictionary *)me_userLinksAttributes;

@end
