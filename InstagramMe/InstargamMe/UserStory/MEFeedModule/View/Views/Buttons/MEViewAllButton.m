//
//  MEViewAllButton.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/26/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEViewAllButton.h"

NSString* const kMEViewAllButtonTitle = @"View all comments";

@implementation MEViewAllButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    MEViewAllButton* button = [super buttonWithType:buttonType];
    button.titleLabel.font = [UIFont me_viewAllButtonFont];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    [button setTitleColor:[UIColor me_viewAllButtonTitleColor] forState:UIControlStateNormal];
    [button setTitle:kMEViewAllButtonTitle forState:UIControlStateNormal];

    return button;
}

@end
