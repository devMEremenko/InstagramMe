//
//  MEFeedModulePresenter.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/23/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModulePresenter.h"

#import "MEFeedModuleViewInput.h"
#import "MEFeedModuleInteractorInput.h"
#import "MEFeedModuleRouterInput.h"

@implementation MEFeedModulePresenter

#pragma mark - Методы MEFeedModuleModuleInput

- (void)configureModule
{
    
}

- (void)presentInWindow:(UIWindow *)window
{
    [self.router presentInWindow:window];
}

#pragma mark - MENavigationModuleDelegateOutput

- (void)presentModule:(id<MENavigationModuleDelegate>)module
{
    
}

- (void)dismissModule:(id<MENavigationModuleDelegate>)module
{
    [self.router dismissModule:module];
}

#pragma mark - Методы MEFeedModuleViewOutput

- (void)didTriggerViewReadyEvent
{
    [self.view setupInitialState];
}

#pragma mark - Методы MEFeedModuleInteractorOutput

@end