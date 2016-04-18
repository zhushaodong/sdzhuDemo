//
//  ViewController.m
//  sdzhuDemo
//
//  Created by sdzhu on 16/3/17.
//  Copyright © 2016年 sdzhu. All rights reserved.
//

#import "ViewController.h"
#import "UIAdViewController.h"
#import "UISupaideHybridWebViewController.h"
#import "UICustomNavigationViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = UIColorFromRGB(0xf2f3f7);
    
    [self createView];
}

- (void)createView{
    
    CGFloat const btnWidth = 160;
    CGFloat const btnHeight = 50;
    UIButton *btnHybrid = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:btnHybrid];
    btnHybrid.frame = CGRectMake(SCREEN_WIDTH / 2 - btnWidth / 2, (self.view.height - kNavigateBarHight) / 2, btnWidth, btnHeight);
    [btnHybrid setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnHybrid.backgroundColor = [UIColor whiteColor];
    [btnHybrid setTitle:@"测试Hybrid页面" forState:UIControlStateNormal];
    
    [btnHybrid addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)btnClick{
    
    NSString *url = [self localIndexHtmlUrl];
    
    UISupaideHybridWebViewController *ctrl = [[UISupaideHybridWebViewController alloc] initWithUrl:url title:@"test"];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (NSString *)localIndexHtmlUrl{
    NSString *bundlePath = [[ NSBundle mainBundle] pathForResource:@"html" ofType :@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *indexPath = [bundle pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:indexPath];
    NSString *urlStr = url.absoluteString;
    return urlStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
