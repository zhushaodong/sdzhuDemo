//
//  UIWebViewController.m
//  client
//
//  Created by sdzhu on 15/4/22.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import "UIWebViewController.h"
#import "UIShareView.h"
@interface UIWebViewController()
{
    UIActivityIndicatorView *activityIndicator;
}
@end
@implementation UIWebViewController

- (id)initWithUrl:(NSString *)url title:(NSString *)title
{
    self = [super init];
    if(self)
    {
        self.url = url;
        self.title = title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    web = [[UIWebView alloc] init];
    web.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kNavigateBarHight);
    web.backgroundColor = [UIColor whiteColor];
    web.delegate = self;

    [self.view addSubview:web];
    
    [self reloadRequest];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)reloadRequest
{
    NSLog(@"reloadRequest url = %@",self.url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [web loadRequest:request];
}

- (void)startAnimate
{
    if(!activityIndicator)
    {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
        [activityIndicator setCenter:web.center];
        activityIndicator.color = [UIColor blackColor];
        [web addSubview:activityIndicator];
    }
    [activityIndicator startAnimating];
}

- (void)stopAnimate
{
    [activityIndicator stopAnimating];
    //    UIView *view = (UIView*)[self.view viewWithTag:108];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    NSLog(@"webViewDidFinishLoad");
}

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [self startAnimate];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopAnimate];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicator stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    
    UILabel *errerLabel = [[UILabel alloc] init];
    [webView addSubview:errerLabel];
    errerLabel.frame = CGRectMake(0, self.view.frame.size.height / 2 - 40 / 2, SCREEN_WIDTH, 40);
    errerLabel.textColor = UIColorFromRGB(0xa6aeb9);
    errerLabel.text = @"网络君连接失败，请重试！";
    errerLabel.textAlignment = NSTextAlignmentCenter;
    errerLabel.tag = 108;
}

@end
