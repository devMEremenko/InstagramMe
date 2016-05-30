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
    item.contentButton.frame = CGRectMake(0, 0, 25, 25);
    [item.contentButton setImage:[UIImage me_directImage] forState:UIControlStateNormal];
    return item;
}

@end
