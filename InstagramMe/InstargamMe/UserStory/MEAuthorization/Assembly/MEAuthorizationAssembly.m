//
//  MEAuthorizationAssembly.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationAssembly.h"

#import "MEAuthorizationViewController.h"
#import "MEAuthorizationInteractor.h"
#import "MEAuthorizationPresenter.h"
#import "MEAuthorizationRouter.h"

@implementation MEAuthorizationAssembly

+ (id <MEAuthorizationModuleInput, MENavigationModuleDelegate>)createModule
{
    MEAuthorizationViewController *view = [self viewController];
	// uncomment if need view preloading
    // [view view]; 
    MEAuthorizationInteractor *interactor = [MEAuthorizationInteractor new];
    MEAuthorizationPresenter *presenter = [MEAuthorizationPresenter new];
    MEAuthorizationRouter *router = [MEAuthorizationRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    
    return presenter;
}

+ (MEAuthorizationViewController *)viewController
{
    return [MEAuthorizationViewController new];
}

@end