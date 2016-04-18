//
//  UIAdViewController.h
//  userclient
//
//  Created by sdzhu on 15/6/10.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAdViewController : UIViewController

@property (nonatomic,copy)  NSString    *url;
@property (nonatomic)   NSInteger   time;
@property (nonatomic,strong)    NSTimer *timer;

@property (nonatomic,strong)    UIButton    *skipButton;
@property (nonatomic,strong)    UIImageView  *adImageView;

@property (nonatomic,copy)  NSDictionary *shareContent;//分享的内容

@property(copy,nonatomic)void (^block)();

- (UIImage *)launchImage;


@end
