//
//  MEFeedModuleViewController.h
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MEFeedModuleViewInput.h"

@protocol MEFeedModuleViewOutput;

@interface MEFeedModuleViewController : UIViewController <MEFeedModuleViewInput>

@property (nonatomic, strong) id<MEFeedModuleViewOutput> output;

@end