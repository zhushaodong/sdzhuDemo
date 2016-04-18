//
//  UIWebViewController.h
//  client
//
//  Created by sdzhu on 15/4/22.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *web;
}
@property (nonatomic,copy)  NSString    *url;
- (id)initWithUrl:(NSString*)url title:(NSString *)title;

- (void)reloadRequest;
- (void)startAnimate;
- (void)stopAnimate;
@end
