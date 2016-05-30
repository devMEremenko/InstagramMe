//
//  MEFeedDataProvider.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/25/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedDataProvider.h"
#import "MEInstagramKit.h"
#import "MEMediaResponse.h"
#import "MEMediaBuilder.h"

@interface MEFeedDataProvider ()

@property (strong, nonatomic) InstagramPaginationInfo* paginationInfo;
@property (copy, nonatomic) MERecentMediaComletion recentCompletion;

@end

NSInteger const MERequestedMediaCount = 10;

@implementation MEFeedDataProvider

#pragma mark - Public

- (void)recentMediaForCurrentUser:(MERecentMediaComletion)completion
{
    self.paginationInfo = [InstagramPaginationInfo new];
    [self nextPageRecentMedia:completion];
}

- (void)nextPageRecentMedia:(MERecentMediaComletion)completion
{
    if (!self.paginationInfo)
    {
        [self notifyDelegateWithMedia:nil andError:nil];
        return;
    }
    
    self.recentCompletion = completion;
    
    [[InstagramEngine sharedEngine]
     getSelfRecentMediaWithCount:MERequestedMediaCount
     maxId:self.paginationInfo.nextMaxId
     success:^(NSArray<InstagramMedia *> * _Nonnull media, InstagramPaginationInfo * _Nonnull paginationInfo) {
         
         self.paginationInfo = paginationInfo;
         [self hackWithMedia:media];
         [self notifyDelegateWithMedia:media andError:nil];
         
     } failure:^(NSError * _Nonnull error, NSInteger serverStatusCode) {
         
         [self notifyDelegateWithMedia:nil andError:error];
     }];
}

#pragma mark - Private

- (void)notifyDelegateWithMedia:(NSArray<InstagramMedia *> *)recentMedia andError:(NSError *)error
{
    MEMediaResponse* mediaResponse = [MEMediaResponse new];
    mediaResponse.recentMedia = recentMedia;
    
    if (self.recentCompletion)
    {
        self.recentCompletion(mediaResponse, error);
    }
}


#pragma mark - HACK -

- (void)hackWithMedia:(NSArray<InstagramMedia *>*)media
{
    // Because Instagram return only count of comments without description...
    for (InstagramMedia* obj in media)
    {
        [obj setMediaComments:[MEMediaBuilder buildInstagramComments]];
    }
}


@end
