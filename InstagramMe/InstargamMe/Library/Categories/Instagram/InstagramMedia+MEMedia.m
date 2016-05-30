//
//  InstagramMedia+MEMedia.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "InstagramMedia+MEMedia.h"
#import <objc/runtime.h>

NSString* const kMEInstagramMediaComments = @"self.mComments";
static const void *MEInstagramMediaIsLikedRunTimeKey = &MEInstagramMediaIsLikedRunTimeKey;

@implementation InstagramMedia (MEMedia)

- (void)setMediaComments:(NSArray <InstagramComment *> *)comments
{
    NSMutableArray* mutableComments = [NSMutableArray arrayWithArray:comments];
    
    [self willChangeValueForKey:kMEInstagramMediaComments];
    [self setValue:mutableComments forKeyPath:kMEInstagramMediaComments];
    [self didChangeValueForKey:kMEInstagramMediaComments];
}

#pragma mark -

- (void)setLiked:(BOOL)liked
{
    objc_setAssociatedObject(self, MEInstagramMediaIsLikedRunTimeKey, @(liked), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)liked
{
    return [objc_getAssociatedObject(self, MEInstagramMediaIsLikedRunTimeKey) boolValue];
}

- (BOOL)isLiked
{
    return [self liked];
}

@end
