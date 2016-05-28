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
#import "InstagramMe-Swift.h"
#import "CustomLayout.h"

@interface MEFeedModuleViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MEFeedCollectionCellDelegate>

@property (strong, nonatomic) UICollectionView* collectionView;
@property (strong, nonatomic) TLYShyNavBarManager* topNavigationBar;
@property (strong, nonatomic) id <MEFeedDataSourceProtocol> dataSource;
@end

CGSize const MEFeedHeaderSize = {1, 58};
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
    
    cell.delegate = self;
    
    if (IOS7) // performance reasons...
    {
        [cell setupWithMedia:[self.dataSource itemAtIndexPath:indexPath]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEFeedCollectionCell* feedCell = (MEFeedCollectionCell *)cell;
    [feedCell setupWithMedia:[self.dataSource itemAtIndexPath:indexPath]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor purpleColor];
        
        reusableview = headerView;
    }
    
    return reusableview;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id media = [self.dataSource itemAtIndexPath:indexPath];
    return [MEFeedCollectionCell sizeWithMedia:media inCollectionView:collectionView];
}

#pragma mark - MEFeedCollectionCellDelegate

- (void)feedCellDidTapped:(MEFeedCollectionCell *)cell onLabel:(MECommentLabel *)label
{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    
    if (indexPath && cell)
    {
        [self.collectionView performBatchUpdates:^{
            [self.collectionView.collectionViewLayout invalidateLayout];
        } completion:nil];
    }
}
#pragma mark - Transition & Rotation

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionView.collectionViewLayout invalidateLayout];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self.collectionView reloadData];
    }];
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
        CustomLayout * layout = [CustomLayout new];
        layout.headerReferenceSize = MEFeedHeaderSize;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor orangeColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[MEFeedCollectionCell class]
            forCellWithReuseIdentifier:kFeedCollectionCellIdentifier];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
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