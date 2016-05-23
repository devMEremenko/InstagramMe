//
//  MENavigationModuleDelegateOutput.h
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/23/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MENavigationModuleDelegate;

@protocol MENavigationModuleDelegateOutput <NSObject>

- (void)presentModule:(id<MENavigationModuleDelegate>)module;

- (void)dismissModule:(id<MENavigationModuleDelegate>)module;

@end
