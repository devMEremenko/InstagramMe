//
//  MEFeedHeaderView.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEInstagramKit.h"
#import "MEFeedHeaderImageView.h"
#import "MELabel.h"
#import "MEAdditionallyButton.h"

@interface MEFeedHeaderView : UICollectionReusableView

@property (strong, nonatomic) UILabel* userNameLabel;
@property (strong, nonatomic) MEFeedHeaderImageView* imageView;
@property (strong, nonatomic) MEAdditionallyButton* additionallyButton;
@property (strong, nonatomic) UIView* separator;

- (void)setupWithMedia:(InstagramMedia *)media;

@end
