//
//  MEFeedModuleAssembly.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

@protocol MEFeedModuleModuleInput;

@interface MEFeedModuleAssembly : NSObject

+ (id <MEFeedModuleModuleInput>)createModule;

@end