//
//  MEAuthorizationInteractor.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationInteractorInput.h"

@protocol MEAuthorizationInteractorOutput;

@interface MEAuthorizationInteractor : NSObject <MEAuthorizationInteractorInput>

@property (nonatomic, weak) id<MEAuthorizationInteractorOutput> output;

@end