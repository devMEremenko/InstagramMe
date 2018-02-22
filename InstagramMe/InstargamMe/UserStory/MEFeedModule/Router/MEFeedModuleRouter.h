//
//  MEFeedModuleRouter.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEFeedModuleRouterInput.h"

#import "MEFeedModulePresenter.h"

@interface MEFeedModuleRouter : NSObject <MEFeedModuleRouterInput>

@property (nonatomic,weak) MEFeedModulePresenter *presenter;

@end