//
//  MENavigationModuleDelegateOutput.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/23/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//


@protocol MENavigationModuleDelegate;

@protocol MENavigationModuleDelegateOutput <NSObject>

- (void)dismissModule:(id<MENavigationModuleDelegate>)module;

@end
