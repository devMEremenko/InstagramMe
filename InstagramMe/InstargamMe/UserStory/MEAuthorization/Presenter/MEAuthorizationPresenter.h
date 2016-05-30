//
//  MEAuthorizationPresenter.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationViewOutput.h"
#import "MEAuthorizationInteractorOutput.h"
#import "MEAuthorizationModuleInput.h"
#import "MENavigationModuleDelegate.h"

@protocol MEAuthorizationViewInput;
@protocol MEAuthorizationInteractorInput;
@protocol MEAuthorizationRouterInput;

@interface MEAuthorizationPresenter : NSObject <MENavigationModuleDelegate, MEAuthorizationModuleInput, MEAuthorizationViewOutput, MEAuthorizationInteractorOutput>

@property (nonatomic, strong) id<MEAuthorizationViewInput> view;
@property (nonatomic, strong) id<MEAuthorizationInteractorInput> interactor;
@property (nonatomic, strong) id<MEAuthorizationRouterInput> router;

@end