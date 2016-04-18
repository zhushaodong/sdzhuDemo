//
//  UILocalHybridWebviewControllerViewController.h
//  userclient
//
//  Created by sdzhu on 15/10/26.
//  Copyright © 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLPanableWebView.h"
@interface UIPanableWebViewViewController : UIViewController<UIWebViewDelegate>
{
    DLPanableWebView *web;
}
@property (nonatomic,copy)  NSString    *url;
@property (nonatomic)   BOOL    isShowProgress;
@property (nonatomic)   BOOL    enablePanGesture;
- (id)initWithUrl:(NSString*)url title:(NSString *)title;

- (void)reloadRequest;

@end
