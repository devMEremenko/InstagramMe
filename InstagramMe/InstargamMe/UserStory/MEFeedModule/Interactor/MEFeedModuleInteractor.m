//
//  MEFeedModuleInteractor.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleInteractor.h"
#import "MEFeedModuleInteractorOutput.h"
#import "MEFeedDataProvider.h"

@interface MEFeedModuleInteractor ()
@property (strong, nonatomic) MEFeedDataProvider* feedDataProvider;
@end

@implementation MEFeedModuleInteractor

#pragma mark -  MEFeedModuleInteractorInput

- (void)findRecentMediaForCurrentUser
{
    [self.feedDataProvider recentMediaForCurrentUser:^(MEMediaResponse* mediaResponse, NSError *error) {
        [self notifyDelegateAboutRecentMedia:mediaResponse error:error];
    }];
}

- (void)findNextPageRecentMedia
{
    [self.feedDataProvider nextPageRecentMedia:^(MEMediaResponse* mediaResponse, NSError *error) {
        [self notifyDelegateAboutNextPageRecentMedia:mediaResponse error:error];
    }];
}

#pragma mark - Output

- (void)notifyDelegateAboutRecentMedia:(MEMediaResponse *)mediaResponse error:(NSError *)error
{
    if (!error)
    {
        [self.output didFindRecentMedia:mediaResponse];
    }
    else
    {
        [self.output failedFindRecentMedia];
    }
}

- (void)notifyDelegateAboutNextPageRecentMedia:(MEMediaResponse *)mediaResponse error:(NSError *)error
{
    if (!error)
    {
        [self.output didFindNextPageRecentMedia:mediaResponse];
    }
    else
    {
        [self.output failedFindRecentMedia];
    }
}

#pragma mark - Lazy Load

- (MEFeedDataProvider *)feedDataProvider
{
    if (!_feedDataProvider)
    {
        _feedDataProvider = [MEFeedDataProvider new];
    }
    return _feedDataProvider;
}

@end