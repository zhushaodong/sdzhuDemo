//
//  UISupaideHybridWebViewController.m
//  userclient
//
//  Created by sdzhu on 15/10/27.
//  Copyright © 2015年 supaide. All rights reserved.
//

#import "UISupaideHybridWebViewController.h"
@interface UISupaideHybridWebViewController ()
{
    UIActivityIndicatorView *activityIndicator;
    BOOL needRecord;
}

@end

@implementation UISupaideHybridWebViewController

#define pt @"supaidenative"

- (id)init{
    self = [super init];
    if(self){
        self.useCustomGoback = NO;
        _webBounces = NO;
        self.enablePanGesture = YES;
        self.isShowProgress = NO;
        
        self.spdCommand = [[SPDCommand alloc] initWithViewController:self];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.webBounces = _webBounces;
}

- (void)setWebBounces:(BOOL)webBounces{
    _webBounces = webBounces;
    web.scrollView.bounces = webBounces;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self doInitContext];
}

- (void)doInitContext{
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext）
    JSContext *context = [web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //第二种情况，js是通过对象调用的，我们假设js里面有一个对象 Base 在调用方法
    //首先创建我们新建类的对象，将他赋值给js的对象
//    self.spdCommand.viewController = self; //用self会导致内存泄露

    context[@"SPD_IOS"] = self.spdCommand; //实现SupaideJavascirptProtocal协议
    
}

- (NSString *)excuteJs:(NSString *)jsString{
    //这样总是莫名的崩溃或者卡死UI
//    JSContext *context = [web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    [context evaluateScript:jsString];
    return [web stringByEvaluatingJavaScriptFromString:jsString];
}

- (void)recordHistory{
    [web recordHistory];
}

- (BOOL)DLPanableWebViewCustomGoback:(DLPanableWebView *)webView{
//    //调用js的goBack
    if(_useCustomGoback){
        [self.spdCommand excuteJs:@"window.history.go(-1)"];
    }
    return _useCustomGoback;
}

//返回YES则由js主动记录History，返回NO则用默认的拦截跳转的方式记录History
- (BOOL)DLPanableWebViewNeedRecordHistory:(DLPanableWebView *)webView{
    return NO;
}

- (void)dealloc{
    self.spdCommand = nil;
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
