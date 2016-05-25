//
//  MEFeedDataProvider.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/25/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedDataProvider.h"
#import "InstagramKit.h"
#import "MERecentMedia.h"

@interface MEFeedDataProvider ()

@property (strong, nonatomic) InstagramPaginationInfo* paginationInfo;
@property (copy, nonatomic) MERecentMediaComletion recentCompletion;

@end

NSInteger const MERequestedMediaCount = 10;

@implementation MEFeedDataProvider

#pragma mark - Public

- (void)recentMediaForCurrentUser:(MERecentMediaComletion)completion
{
    self.paginationInfo = nil;
    [self nextPageRecentMedia:completion];
}

- (void)nextPageRecentMedia:(MERecentMediaComletion)completion
{
    self.recentCompletion = completion;
    
    [[InstagramEngine sharedEngine]
     getSelfRecentMediaWithCount:MERequestedMediaCount
     maxId:self.paginationInfo.nextMaxId
     success:^(NSArray<InstagramMedia *> * _Nonnull media, InstagramPaginationInfo * _Nonnull paginationInfo) {
         
         self.paginationInfo = paginationInfo;
         [self notifyDelegateWithMedia:media andError:nil];
         
     } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
         
         [self notifyDelegateWithMedia:nil andError:error];
     }];
}

#pragma mark - Private

- (void)notifyDelegateWithMedia:(NSArray<InstagramMedia *> *)media andError:(NSError *)error
{
    MERecentMedia* recentMedia = [MERecentMedia new];
    recentMedia.media = media;
    
    if (self.recentCompletion)
    {
        self.recentCompletion(recentMedia, error);
    }
}

@end
