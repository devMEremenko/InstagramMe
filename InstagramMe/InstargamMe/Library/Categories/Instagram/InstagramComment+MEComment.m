//
//  InstagramComment+MEComment.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "InstagramComment+MEComment.h"
#import <objc/runtime.h>

@interface InstagramComment ()
@property (strong, nonatomic) NSDate* createdDate;
@property (strong, nonatomic) InstagramUser* user;
@property (copy, nonatomic) NSString* text;
@end

static const void *MEInstagramCommentRunTimeKey = &MEInstagramCommentRunTimeKey;

@implementation InstagramComment (MEComment)

#pragma mark - Setters

- (void)setCommentCreatedDate:(NSDate *)date
{
    self.createdDate = date;
}

- (void)setCommentUser:(InstagramUser *)user
{
    self.user = user;
}

- (void)setCommentText:(NSString *)text
{
    self.text = text;
}

#pragma mark -

- (void)setExtended:(BOOL )extended
{
    objc_setAssociatedObject(self, MEInstagramCommentRunTimeKey, @(extended), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)extended
{
    return [objc_getAssociatedObject(self, MEInstagramCommentRunTimeKey) boolValue];
}

- (BOOL)isExtended
{
    return [self extended];
}

@end
