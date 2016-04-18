//
//  UISupaideHybridWebViewController.h
//  userclient
//
//  Created by sdzhu on 15/10/27.
//  Copyright © 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "UIPanableWebViewViewController.h"
#import "SPDCommand.h"

@interface UISupaideHybridWebViewController : UIPanableWebViewViewController

@property (nonatomic,strong)   SPDCommand   *spdCommand;
@property (nonatomic)       BOOL useCustomGoback;//是否使用自定义的goback方法
@property (nonatomic)   BOOL webBounces;
- (NSString *)excuteJs:(NSString *)jsString;
- (void)recordHistory;
@end

