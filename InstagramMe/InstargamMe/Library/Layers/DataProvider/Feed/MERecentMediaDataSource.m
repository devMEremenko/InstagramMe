
//
//  MERecentMediaDataSource.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MERecentMediaDataSource.h"
#import "MEInstagramKit.h"
#import "MEMediaResponse.h"

@interface MERecentMediaDataSource ()

@property (strong, nonatomic) NSMutableArray <InstagramMedia *>* media;

@end

@implementation MERecentMediaDataSource

#pragma mark - MEFeedDataSourceProtocol

- (NSInteger)numberOfItemSections
{
    return self.media.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (InstagramMedia *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.media[indexPath.section];
}

- (void)setMediaFromResponse:(MEMediaResponse *)mediaResponse
{
    self.media = [NSMutableArray arrayWithArray:mediaResponse.recentMedia];
}

- (void)addMediaFromResponse:(MEMediaResponse *)mediaResponse
{
    [self.media addObjectsFromArray:mediaResponse.recentMedia];
}

#pragma mark - Lazy Load

- (NSMutableArray<InstagramMedia *> *)media
{
    if (!_media)
    {
        _media = [NSMutableArray new];
    }
    return _media;
}

@end
