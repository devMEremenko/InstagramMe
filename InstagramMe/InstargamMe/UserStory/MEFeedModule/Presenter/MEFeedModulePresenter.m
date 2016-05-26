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

- (void)didFindRecentMedia:(MEMediaResponse *)mediaResponse
{
    ANDispatchBlockToMainQueue(^{
        [self.view didFindRecentMedia:mediaResponse];
    });
}

- (void)didFindNextPageRecentMedia:(MEMediaResponse *)mediaResponse
{
    ANDispatchBlockToMainQueue(^{
        [self.view didFindNextPageRecentMedia:mediaResponse];
    });
}

- (void)failedFindRecentMedia
{
    ANDispatchBlockToMainQueue(^{
        [self.view failedFindRecentMedia];
    });
}

@end