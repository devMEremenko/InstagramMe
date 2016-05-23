//
//  AppDelegate.m
//  InstagramMe
//
//  Created by Maxim Eremenko on 5/23/16.
//  Copyright © 2016 Maxim Eremenko. All rights reserved.
//

#import "AppDelegate.h"
#import "MEPreloader.h"

@interface AppDelegate ()
@property (strong, nonatomic) MEPreloader* preloader;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    [self.preloader preloadWithWindow:self.window];
    
    return YES;
}

#pragma mark - Lazy Load

- (MEPreloader *)preloader
{
    if (!_preloader)
    {
        _preloader = [[MEPreloader alloc]init];
    }
    return _preloader;
}

@end
