//
//  MEFeedDataSourceProtocol.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@class InstagramMedia;
@class MEMediaResponse;

@protocol MEFeedDataSourceProtocol <NSObject>

- (NSInteger)numberOfItemSections;

- (NSInteger)numberOfItemsInSection:(NSInteger)section;

- (InstagramMedia *)itemAtIndexPath:(NSIndexPath *)indexPath;


- (void)setMediaFromResponse:(MEMediaResponse *)mediaResponse;

- (void)addMediaFromResponse:(MEMediaResponse *)mediaResponse;

@end
