//
//  MEAuthorizationViewController.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationViewInput.h"

@protocol MEAuthorizationViewOutput;

@interface MEAuthorizationViewController : UIViewController <MEAuthorizationViewInput>

@property (nonatomic, strong) id<MEAuthorizationViewOutput> output;

@end