//
//  MEFeedCollectionCell.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedCollectionCell.h"
#import "InstagramKit.h"

CGFloat const kDefaultShareViewHeight = 50;

@implementation MEFeedCollectionCell

+ (CGSize)sizeWithMedia:(InstagramMedia *)media inCollectionView:(UICollectionView *)collectionView
{
    CGSize result = CGSizeZero;
    result.height += CGRectGetWidth(collectionView.bounds);
    result.height += kDefaultShareViewHeight;
    result.height += [MECommentsContentView heightWithMedia:media inSize:collectionView.bounds.size];
    
    result.width = CGRectGetWidth(collectionView.bounds);

    return result;
}

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self imageView];
        [self shareContentView];
        [self commentsContentView];
    }
    return self;
}

#pragma mark - 

- (void)setupWithMedia:(InstagramMedia *)media
{
    [self layoutIfNeeded];
    [self updateConstraints];
    [self.commentsContentView setupWithMedia:media];
}

#pragma mark - Lazy Load

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(self.contentView.mas_width);
        }];
    }
    return _imageView;
}

- (MEShareContentView *)shareContentView
{
    if (!_shareContentView)
    {
        _shareContentView = [MEShareContentView new];
        [self.contentView addSubview:_shareContentView];
        
        [_shareContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@(kDefaultShareViewHeight));
        }];
    }
    return _shareContentView;
}

- (MECommentsContentView *)commentsContentView
{
    if (!_commentsContentView)
    {
        _commentsContentView = [MECommentsContentView new];
        _commentsContentView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:_commentsContentView];
        
        [_commentsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareContentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return _commentsContentView;
}

@end
