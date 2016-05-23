//
//  MEAuthorizationViewOutput.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

@protocol MEAuthorizationViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;

- (void)userDidSignIn;

@end