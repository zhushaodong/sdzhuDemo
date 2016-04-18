//
//  UILocalHybridWebviewControllerViewController.m
//  userclient
//
//  Created by sdzhu on 15/10/26.
//  Copyright © 2015年 supaide. All rights reserved.
//

#import "UIPanableWebViewViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface UIPanableWebViewViewController ()<DLPanableWebViewHandler,BackButtonHandlerProtocol,NJKWebViewProgressDelegate>

@end

@implementation UIPanableWebViewViewController{
    id navPanTarget_;
    SEL navPanAction_;
    
    NJKWebViewProgress *progressProxy;
    NJKWebViewProgressView *progressView;
    BOOL _isShowProgress;
}

- (id)initWithUrl:(NSString *)url title:(NSString *)title
{
    self = [self init];
    if(self)
    {
        self.url = url;
        self.title = title;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if(self){
        _enablePanGesture = YES;
        _isShowProgress = NO;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    web = [[DLPanableWebView alloc] init];
    web.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kNavigateBarHight);
    web.backgroundColor = [UIColor whiteColor];
    web.delegate = self;
    web.panDelegate = self;
    web.enablePanGesture = _enablePanGesture;
    web.title = self.title;
    
    [self.view addSubview:web];
    
    self.isShowProgress = _isShowProgress;
    
    // 获取系统默认手势Handler并保存
    if (IOS_VERSION_7_OR_ABOVE) {
        NSMutableArray *gestureTargets = [self.navigationController.interactivePopGestureRecognizer valueForKey:@"_targets"];
        id gestureTarget = [gestureTargets firstObject];
        navPanTarget_ = [gestureTarget valueForKey:@"_target"];
        navPanAction_ = NSSelectorFromString(@"handleNavigationTransition:");
    }
    [self reloadRequest];
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [progressView setProgress:progress animated:YES];
}

- (void)setIsShowProgress:(BOOL)isShowProgress{
    //以下代码莫名奇葩内存泄露
    _isShowProgress = isShowProgress;
    if(isShowProgress){
        
        if(!progressProxy){
            progressProxy = [[NJKWebViewProgress alloc] init];
            progressProxy.webViewProxyDelegate = self;
            progressProxy.progressDelegate = self;
        }
        if(!progressView){
            CGRect barFrame = CGRectMake(0, 0, web.width, 2);
            progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
            progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
            progressView.progressBarView.alpha = 0;
            [web addSubview:progressView];
            web.delegate = progressProxy;
        }
    }
    else{
        
        if(progressProxy){
            progressProxy.webViewProxyDelegate = nil;
            progressProxy.progressDelegate = nil;
            progressProxy = nil;
            
            [progressView removeFromSuperview];
            progressView = nil;
        }
    }
}

- (BOOL)isShowProgress{
    return _isShowProgress;
}

- (void)reloadRequest
{
    NSLog(@"reloadRequest url = %@",self.url);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [web loadRequest:request];
}

//拦截backBarItem的返回事件
- (BOOL)navigationShouldPopOnBackButton{
    
    if([self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 1] == self){
        if([web customCanGoback]){
//            [web goBackWithAnimate:YES];
            [web goBackWithAnimate:NO];
            return NO;
        }
    }
    return YES;
}

- (void)DLPanableWebView:(DLPanableWebView *)webView panPopGesture:(UIPanGestureRecognizer *)pan{
    if (navPanTarget_ && [navPanTarget_ respondsToSelector:navPanAction_]) {
        [navPanTarget_ performSelector:navPanAction_ withObject:pan];
    }
}

- (void)DLPanableWebView:(DLPanableWebView *)webView goBackWithTitle:(NSString *)title{
    if(title != nil && ![@"" isEqualToString:title]){
        self.title = title;
    }
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    web.title = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    NSLog(@"dealloc");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
