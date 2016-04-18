//
//  UIShareView.h
//  userclient
//
//  Created by sdzhu on 15/7/2.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIShareView : UIView
@property (nonatomic,copy)  NSString    *content;
@property (nonatomic,copy)  NSString    *url;
@property (nonatomic,copy)  NSString    *title;
@property (nonatomic,copy)  NSString    *imageUrl;
@property (nonatomic,strong)    UIImage *placeImage;
@property (nonatomic,weak)  UIViewController *controller;
- (id)initWithContent:(NSString *)content
                  url:(NSString *)url
                title:(NSString *)title
             imageUrl:(NSString *)imageUrl
           placeImage:(UIImage *)placeImage;


@end
