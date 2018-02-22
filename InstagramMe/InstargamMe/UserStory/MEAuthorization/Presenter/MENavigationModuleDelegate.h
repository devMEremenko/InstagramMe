//
//  MENavigationModuleDelegate.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/23/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//


@protocol MENavigationModuleDelegateOutput;

@protocol MENavigationModuleDelegate <NSObject>

- (UIViewController*)controller;

- (void)preparePresentInModule:(id<MENavigationModuleDelegateOutput>)module;

@end
