//
//  MEFeedCollectionCell.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedCollectionCell.h"
#import "MEInstagramKit.h"

CGFloat const kDefaultShareViewHeight = 50;

@interface MEFeedCollectionCell () <MECommentLabelDelegate>
@property (weak, nonatomic) InstagramMedia* media;
@end

@implementation MEFeedCollectionCell

+ (CGSize)sizeWithMedia:(InstagramMedia *)media inCollectionView:(UICollectionView *)collectionView
{
    CGSize result = CGSizeZero;
    result.height += CGRectGetWidth(collectionView.bounds);
    result.height += kDefaultShareViewHeight;
    result.height += [MECommentsContentView heightWithMedia:media inSize:collectionView.bounds.size];
    
    result.width = CGRectGetWidth(collectionView.bounds);
    
    result.height = ceilf(result.height);
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
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.clipsToBounds = YES;
    [self imageView];
    [self shareContentView];
    [self commentsContentView];
}

#pragma mark -

- (void)setupWithMedia:(InstagramMedia *)media
{
    [self layoutIfNeeded];
    [self updateConstraints];
    
    self.media = media;
    [self.commentsContentView setupWithMedia:media];
    [self.imageView setupWithMedia:media];
}

#pragma mark - MECommentLabelDelegate

- (void)didTapCommentLabel:(MECommentLabel *)label
{
    [self.commentsContentView handleTapOnCommentLabel:label];
    
    if ([self.delegate respondsToSelector:@selector(feedCellDidTapped:onLabel:)])
    {
        [self.delegate feedCellDidTapped:self onLabel:label];
    }
}

#pragma mark - Lazy Load

- (MEFeedImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [MEFeedImageView new];
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
        _commentsContentView.firstCommentLabel.delegate = self;
        _commentsContentView.secondCommentLabel.delegate = self;
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
