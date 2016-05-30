//
//  MEAuthorizationRouter.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationRouterInput.h"
#import "MEAuthorizationPresenter.h"

@interface MEAuthorizationRouter : NSObject <MEAuthorizationRouterInput>

@property (nonatomic,weak) MEAuthorizationPresenter *presenter;

@end