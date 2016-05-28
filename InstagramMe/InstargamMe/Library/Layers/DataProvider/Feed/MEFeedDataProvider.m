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
        [obj setMediaComments:[self randomComments]];
    }
}

- (NSMutableArray *)randomComments
{
    NSString* c1 = @"@olegpanfyorov1988 Small comment #small about everything";
    NSString* c2 = @"@m_a_eremenko This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome @m_a_eremenko This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome @m_a_eremenko This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome This is awesome! This is awesome! This is awesome! #awesome";
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
    
    InstagramComment* comment1 = [InstagramComment new];
    [comment1 setCommentCreatedDate:[NSDate date]];
    [comment1 setCommentText:c2];
    
    InstagramComment* comment2 = [InstagramComment new];
    [comment2 setCommentCreatedDate:[NSDate date]];
    [comment2 setCommentText:c2];
    
    [result addObject:comment1];
    [result addObject:comment2];

    return result;
}

@end
