//
//  MEAuthorizationViewController.m
//  InstagramMe
//
//  Created by devMEremenko on 23/05/2016.
//  Copyright 2016 Maxim Eremenko. All rights reserved.
//

#import "MEAuthorizationViewController.h"
#import "MEAuthorizationViewOutput.h"
#import "InstagramKit.h"

@interface MEAuthorizationViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView* webView;
@property (strong, nonatomic) UINavigationBar* topBar;

@end

@implementation MEAuthorizationViewController

#pragma mark -  

- (void)viewDidLoad
{
	[super viewDidLoad];

	[self.output didTriggerViewReadyEvent];
}

#pragma mark -  MEAuthorizationViewInput

- (void)setupInitialState
{
    NSURL *authURL = [[InstagramEngine sharedEngine] authorizationURLForScope:[self authorizationScope]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:authURL]];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[InstagramEngine sharedEngine] receivedValidAccessTokenFromURL:request.URL error:nil])
    {
        [self.output userDidSignIn];
        return NO;
    }
    return YES;
}

#pragma mark - Lazy Load

- (UIWebView *)webView
{
    if (!_webView)
    {
        _webView = [UIWebView new];
        _webView.delegate = self;
        
        [self.view addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topBar.mas_bottom);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    return _webView;
}

- (UINavigationBar *)topBar
{
    if (!_topBar)
    {
        _topBar = [UINavigationBar new];
        [self.view addSubview:_topBar];
        
        [_topBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.equalTo(@64);
        }];
    }
    return _topBar;
}

- (InstagramKitLoginScope)authorizationScope
{
    return InstagramKitLoginScopeBasic | InstagramKitLoginScopePublicContent | InstagramKitLoginScopeComments | InstagramKitLoginScopeLikes | InstagramKitLoginScopeFollowerList | InstagramKitLoginScopeRelationships;
}

@end