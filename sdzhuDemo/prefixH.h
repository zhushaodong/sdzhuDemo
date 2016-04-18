//
//  prefixH.h
//  userclient
//
//  Created by sdzhu on 15/6/24.
//  Copyright (c) 2015年 supaide. All rights reserved.
//


#import "UIView+Helper.h"

//屏幕尺寸
#define mainWindow       [UIApplication sharedApplication].keyWindow

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_IPHONE_5     568.0
#define SCREEN_IPHONE_4     480.0
#define SCREEN_IPHONE_6     667.0
#define SCREEN_IPHONE_6P    736.0
#define SCREEN_IPHONE       SCREEN_HEIGHT

//iphone6plus放大模式
#define IS_IPHONE_6P_BIG ([UIScreen mainScreen].scale == 3 && SCREEN_HEIGHT == SCREEN_IPHONE_6 ? YES : NO)
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

#define kNavigateBarHight \
({\
CGFloat navh;\
if(SCREEN_HEIGHT == SCREEN_IPHONE_6P)\
{\
navh = 64;\
}\
else\
{\
if(IOS_VERSION_7_OR_ABOVE)\
{\
navh = 64;\
}\
else\
{\
navh = 44;\
}\
}\
navh;\
})

#define kStatusBarHeight 20

#define kTabBarHeight (SCREEN_HEIGHT == SCREEN_IPHONE_6P ? 73.5 : 49)

#define USER_DEFAULT    [NSUserDefaults standardUserDefaults]

//颜色
#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)      RGBA(r,g,b,1.0f)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]



//工具
#define isBlankString(string) \
({\
    BOOL result = NO;\
    if (string == nil) {\
        result = YES;\
    }\
    else if (string == NULL) {\
        result = YES;\
    }\
    else if ([string isKindOfClass:[NSNull class]]) {\
        result = YES;\
    }\
    else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {\
        result = YES;\
    }\
    result;\
})


