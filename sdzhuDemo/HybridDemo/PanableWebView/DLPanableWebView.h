//
//  DLPanableWebView.h
//  hybirdDemo
//
//  Created by Dongle Su on 15/6/18.
//  Copyright (c) 2015年 dongle. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DLPanableWebView;

@protocol DLPanableWebViewHandler <NSObject>
@optional
- (void)DLPanableWebView:(DLPanableWebView *)webView panPopGesture:(UIPanGestureRecognizer *)pan;
- (void)DLPanableWebView:(DLPanableWebView *)webView goBackWithTitle:(NSString *)title;

//返回YES，调用自定义的goback；NO，调用webView的goback；不实现该方法时，调用webView的goback
- (BOOL)DLPanableWebViewCustomGoback:(DLPanableWebView *)webView;
//返回YES，由代理实现记录历史；NO，跳转时自动记录；不实现，跳转时自动记录
- (BOOL)DLPanableWebViewNeedRecordHistory:(DLPanableWebView *)webView;
@end

@interface DLPanableWebView : UIWebView<UIWebViewDelegate>
@property(nonatomic, weak) id<DLPanableWebViewHandler> panDelegate;
@property(nonatomic, assign) BOOL enablePanGesture;
@property (nonatomic,copy)  NSString    *title;

- (BOOL)customCanGoback;
- (void)goBackWithAnimate:(BOOL)animated;
- (void)recordHistory;

@end
