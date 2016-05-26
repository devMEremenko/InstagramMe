//
//  MEFeedModuleInteractorOutput.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

@class MEMediaResponse;

@protocol MEFeedModuleInteractorOutput <NSObject>

- (void)didFindRecentMedia:(MEMediaResponse *)mediaResponse;

- (void)didFindNextPageRecentMedia:(MEMediaResponse *)mediaResponse;

- (void)failedFindRecentMedia;

@end