//
//  UIImage+Scale.m
//  DrawImageTest
//
//  Created by iflytek.com on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//改变图片颜色
- (UIImage *)imageChangeWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImage*)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)scaleWithScale:(CGFloat)scale
{
    if(scale >= 1)
    {
        return self;
    }
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    UIImage *scaleImage = [self scaleToSize:size];
    return scaleImage;
}

// 截图
-(UIImage *) cutout: (CGRect) coords
{
//    UIGraphicsBeginImageContext(coords.size);
    int scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(coords.size, NO, scale);
    
    [self drawAtPoint: CGPointMake(-coords.origin.x, -coords.origin.y)];
    UIImage *rslt = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rslt;
}

// 纵向拉伸
- (UIImage *) stretchImageWithCapInsets: (UIEdgeInsets) cornerCaps toSize: (CGSize) size 
{
//    UIGraphicsBeginImageContext(size);
    int scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    UIImage *part1 = [self cutout:CGRectMake(0, 0, self.size.width, cornerCaps.top)];

    UIImage *part2 = [self cutout:CGRectMake(0, cornerCaps.top, self.size.width, self.size.height - cornerCaps.top - cornerCaps.bottom)];
    
    UIImage *part3 = [self cutout:CGRectMake(0, self.size.height - cornerCaps.bottom, self.size.width, cornerCaps.bottom)];
    
    // 绘制part1
    [part1 drawAtPoint:CGPointMake(0, 0)];
    
    // 拉伸绘制part2
    [part2 drawInRect:CGRectMake(0, cornerCaps.top, self.size.width, size.height - cornerCaps.top - cornerCaps.bottom)];
    
    // 绘制part3
    [part3 drawAtPoint:CGPointMake(0, size.height - cornerCaps.bottom)];
    
    UIImage *rslt = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    
    return rslt;
}

// 横向拉伸 
- (UIImage *)stretchImageHor:(UIEdgeInsets) cornerCaps
{
    UIImage *ret = [self stretchableImageWithLeftCapWidth:cornerCaps.left topCapHeight:cornerCaps.top];
    return ret;
}

//横向拉伸
- (UIImage *)stretchImageHor:(UIEdgeInsets)cornerCaps toSize:(CGSize) size
{
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        return nil;
    }
    
    int scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    UIImage *scaleHorImage = [self stretchImageHor:cornerCaps];
    [scaleHorImage drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage *rslt = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rslt;
}

// 纵向拉伸＋横向拉伸
- (UIImage *)stretchImageWithSets:(UIEdgeInsets)cornerCaps toSize:(CGSize) size
{
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        return nil;
    }
    
    int scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    
    UIImage *scalePorImage = [self stretchImageWithCapInsets:cornerCaps toSize:CGSizeMake(self.size.width, size.height)];

    UIImage *scaleHorImage = [scalePorImage stretchImageHor:cornerCaps];
    [scaleHorImage drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage *rslt = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rslt;
}

- (UIImage *)stretchImageWithSize:(CGSize)size
{
    //    CGFloat originWidth = image.size.width;
    //    CGFloat originHeight = image.size.height;
    //    UIImage *newImage = [image stretchableImageWithLeftCapWidth:(int)originWidth/2 topCapHeight:(int)originHeight/2];
    //
    //    return newImage;
    //用以上方法拉伸的图片作为view的转为UIColor有问题，会变成repeat模式
    
    CGFloat originWidth = self.size.width;
    CGFloat originHeight = self.size.height;
    UIEdgeInsets sets = UIEdgeInsetsMake( (int)( originHeight / 2.0 - 1),(int)( originWidth / 2.0 - 1), (int)(originHeight / 2.0 -1),(int)( originWidth / 2.0 - 1));
    UIImage *newImage = [self stretchImageWithSets:sets toSize:size];
    return newImage;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(NSData *)toData
{
    NSData *data;
    if (UIImagePNGRepresentation(self) == nil) {
        
        data = UIImageJPEGRepresentation(self, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(self);
    }
    return data;
}
@end
