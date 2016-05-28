//
//  InstagramMedia+MEMedia.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "InstagramMedia+MEMedia.h"

NSString* const kMEInstagramMediaComments = @"self.mComments";

@implementation InstagramMedia (MEMedia)

- (void)setMediaComments:(NSArray <InstagramComment *> *)comments
{
    NSMutableArray* mutableComments = [NSMutableArray arrayWithArray:comments];
    
    [self willChangeValueForKey:kMEInstagramMediaComments];
    [self setValue:mutableComments forKeyPath:kMEInstagramMediaComments];
    [self didChangeValueForKey:kMEInstagramMediaComments];
}

@end
