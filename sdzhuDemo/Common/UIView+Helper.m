//
//  UIView+FindFirstResponder.m
//  xueyoubangbang
//
//  Created by sdzhu on 15/3/19.
//  Copyright (c) 2015年 sdzhu. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)

- (id)findFirstResponder
{
    if (self.isFirstResponder)
    {
        return self;
    }
    for (UIView *subView in self.subviews)
    {
        id responder = [subView findFirstResponder];
        if (responder)
        {
            return responder;
        }
    }
    return nil;
}

- (CGFloat)bottomY
{
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return y;
}

- (CGFloat)rightX
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

@end
