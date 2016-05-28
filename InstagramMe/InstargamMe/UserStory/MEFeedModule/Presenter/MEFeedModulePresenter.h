//
//  MEFeedModulePresenter.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleViewOutput.h"
#import "MEFeedModuleInteractorOutput.h"
#import "MEFeedModuleModuleInput.h"
#import "MEAuthorizationModuleInput.h"
#import "MENavigationModuleDelegate.h"
#import "MENavigationModuleDelegateOutput.h"
#import "MEFeedModuleInteractorInput.h"

@protocol MEFeedModuleViewInput;
@protocol MEFeedModuleInteractorInput;
@protocol MEFeedModuleRouterInput;

@interface MEFeedModulePresenter : NSObject <MENavigationModuleDelegateOutput, MEFeedModuleModuleInput, MEFeedModuleViewOutput, MEFeedModuleInteractorOutput>

@property (nonatomic, strong) id<MEFeedModuleViewInput> view;
@property (nonatomic, strong) id<MEFeedModuleInteractorInput> interactor;
@property (nonatomic, strong) id<MEFeedModuleRouterInput> router;
@property (nonatomic, strong) id <MEAuthorizationModuleInput, MENavigationModuleDelegate> authorizationModule;

@end