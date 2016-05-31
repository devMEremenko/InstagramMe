//
//  MEFeedCollectionCell.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedCollectionCell.h"
#import "MEInstagramKit.h"

CGFloat const kMEDefaultShareViewHeight = 48.f;

@interface MEFeedCollectionCell () <MECommentLabelDelegate, MEFeedImageViewDelegate>

@property (weak, nonatomic) InstagramMedia* media;

@end

@implementation MEFeedCollectionCell

+ (CGSize)sizeWithMedia:(InstagramMedia *)media inCollectionView:(UICollectionView *)collectionView
{
    CGSize result = CGSizeZero;
    result.height += CGRectGetWidth(collectionView.bounds);
    result.height += kMEDefaultShareViewHeight;
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
    [self shareContentView];
}

#pragma mark -

- (void)setupWithMedia:(InstagramMedia *)media
{
    self.media = media;
    
    [self.feedImageView setupWithMedia:media];
    [self.shareContentView setupWithMedia:media];
    [self.commentsContentView setupWithMedia:media];
    
    [self layoutIfNeeded];
    [self updateConstraints];
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

#pragma mark - MEFeedImageViewDelegate

- (void)feedImageView:(MEFeedImageView *)feedImage didPressLikeImageView:(MELikeImageView *)imageView
{
    self.media.liked = YES;
    [self.shareContentView.likeButton setLikedStyleAnimated:YES];
}

#pragma mark - Layouts

- (void)updateConstraints
{
//    [self.userContentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        CGFloat height = [[self.userContentView class]heightWithMedia:self.media inSize:self.bounds.size];
//        make.height.equalTo(@(height));
//    }];
    
    [super updateConstraints];
}

#pragma mark - Lazy Load

- (MEFeedImageView *)feedImageView
{
    if (!_feedImageView)
    {
        _feedImageView = [MEFeedImageView new];
        _feedImageView.delegate = self;
        [self.contentView addSubview:_feedImageView];
        
        [_feedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(self.contentView.mas_width);
        }];
    }
    return _feedImageView;
}

- (MEShareContentView *)shareContentView
{
    if (!_shareContentView)
    {
        _shareContentView = [MEShareContentView new];
        _shareContentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_shareContentView];
        
        [_shareContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.feedImageView.mas_bottom);
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@(kMEDefaultShareViewHeight));
        }];
    }
    return _shareContentView;
}

/*
- (MEUserContentView *)userContentView
{
    return nil;
    
    if (!_userContentView)
    {
        _userContentView = [MEUserContentView new];
        _userContentView.userLabel.delegate = self;
        [self.contentView addSubview:_userContentView];
        
        [_userContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.shareContentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
        }];
    }
    return _userContentView;
}
*/

- (MECommentsContentView *)commentsContentView
{
    if (!_commentsContentView)
    {
        _commentsContentView = [MECommentsContentView new];
        _commentsContentView.userLabel.delegate = self;
        _commentsContentView.firstCommentLabel.delegate = self;
        _commentsContentView.secondCommentLabel.delegate = self;
        _commentsContentView.backgroundColor = [UIColor whiteColor];
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
