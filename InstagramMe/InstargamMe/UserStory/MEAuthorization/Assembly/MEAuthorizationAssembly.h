//
//  MEAuthorizationAssembly.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

@protocol MEAuthorizationModuleInput;
@protocol MENavigationModuleDelegate;

@interface MEAuthorizationAssembly : NSObject

+ (id <MEAuthorizationModuleInput, MENavigationModuleDelegate>)createModule;

@end