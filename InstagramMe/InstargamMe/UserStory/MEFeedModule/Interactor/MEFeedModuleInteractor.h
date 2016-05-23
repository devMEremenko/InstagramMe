//
//  MEFeedModuleInteractor.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleInteractorInput.h"

@protocol MEFeedModuleInteractorOutput;

@interface MEFeedModuleInteractor : NSObject <MEFeedModuleInteractorInput>

@property (nonatomic, weak) id<MEFeedModuleInteractorOutput> output;

@end