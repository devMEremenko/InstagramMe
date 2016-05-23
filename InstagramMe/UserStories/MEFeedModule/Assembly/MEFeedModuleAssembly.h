//
//  MEFeedModuleAssembly.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MEFeedModuleModuleInput;

/**
 @author devMEremenko

 MEFeedModule module
 */
@interface MEFeedModuleAssembly : NSObject

+ (id <MEFeedModuleModuleInput>)createModule;


@end