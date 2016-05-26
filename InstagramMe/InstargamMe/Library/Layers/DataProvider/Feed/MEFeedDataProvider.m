//
//  MEFeedDataProvider.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/25/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedDataProvider.h"
#import "InstagramKit.h"
#import "MEMediaResponse.h"

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
        obj.mComments = [self randomComments];
    }
}

- (NSMutableArray *)randomComments
{
    NSString* c1 = @"Small comment #small";
    NSString* c2 = @"This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome";
//    NSString* c3 = @"London is the capital of Great Britain! #Britain #London #Capital";
//    NSString* c4 = @"Blah blah blah... @m_a_lastname #smart_comment";
    
//    NSArray* comments = @[c1, c2, c3, c4];
//    NSInteger countOfComments = arc4random() % comments.count;
    
    NSMutableArray* result = [NSMutableArray array];
    /*
    for (NSInteger i = 0; i < countOfComments; i++)
    {
        NSInteger index = arc4random() % comments.count;
        [result addObject:comments[index]];
    } */
    [result addObject:c2];
    [result addObject:c1];
//    [result addObject:c1];

    return result;
}

@end
