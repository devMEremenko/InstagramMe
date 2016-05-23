//
//  MEPreloader.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/23/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "MEPreloader.h"
#import "MEFeedModuleAssembly.h"
#import "MEFeedModuleModuleInput.h"

@interface MEPreloader ()

@property (weak, nonatomic) UIWindow* window;
@property (strong, nonatomic) id <MEFeedModuleModuleInput> feedModule;

@end

@implementation MEPreloader

- (void)preloadWithWindow:(UIWindow *)window
{
    self.window = window;
    [self.feedModule presentInWindow:window];
}

#pragma mark - Lazy Load Modules

- (id<MEFeedModuleModuleInput>)feedModule
{
    if (!_feedModule)
    {
        _feedModule = [MEFeedModuleAssembly createModule];
    }
    return _feedModule;
}

@end
