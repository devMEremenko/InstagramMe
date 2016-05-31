//
//  MEViewAllButton.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEViewAllButton.h"
#import "MEInstagramKit.h"

NSString* const kMEViewAllButtonTitle = @"View all comments";

@interface MEViewAllButton ()

@property (weak, nonatomic) InstagramMedia* media;

@end

@implementation MEViewAllButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    MEViewAllButton* button = [super buttonWithType:buttonType];
    button.titleLabel.font = [UIFont me_viewAllButtonFont];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [button setTitleColor:[UIColor me_viewAllButtonHighlightedColor] forState: UIControlStateHighlighted];
    [button setTitleColor:[UIColor me_viewAllButtonTitleColor] forState:UIControlStateNormal];
    return button;
}

#pragma mark - Public

- (void)setupWithMedia:(InstagramMedia *)media
{
    self.media = media;
    
    [self setTitleWithMedia:media];
}

#pragma mark -

- (void)setTitleWithMedia:(InstagramMedia *)media
{
    NSInteger commentsCount = media.comments.count;
    
    if (commentsCount > kMEMaxViewingCommentCount)
    {
        NSString* title = [NSString stringWithFormat:@"%@ (%li)",
                           kMEViewAllButtonTitle, (long)commentsCount];
        
        [self setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [self setTitle:nil forState:UIControlStateNormal];
    }
}


@end
