//
//  MEFeedModuleRouterInput.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol MENavigationModuleDelegate;

@protocol MEFeedModuleRouterInput <NSObject>

- (void)presentInWindow:(UIWindow *)window;

- (void)dismissModule:(id<MENavigationModuleDelegate>)module;

@end