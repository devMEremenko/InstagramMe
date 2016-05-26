//
//  MEFeedModuleViewController.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleViewController.h"
#import "MEFeedModuleViewOutput.h"
#import "MEFeedCollectionCell.h"
#import "TLYShyNavBarManager.h"
#import "MERecentMediaDataSource.h"
#import "MONUniformFlowLayout.h"

@interface MEFeedModuleViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MONUniformFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) TLYShyNavBarManager* topNavigationBar;
@property (strong, nonatomic) id <MEFeedDataSourceProtocol> dataSource;
@property (strong, nonatomic) MONUniformFlowLayout* layout;

@end

NSString* const kFeedCollectionCellIdentifier = @"kFeedCollectionCellIdentifier";

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
    [self setupUserInterface];
}

- (void)didFindRecentMedia:(MEMediaResponse *)mediaResponse
{
    [self.dataSource setMediaFromResponse:mediaResponse];
    [self.collectionView reloadData];
}

- (void)didFindNextPageRecentMedia:(MEMediaResponse *)mediaResponse
{
    [self.dataSource addMediaFromResponse:mediaResponse];
    [self.collectionView reloadData];
}

- (void)failedFindRecentMedia
{
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataSource numberOfItemSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataSource numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEFeedCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kFeedCollectionCellIdentifier forIndexPath:indexPath];
    
    [cell setupWithMedia:[self.dataSource itemAtIndexPath:indexPath]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor purpleColor];
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}

#pragma mark - MONUniformFlowLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(MONUniformFlowLayout *)layout itemHeightInSection:(NSInteger)section
{
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    id media = [self.dataSource itemAtIndexPath:indexPath];
    return [MEFeedCollectionCell sizeWithMedia:media inCollectionView:collectionView].height;
}

#pragma mark - Helpers

- (void)setupUserInterface
{
    TLYShyNavBarManager *shyManager = [TLYShyNavBarManager new];
    self.shyNavBarManager = shyManager;
    self.shyNavBarManager.scrollView = self.collectionView;
}

#pragma mark - Lazy Load

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        MONUniformFlowLayout* layout = [MONUniformFlowLayout new];
        self.layout = layout;
        layout.minimumLineSpacing = 0;
        layout.interItemSpacing = MONInterItemSpacingMake(10.0f, 10.0f);
        layout.enableStickyHeader = YES;
        [layout setHeaderReferenceSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 60)];

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor orangeColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[MEFeedCollectionCell class]
            forCellWithReuseIdentifier:kFeedCollectionCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"header"];

        [self.view addSubview:_collectionView];
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    return _collectionView;
}

#pragma mark - Lazy Load

- (MERecentMediaDataSource <MEFeedDataSourceProtocol> *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [MERecentMediaDataSource new];
    }
    return _dataSource;
}

@end