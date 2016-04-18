//
//  UICustomNavigationViewController.m
//  xueyoubangbang
//
//  Created by sdzhu on 15/3/19.
//  Copyright (c) 2015年 sdzhu. All rights reserved.
//

#import "UICustomNavigationViewController.h"

@interface UICustomNavigationViewController ()
{
    UIViewController *_rootViewController;
}
@end

@implementation UICustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(IOS_VERSION_7_OR_ABOVE){
        //设置返回按钮背景色
        self.navigationBar.tintColor = UIColorFromRGB(0x404558);
        //设置导航栏颜色
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.translucent = NO;
//        self.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x404558)}];
    }
    else{
        self.navigationBar.backgroundColor = [UIColor whiteColor];
    }
    
//    [self setCustomBackbar];
    
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    _rootViewController = rootViewController;
    self = [super initWithRootViewController:rootViewController];
    if(self)
    {
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"返回";
        rootViewController.navigationItem.backBarButtonItem = returnButtonItem;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(_rootViewController != viewController)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    viewController.navigationItem.backBarButtonItem = returnButtonItem;
}

-(void)setCustomBackbar
{
    
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    //    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil]];
    if(osVersion >= 7.0)
    {
        [self.navigationItem.backBarButtonItem setTitle:@""];
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
        
        //设置返回按钮背景色
        self.navigationBar.tintColor = RGB(8, 125, 234);
        //设置导航栏颜色
        self.navigationBar.barTintColor = UIColorFromRGB(0xf6f6f8);
        self.navigationBar.translucent = NO;
        //自定义返回按钮
        UIImage *originBackImage = [UIImage imageNamed:@"back"];
    
        self.navigationBar.backIndicatorImage = originBackImage;
        self.navigationBar.backIndicatorTransitionMaskImage = originBackImage;
       

    }else {
        self.navigationBar.backgroundColor = RGB(8, 125, 234);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
