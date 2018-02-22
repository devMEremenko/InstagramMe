//
//  MEBarButtonItem.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEBarButtonItem.h"

@implementation MEBarButtonItem

+ (instancetype)item
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    MEBarButtonItem* item = [[MEBarButtonItem alloc] initWithCustomView:button];
    item.contentButton = button;
    return item;
}

- (void)addTarget:(id)target andAction:(SEL)action
{
    [self.contentButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
