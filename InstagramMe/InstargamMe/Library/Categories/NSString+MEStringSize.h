//
//  NSString+MEStringSize.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@interface NSString (MEStringSize)

- (CGRect)me_commentsBoundingWithSize:(CGSize)size;

#pragma mark - Attributes

+ (NSDictionary *)me_hashTagsAttributes;

@end
