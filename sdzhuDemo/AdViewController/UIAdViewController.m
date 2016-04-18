//
//  UIAdViewController.m
//  userclient
//
//  Created by sdzhu on 15/6/10.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import "UIAdViewController.h"
#import "UIImageView+WebCache.h"
#import "UIShareWebViewContrller.h"
#import "UICustomNavigationViewController.h"

@interface UIAdViewController()
{
    NSInteger leftTime;
    NSDate *startDate;
    
    UIImage *launchImage;
    
    UIImageView *backView;
    
    UILabel *label;
}
@end
@implementation UIAdViewController
#pragma mark 广告页
#define waitTime 2
- (void)viewDidLoad
{
    [self showAd];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)showAd
{
    backView = [[UIImageView alloc] init];
    backView.frame = self.view.bounds;
    backView.image = [self launchImage];

    [self.view addSubview:backView];
    
    self.adImageView = [[UIImageView alloc] init];
    self.adImageView.frame = CGRectMake(0, 0, self.view.width, self.view.height - self.view.width / 1080 *(1920 - 1480) + (SCREEN_IPHONE_4 == SCREEN_IPHONE ? 30 : 0));

    [self.view addSubview:self.adImageView];

    [self performSelector:@selector(delayFinish) withObject:nil afterDelay:waitTime];
    
    
//        NSDictionary *ad = [result objectForKey:@"ad"];
        NSDictionary *ad = @{@"title" : @"QQ",
                             @"imgsrc" : @"http://i1.download.fd.pchome.net/t_720x1280/g1/M00/0C/1C/ooYBAFR8JdiIG5gYAAbXA_WuP7oAACIAQMxRcAABtcb003.jpg",
                             @"url" : @"http://www.qq.com",
                             @"time" : @"3",
                             @"share" : @{@"content" : @"分享测试",
                                          @"url": @"http://www.qq.com"}
                             };
        
        
        
        NSString *imgsrc = [ad objectForKey:@"imgsrc"];
        //如果没有图片，则跳过
        if([@"" isEqualToString:imgsrc] || nil == imgsrc)
        {
            if(self.block)
            {
                self.block();
            }
            return;
        }
        self.title = [ad objectForKey:@"title"];
        self.url = [ad objectForKey:@"url"];
        self.time = ((NSNumber *)[ad objectForKey:@"time"]).integerValue;
        
        self.shareContent = [ad objectForKey:@"share"];
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:imgsrc] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            if(!image)
            {
                if(self.block)
                {
                    self.block();
                }
                return;
            }
            self.adImageView.alpha = 0;
            
            leftTime = self.time;
            [self.timer invalidate];
            self.timer = nil;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(doTimer) userInfo:nil repeats:YES];
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap)];
            self.adImageView.userInteractionEnabled = YES; //必须写，否则无法响应touch
            [self.adImageView addGestureRecognizer:gesture];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.adImageView.alpha = 1;
            } completion:^(BOOL finished) {
                [self performSelector:@selector(removeAd) withObject:nil afterDelay:self.time];
            }];
        }];
}

- (void)doTap
{
    if([@"" isEqualToString:self.url] || nil == self.url)
    {
        return;
    }
    
    [self.timer invalidate];
    self.timer = nil;
    [UIAdViewController cancelPreviousPerformRequestsWithTarget:self];

    UIWebViewController *ctrl = [[UIShareWebViewContrller alloc] initWithUrl:self.url title:self.title shareContent:self.shareContent];
    
    UICustomNavigationViewController *nav = [[UICustomNavigationViewController alloc] initWithRootViewController:ctrl];
    
    ctrl.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(doCloseAd)];
    
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)doSkip
{
    [self removeAd];
}

- (void)doCloseAd
{
    if(self.block)
    {
        self.block();
    }
}

- (void)doTimer
{
    if(leftTime == 0)
    {
        [self removeAd];
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        label.text = [NSString stringWithFormat:@"%ds",--leftTime];
    }
}

- (void)removeAd
{
    [UIView animateWithDuration:0.5 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        if(self.block)
        {
            self.block();
        }
    }];
}

- (void)delayFinish
{
    if(self.adImageView.image == nil)
    {
        if(self.block)
        {
            self.block();
        }
    }
}

- (UIImage *)launchImage
{
    //兼容iPhone6plus的放大模式
    CGFloat scale = IS_IPHONE_6P_BIG ? 2 : [UIScreen mainScreen].scale;
    NSString *name = [NSString stringWithFormat:@"launch-%d-%d.png",(int) (SCREEN_WIDTH * scale ),(int) (SCREEN_HEIGHT * scale)];
    UIImage *image = [UIImage imageNamed:name];
    return image;
}

@end
