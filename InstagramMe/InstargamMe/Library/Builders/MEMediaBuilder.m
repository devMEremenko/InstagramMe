//
//  MEMediaBuilder.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/30/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEMediaBuilder.h"

NSInteger const kMEMediaBuilderCommentsCount = 9;

@implementation MEMediaBuilder

+ (NSArray <InstagramComment *> *)buildInstagramComments
{
    NSMutableArray* results = [NSMutableArray new];
    NSInteger commentsCount = arc4random() % kMEMediaBuilderCommentsCount;
    
    for (NSInteger i = 0; i < commentsCount; i++)
    {
        InstagramComment* comment = [InstagramComment new];
        [comment setCommentText:[self randomText]];
        [results addObject:comment];
    }
    
    return results;
}

+ (NSString *)randomText
{
    NSInteger index = arc4random() % kMEMediaBuilderCommentsCount;
    NSString* key = [NSString stringWithFormat:@"comment_%li", (long) index + 1];
    return NSLocalizedStringFromTable(key, @"Comments", nil);
}

@end
