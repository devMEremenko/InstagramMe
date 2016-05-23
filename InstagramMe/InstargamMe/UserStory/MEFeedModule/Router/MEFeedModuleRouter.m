//
//  MEFeedModuleRouter.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleRouter.h"

@interface MEFeedModuleRouter ()

@property (weak, nonatomic) UIWindow* window;

@end

@implementation MEFeedModuleRouter

#pragma mark - MEFeedModuleRouterInput

- (void)presentInWindow:(UIWindow *)window
{
    self.window = window;
    
    ANDispatchBlockToMainQueue(^{
        [window setRootViewController:(UIViewController *)self.presenter.view];
        [window makeKeyAndVisible];
        
        [self presentAuthorizationModuleIfNeeded];
    });
}

- (void)dismissModule:(id<MENavigationModuleDelegate>)module
{
    UIViewController* presentedController = self.window.rootViewController.presentedViewController;
    if ([presentedController isEqual:[module controller]])
    {
        [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Private

- (void)presentAuthorizationModuleIfNeeded
{
    BOOL isUserAuth = NO;
    if (!isUserAuth)
    {
        UIViewController* vc = [self.presenter.authorizationModule controller];
        [self.presenter.authorizationModule preparePresentInModule:self.presenter];
        [self.window.rootViewController presentViewController:vc animated:NO completion:nil];
    }
}

@end