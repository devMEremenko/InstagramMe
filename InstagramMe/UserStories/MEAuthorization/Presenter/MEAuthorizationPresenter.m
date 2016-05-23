//
//  MEAuthorizationPresenter.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationPresenter.h"
#import "MEAuthorizationViewInput.h"
#import "MEAuthorizationInteractorInput.h"
#import "MEAuthorizationRouterInput.h"
#import "MENavigationModuleDelegateOutput.h"

@interface MEAuthorizationPresenter ()
@property (weak, nonatomic) id <MENavigationModuleDelegateOutput> presentingModule;
@end

@implementation MEAuthorizationPresenter

#pragma mark - MEAuthorizationModuleInput

- (void)configureModule
{
    
}

#pragma mark - MENavigationModuleDelegate

- (UIViewController *)controller
{
    return (UIViewController *)self.view;
}

- (void)preparePresentInModule:(id<MENavigationModuleDelegateOutput>)module
{
    self.presentingModule = module;
}

#pragma mark - MEAuthorizationViewOutput

- (void)didTriggerViewReadyEvent
{
	[self.view setupInitialState];
}

- (void)userDidSignIn
{
    [self.presentingModule dismissModule:self];
}

#pragma mark - MEAuthorizationInteractorOutput

@end