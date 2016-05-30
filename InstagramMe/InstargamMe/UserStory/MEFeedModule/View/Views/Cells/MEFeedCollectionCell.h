//
//  MEFeedCollectionCell.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEShareContentView.h"
#import "MECommentsContentView.h"
#import "MEFeedImageView.h"

@class InstagramMedia;
@protocol MEFeedCollectionCellDelegate;

@interface MEFeedCollectionCell : UICollectionViewCell

@property (strong, nonatomic) MEFeedImageView* feedImageView;
@property (strong, nonatomic) MEShareContentView* shareContentView;
@property (strong, nonatomic) MECommentsContentView* commentsContentView;
@property (weak, nonatomic) id <MEFeedCollectionCellDelegate> delegate;

+ (CGSize)sizeWithMedia:(InstagramMedia *)media inCollectionView:(UICollectionView *)collectionView;

- (void)setupWithMedia:(InstagramMedia *)media;

@end

@protocol MEFeedCollectionCellDelegate <NSObject>
@optional

- (void)feedCellDidTapped:(MEFeedCollectionCell *)cell onLabel:(MECommentLabel *)label;

@end
