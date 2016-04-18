//
//  UIImage+Scale.h
//  DrawImageTest
//
//  Created by iflytek.com on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)stretchImageWithSets:(UIEdgeInsets)cornerCaps toSize:(CGSize) size;
- (UIImage *)stretchImageWithSize:(CGSize)size;
- (UIImage *)stretchImageHor:(UIEdgeInsets)cornerCaps toSize:(CGSize) size;
- (UIImage*)scaleToSize:(CGSize)size;
- (UIImage *)scaleWithScale:(CGFloat)scale;
- (UIImage *)fixOrientation ;
- (NSData *)toData;
+ (UIImage *)imageWithColor:(UIColor *)color size: (CGSize) size;
- (UIImage *)imageChangeWithColor:(UIColor *)color;
@end
