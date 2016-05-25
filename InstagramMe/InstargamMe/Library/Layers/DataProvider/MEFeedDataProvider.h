//
//  MEFeedDataProvider.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/25/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@class MERecentMedia;

typedef void(^MERecentMediaComletion)(MERecentMedia* recentMedia, NSError* error);

@interface MEFeedDataProvider : NSObject

- (void)recentMediaForCurrentUser:(MERecentMediaComletion)completion;
- (void)nextPageRecentMedia:(MERecentMediaComletion)completion;

@end
