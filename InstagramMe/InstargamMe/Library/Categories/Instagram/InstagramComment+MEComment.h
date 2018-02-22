//
//  InstagramComment+MEComment.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/28/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "InstagramKit.h"

@interface InstagramComment (MEComment)

@property (assign, nonatomic, getter=isExtended) BOOL extended;

- (void)setCommentCreatedDate:(NSDate *)date;

- (void)setCommentUser:(InstagramUser *)user;

- (void)setCommentText:(NSString *)text;

@end
