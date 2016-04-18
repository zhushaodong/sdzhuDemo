//
//  UIShareWebViewContrller.h
//  userclient
//
//  Created by sdzhu on 15/9/8.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIWebViewController.h"
@interface UIShareWebViewContrller : UIWebViewController
@property (nonatomic,copy)  NSDictionary *shareContent;


- (id)initWithUrl:(NSString *)url
            title:(NSString *)title
     shareContent:(NSDictionary *)shareContent;
@end
