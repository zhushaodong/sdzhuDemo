//
//  UIView+FindFirstResponder.h
//  xueyoubangbang
//
//  Created by sdzhu on 15/3/19.
//  Copyright (c) 2015年 sdzhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)
- (id)findFirstResponder;

@property (nonatomic,readonly)   CGFloat width;
@property (nonatomic,readonly)   CGFloat height;
@property (nonatomic,readonly)   CGFloat bottomY;
@property (nonatomic,readonly)   CGFloat rightX;
@end
