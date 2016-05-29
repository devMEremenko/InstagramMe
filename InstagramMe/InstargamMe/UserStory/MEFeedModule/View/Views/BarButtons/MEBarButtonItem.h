//
//  MEBarButtonItem.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/29/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

@interface MEBarButtonItem : UIBarButtonItem

@property (weak, nonatomic) UIButton* contentButton;

+ (instancetype)item;

- (void)addTarget:(id)target andAction:(SEL)action;

@end
