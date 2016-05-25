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
    [self.feedDataProvider recentMediaForCurrentUser:^(MERecentMedia* recentMedia, NSError *error) {
        [self notifyDelegateAboutRecentMedia:recentMedia error:error];
    }];
}

- (void)findNextPageRecentMedia
{
    [self.feedDataProvider nextPageRecentMedia:^(MERecentMedia* recentMedia, NSError *error) {
        [self notifyDelegateAboutNextPageRecentMedia:recentMedia error:error];
    }];
}

#pragma mark - Output

- (void)notifyDelegateAboutRecentMedia:(MERecentMedia *)recentMedia error:(NSError *)error
{
    if (!error)
    {
        [self.output didFindRecentMedia:recentMedia];
    }
    else
    {
        [self.output failedFindRecentMedia];
    }
}

- (void)notifyDelegateAboutNextPageRecentMedia:(MERecentMedia *)recentMedia error:(NSError *)error
{
    if (!error)
    {
        [self.output didFindNextPageRecentMedia:recentMedia];
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