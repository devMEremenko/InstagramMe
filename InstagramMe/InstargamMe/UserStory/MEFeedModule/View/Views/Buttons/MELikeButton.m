//
//  MELikeButton.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/24/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MELikeButton.h"
#import "pop/Pop.h"
#import "MEInstagramKit.h"

NSString* const kMEShowLikeAnimationName = @"kMEShowLikeAnimationName";
NSString* const kMEHideLikeAnimationName = @"kMEHideLikeAnimationName";

CGSize kMEShowedButtonSize = {1.15, 1.15};
CGSize kMEHiddenButtonSize = {1, 1};

CGFloat kMEButtonAnimationDuration = 0.3f;

@interface MELikeButton ()

@property (weak, nonatomic) InstagramMedia* media;

@end

@implementation MELikeButton

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
        [self setImage:[UIImage me_likeImage] forState:UIControlStateNormal];
        [self setImage:[UIImage me_likeHighlightedImage] forState:UIControlStateHighlighted];
        
        [self addTarget:self
                 action:@selector(actionDidPressLikeButton:)
       forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - Public

- (void)setupWithMedia:(InstagramMedia *)media
{
    self.media = media;
    media.isLiked ? [self setLikedStyleAnimated:NO] : [self setUnlikedStyle];
}

#pragma mark - Actions

- (void)actionDidPressLikeButton:(MELikeButton *)sender
{
    self.media.isLiked ? [self setUnlikedStyle] : [self setLikedStyleAnimated:YES];
    self.media.liked = !self.media.liked;
}

#pragma mark - Private

- (void)setUnlikedStyle
{
    [self setImage:[UIImage me_likeImage] forState:UIControlStateNormal];
}

- (void)setLikedStyleAnimated:(BOOL)animated
{
    [self setImage:[UIImage me_likeHighlightedImage] forState:UIControlStateNormal];

    if (animated)
    {
        [self addShowLikeAnimation];
    }
}

#pragma mark - Animations

- (void)addShowLikeAnimation
{
    self.userInteractionEnabled = NO;
    
    POPBasicAnimation* animation = [POPBasicAnimation defaultAnimation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    animation.name = kMEShowLikeAnimationName;
    animation.delegate = self;
    animation.duration = kMEButtonAnimationDuration;
    animation.toValue = [NSValue valueWithCGSize:kMEShowedButtonSize];
    
    [self pop_addAnimation:animation forKey:kMEShowLikeAnimationName];
}

- (void)addHideLikeAnimation
{
    POPBasicAnimation* animation = [POPBasicAnimation defaultAnimation];
    animation.property = [POPAnimatableProperty propertyWithName:kPOPViewScaleXY];
    animation.name = kMEHideLikeAnimationName;
    animation.delegate = self;
    animation.duration = kMEButtonAnimationDuration;
    animation.toValue = [NSValue valueWithCGSize:kMEHiddenButtonSize];
    
    [self pop_addAnimation:animation forKey:kMEHideLikeAnimationName];
}

#pragma mark - POPAnimationDelegate

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if ([anim.name isEqualToString:kMEShowLikeAnimationName])
    {
        [self addHideLikeAnimation];
    }
    
    if ([anim.name isEqualToString:kMEHideLikeAnimationName])
    {
        self.userInteractionEnabled = YES;
    }
}

@end
