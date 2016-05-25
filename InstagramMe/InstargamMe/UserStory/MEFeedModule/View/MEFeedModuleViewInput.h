//
//  MEFeedModuleViewInput.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

@class MERecentMedia;

@protocol MEFeedModuleViewInput <NSObject>

- (void)setupInitialState;

- (void)didFindRecentMedia:(MERecentMedia *)recentMedia;

- (void)didFindNextPageRecentMedia:(MERecentMedia *)recentMedia;

- (void)failedFindRecentMedia;

@end