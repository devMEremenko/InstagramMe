//
//  MEFeedCollectionCell.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEShareContentView.h"
#import "MECommentsContentView.h"

@class InstagramMedia;

@interface MEFeedCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) MEShareContentView* shareContentView;
@property (strong, nonatomic) MECommentsContentView* commentsContentView;

+ (CGSize)sizeWithMedia:(InstagramMedia *)media inCollectionView:(UICollectionView *)collectionView;

- (void)setupWithMedia:(InstagramMedia *)media;

@end
