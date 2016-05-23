//
//  BarView.m
//  TableViewTest
//
//  Created by Alex Kopachev on 05.02.16.
//  Copyright © 2016 Alex Kopachev. All rights reserved.
//

#import "AKBarView.h"

static const NSInteger BLButtonsWidth = 70;
static const NSInteger BLStatusBarHeight = 20;
static const NSInteger BLScrollToDownOffset = 250;
static const CGFloat BLTimeForAnimation = 0.3;

@interface AKBarView () <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat initialOffset;
@property (nonatomic, assign) CGFloat scrollToDownOffset;

@end

@implementation AKBarView

- (void)open
{
    // открыть бар
    [self _openAnimate];
}

- (void)close
{
    // скрыть бар
    [self _closeAnimate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // подготовка к новым жестам
    [self _prepareForScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // основной метод расчитывает высоту навигейшена, пока выполняется скрол
    [self _calculateBarViewHeightWithOffset:scrollView.contentOffset.y];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView velocity:(CGPoint)velocity topInset:(CGFloat)inset
{
    // вызывает scrollViewDidEndDecelerating если скорость == 0
    [self _calculateBarViewSideWithOffset:scrollView.contentOffset.y velocity:velocity.y topInset:inset];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView topInset:(CGFloat)inset
{
    // анимирует скрытие/открытие после того как закончился жест
    [self _calculateEndAnimateWithOffset:scrollView.contentOffset.y topInset:inset];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // определяет нужно проскролить таблицу или открыть бар
    return [self _scrollViewShouldScrollToTop:scrollView];
}

#pragma mark - animations

- (void)_openAnimate
{
    self.isBarViewClose = NO;
    [UIView animateWithDuration:BLTimeForAnimation animations:^{
        [self _layoutBarViewWithHeight:BLBarViewHeight];
    }];
}

- (void)_closeAnimate
{
    self.isBarViewClose = YES;
    [UIView animateWithDuration:BLTimeForAnimation animations:^{
        [self _layoutBarViewWithHeight:BLStatusBarHeight];
    }];
}

- (void)_changeOpacity
{
    CGFloat alpha = 1 + CGRectGetMinY(self.frame) / (BLBarViewHeight - BLStatusBarHeight);
    _leftBarButton.alpha = alpha;
    _rightBarButton.alpha = alpha;
    _titleButton.alpha = alpha;
}

#pragma mark - private

- (void)_calculateBarViewSideWithOffset:(CGFloat)offset velocity:(CGFloat)velocity topInset:(CGFloat)inset
{
    if (velocity == 0)
    {
        [self _calculateEndAnimateWithOffset:offset topInset:inset];
    }
}

- (void)_prepareForScroll:(UIScrollView *)scrollView
{
    self.initialOffset = scrollView.contentOffset.y;
    CGFloat minY = -CGRectGetMinY(self.frame);
    CGFloat maxY = BLBarViewHeight - BLStatusBarHeight;
    self.isBarViewClose = minY > maxY / 2;
    self.scrollToDownOffset = MAX(0, MIN(self.initialOffset - maxY, BLScrollToDownOffset));
}

- (void)_calculateBarViewHeightWithOffset:(CGFloat)offset
{
    CGFloat touchOffset = self.initialOffset - offset;
    if (self.isBarViewClose)
    {
        touchOffset -= self.scrollToDownOffset;
        [self _calculateBarViewHeightForCloseSideWithTouchOffset:touchOffset];
    }
    else
    {
        [self _calculateBarViewHeightForOpenSideWithTouchOffset:touchOffset];
    }
}

- (void)_calculateEndAnimateWithOffset:(CGFloat)offset topInset:(CGFloat)inset
{
    CGFloat minY = -CGRectGetMinY(self.frame);
    CGFloat maxY = BLBarViewHeight - BLStatusBarHeight;
    if (minY > maxY / 2 && offset + inset >= maxY)
    {
        [self _closeAnimate];
    }
    else
    {
        [self _openAnimate];
    }
}

- (void)_calculateBarViewHeightForOpenSideWithTouchOffset:(CGFloat)offset
{
    CGFloat barViewHeight = BLBarViewHeight;
    if (offset < 0)
    {
        barViewHeight = MAX(BLStatusBarHeight, BLBarViewHeight + offset);
    }
    [self _layoutBarViewWithHeight:barViewHeight];
}

- (void)_calculateBarViewHeightForCloseSideWithTouchOffset:(CGFloat)offset
{
    CGFloat barViewHeight = BLStatusBarHeight;
    if (offset > 0)
    {
        barViewHeight = MIN(BLBarViewHeight, BLStatusBarHeight + offset);
    }
    [self _layoutBarViewWithHeight:barViewHeight];
}

- (BOOL)_scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    [self _prepareForScroll:scrollView];
    if (self.isBarViewClose)
    {
        if (!scrollView.dragging)
        {
            [self open];
        }
        return scrollView.dragging;
    }
    return YES;
}

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self _setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _setup];
    }
    return self;
}

- (void)_setup
{
    [self _layoutBarViewWithHeight:BLBarViewHeight];
    [self _layoutLeftBarButton];
    [self _layoutRightBarButton];
    [self _layoutTitleButton];
}

#pragma mark - > layout <

- (void)_layoutBarViewWithHeight:(CGFloat)height
{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.y = height - BLBarViewHeight;
    rect.size.height = BLBarViewHeight;
    self.frame = rect;
    [self _changeOpacity];
}

- (void)_layoutRightBarButton
{
    CGRect rect = self.bounds;
    rect.origin.x = CGRectGetWidth(rect) - BLButtonsWidth;
    rect.size.width = BLButtonsWidth;
    self.rightBarButton.frame = rect;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(BLStatusBarHeight, 0, 0, 0);
    self.rightBarButton.contentEdgeInsets = insets;
}

- (void)_layoutLeftBarButton
{
    CGRect rect = self.bounds;
    rect.size.width = BLButtonsWidth;
    self.leftBarButton.frame = rect;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(BLStatusBarHeight, 0, 0, 0);
    self.leftBarButton.contentEdgeInsets = insets;
}

- (void)_layoutTitleButton
{
    CGRect rect = self.bounds;
    rect.origin.x = BLButtonsWidth;
    rect.origin.y = BLStatusBarHeight;
    rect.size.width -= BLButtonsWidth * 2;
    rect.size.height -= BLStatusBarHeight;
    self.titleButton.frame = rect;
}

#pragma mark - lazy initialization

- (UIButton *)rightBarButton
{
    if (!_rightBarButton)
    {
        _rightBarButton = [UIButton new];
        _rightBarButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_rightBarButton];
    }
    return _rightBarButton;
}

- (UIButton *)leftBarButton
{
    if (!_leftBarButton)
    {
        _leftBarButton = [UIButton new];
        _leftBarButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_leftBarButton];
    }
    return _leftBarButton;
}

- (UIButton *)titleButton
{
    if (!_titleButton)
    {
        _titleButton = [UIButton new];
        [self addSubview:_titleButton];
    }
    return _titleButton;
}

@end
