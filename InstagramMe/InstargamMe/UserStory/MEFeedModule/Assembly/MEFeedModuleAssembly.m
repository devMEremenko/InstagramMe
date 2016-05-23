//
//  MEFeedModuleAssembly.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleAssembly.h"

#import "MEFeedModuleViewController.h"
#import "MEFeedModuleInteractor.h"
#import "MEFeedModulePresenter.h"
#import "MEFeedModuleRouter.h"
#import "MEAuthorizationAssembly.h"

@implementation MEFeedModuleAssembly


+ (id <MEFeedModuleModuleInput>)createModule
{
    MEFeedModuleViewController *view = [self viewController];
	// uncomment if need view preloading
    // [view view]; 
    MEFeedModuleInteractor *interactor = [MEFeedModuleInteractor new];
    MEFeedModulePresenter *presenter = [MEFeedModulePresenter new];
    MEFeedModuleRouter *router = [MEFeedModuleRouter new];
    
	router.presenter = presenter;
	
    view.output = presenter;
    interactor.output = presenter;
    
    presenter.view = view;
    presenter.interactor = interactor;
    presenter.router = router;
    presenter.authorizationModule = [MEAuthorizationAssembly createModule];
        
    return presenter;
}

+ (MEFeedModuleViewController *)viewController
{
    return [MEFeedModuleViewController new];
}

@end