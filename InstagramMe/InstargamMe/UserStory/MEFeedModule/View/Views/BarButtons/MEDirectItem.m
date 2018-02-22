//
//  MEDirectItem.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEDirectItem.h"

@implementation MEDirectItem

+ (instancetype)directItem
{
    MEDirectItem* item = [[self class] item];
    
    [[item.contentButton.widthAnchor constraintEqualToConstant:25] setActive:YES];
    [[item.contentButton.heightAnchor constraintEqualToConstant:25] setActive:YES];
    
    [item.contentButton setImage:[UIImage me_directImage] forState:UIControlStateNormal];
    return item;
}

@end
