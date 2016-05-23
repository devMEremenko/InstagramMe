//
//  BarView.h
//  TableViewTest
//
//  Created by Alex Kopachev on 05.02.16.
//  Copyright © 2016 Alex Kopachev. All rights reserved.
//

#import <UIKit/UIKit.h>

static const NSInteger BLBarViewHeight = 65;

@interface AKBarView : UIView

@property (nonatomic, strong) UIButton *leftBarButton;
@property (nonatomic, strong) UIButton *rightBarButton;
@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, assign) BOOL isBarViewClose;

- (void)open;

- (void)close;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView velocity:(CGPoint)velocity topInset:(CGFloat)inset;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView topInset:(CGFloat)inset;

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView;

@end
