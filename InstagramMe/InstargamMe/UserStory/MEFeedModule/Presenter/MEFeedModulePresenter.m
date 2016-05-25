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

#pragma mark - MEFeedModuleModuleInput

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
    [self.interactor findRecentMediaForCurrentUser];
}

#pragma mark - MEFeedModuleViewOutput

- (void)didTriggerViewReadyEvent
{
    [self.view setupInitialState];
}

#pragma mark - MEFeedModuleInteractorOutput

- (void)didFindRecentMedia:(MERecentMedia *)recentMedia
{
    ANDispatchBlockToMainQueue(^{
        [self.view didFindRecentMedia:recentMedia];
    });
}

- (void)didFindNextPageRecentMedia:(MERecentMedia *)recentMedia
{
    ANDispatchBlockToMainQueue(^{
        [self.view didFindNextPageRecentMedia:recentMedia];
    });
}

- (void)failedFindRecentMedia
{
    ANDispatchBlockToMainQueue(^{
        [self.view failedFindRecentMedia];
    });
}

@end