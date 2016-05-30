//
//  InstagramMedia+MEMedia.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "InstagramKit.h"

@interface InstagramMedia (MEMedia)

@property (assign, nonatomic, getter=isLiked) BOOL liked;

- (void)setMediaComments:(NSArray <InstagramComment *> *)comments;

@end
