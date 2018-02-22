//
//  MELikeImageView.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELikeImageView.h"
#import "pop/Pop.h"

NSString* const kMEScaleShowAnimationKey = @"kMEScaleShowAnimationKey";
NSString* const kMEScaleHideAnimationKey = @"kMEScaleHideAnimationKey";

NSString* const kMEAlphaShowAnimationKey = @"kMEAlphaShowAnimationKey";
NSString* const kMEAlphaHideAnimationKey = @"kMEAlphaHideAnimationKey";

CGFloat const kMEDurationBetweenAnimations = 0.54;

CGFloat const kMEShowedScaleFactor = 1.f;
CGFloat const kMEHiddenScaleFactor = 0.7f;

CGSize const kMEViewShowedScaleSize = {kMEShowedScaleFactor, kMEShowedScaleFactor};
CGSize const kMEViewHiddenScaleSize = {kMEHiddenScaleFactor, kMEHiddenScaleFactor};


@interface MELikeImageView ()
@property (assign, getter=isAnimated) BOOL animated;
@end

@implementation MELikeImageView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.image = [UIImage me_doubleLikeImage];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.transform = CGAffineTransformMakeScale(kMEHiddenScaleFactor, kMEHiddenScaleFactor);
        self.alpha = 0.f;
    }
    return self;
}

- (void)showLike
{
    if (!self.isAnimated)
    {
        [self startShowAnimation];
    }
}

#pragma mark - Animation Management

- (void)startShowAnimation
{
    self.animated = YES;
    
    [self addScaleShowAnimation];
    [self addAlphaShowAnimation];
}

- (void)startHideAnimation
{
    [self addScaleHideAnimation];
    [self addAlphaHideAnimation];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if ([anim.name isEqualToString:kMEScaleShowAnimationKey])
    {
        ANDispatchBlockAfter(kMEDurationBetweenAnimations, ^{
            [self startHideAnimation];
        });
    }
    
    if ([anim.name isEqualToString:kMEAlphaHideAnimationKey])
    {
        self.alpha = 0.f;
    }
    
    if ([anim.name isEqualToString:kMEScaleHideAnimationKey])
    {
        self.animated = NO;
    }
}

#pragma mark - Animations

- (void)addScaleShowAnimation
{
    POPSpringAnimation* animation = [POPSpringAnimation new];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    animation.name = kMEScaleShowAnimationKey;
    animation.delegate = self;
    animation.springBounciness = 11;
    animation.springSpeed = 80;
    animation.toValue = [NSValue valueWithCGSize:kMEViewShowedScaleSize];
    
    [self pop_addAnimation:animation forKey:kMEScaleShowAnimationKey];
}

- (void)addAlphaShowAnimation
{
    POPSpringAnimation* alphaAnimation = [POPSpringAnimation new];
    alphaAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    alphaAnimation.name = kMEAlphaShowAnimationKey;
    alphaAnimation.delegate = self;
    alphaAnimation.fromValue = @0.8;
    alphaAnimation.toValue = @1;
    
    [self pop_addAnimation:alphaAnimation forKey:kMEAlphaShowAnimationKey];
}

- (void)addScaleHideAnimation
{
    POPSpringAnimation* animation = [POPSpringAnimation new];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    animation.name = kMEScaleHideAnimationKey;
    animation.delegate = self;
    animation.toValue = [NSValue valueWithCGSize:kMEViewHiddenScaleSize];
    animation.springSpeed = 2;
    animation.dynamicsFriction = 10;
    animation.springBounciness = 8;
    
    [self pop_addAnimation:animation forKey:kMEScaleHideAnimationKey];
}

- (void)addAlphaHideAnimation
{
    POPBasicAnimation* alphaAnimation = [POPBasicAnimation new];
    alphaAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    alphaAnimation.name = kMEAlphaHideAnimationKey;
    alphaAnimation.delegate = self;
    alphaAnimation.duration = 0.08;
    alphaAnimation.toValue = @0.6;
    
    [self pop_addAnimation:alphaAnimation forKey:kMEAlphaHideAnimationKey];
}

@end
