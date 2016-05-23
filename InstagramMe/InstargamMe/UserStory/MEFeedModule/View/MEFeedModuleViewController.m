//
//  MEFeedModuleViewController.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleViewController.h"
#import "MEFeedModuleViewOutput.h"
#import "AKBarView.h"

@interface MEFeedModuleViewController () <UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) AKBarView* barView;

@end

@implementation MEFeedModuleViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark - MEFeedModuleViewInput

- (void)setupInitialState
{
    [self barView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark - Lazy Load

- (AKBarView *)barView
{
    if (!_barView)
    {
        _barView = [AKBarView new];
        _barView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_barView];
        
        [_barView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.equalTo(@(BLBarViewHeight));
        }];
    }
    return _barView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [UICollectionView new];
//        _collectionView.dataSource = self;
        
        [self.view addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            
        }];
    }
    return _collectionView;
}

@end