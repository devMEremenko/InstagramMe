//
//  MEFeedModuleViewInput.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

@class MEMediaResponse;

@protocol MEFeedModuleViewInput <NSObject>

- (void)setupInitialState;

- (void)didFindRecentMedia:(MEMediaResponse *)recentMedia;

- (void)didFindNextPageRecentMedia:(MEMediaResponse *)recentMedia;

- (void)failedFindRecentMedia;

@end