//
//  LayerCustom.m
//  client
//
//  Created by sdzhu on 15/3/30.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import "LayerCustom.h"

@interface LayerCustom() <UIGestureRecognizerDelegate>

@end
@implementation LayerCustom
#define MASK_LAYER_TAG 100005

-(id)init
{
    self = [super init];
    if(self)
    {
        //隐藏键盘
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap)];
        [self addGestureRecognizer:tap];
        tap.delegate = self;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        //隐藏键盘
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap)];
        [self addGestureRecognizer:tap];
        tap.delegate = self;
    }
    return self;
}

+ (LayerCustom *)showWithView:(UIView *)subview
{
    LayerCustom *layer = (LayerCustom *) [[[UIApplication sharedApplication] keyWindow] viewWithTag:MASK_LAYER_TAG];
    if(!layer)
    {
        layer = [[LayerCustom alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        layer.tag = MASK_LAYER_TAG;
        [[[UIApplication sharedApplication] keyWindow] addSubview:layer];
        [[[UIApplication sharedApplication] keyWindow] addSubview:subview];
        layer.alpha = 0;
        subview.frame = CGRectMake(subview.frame.origin.x, layer.frame.size.height, subview.frame.size.width, subview.frame.size.height);
        layer.showedView = subview;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        layer.alpha = 1;
        subview.frame = CGRectMake(subview.frame.origin.x, layer.frame.size.height - subview.frame.size.height, subview.frame.size.width, subview.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    return layer;
}

+ (void)hide
{
    LayerCustom *layer = (LayerCustom *) [[[UIApplication sharedApplication] keyWindow] viewWithTag:MASK_LAYER_TAG];
    UIView *view = layer.showedView;
    [UIView animateWithDuration:0.3 animations:^{
        layer.alpha = 0;
        view.frame = CGRectMake(view.frame.origin.x, layer.frame.size.height , view.frame.size.width, view.frame.size.height);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [layer removeFromSuperview];
        
        if(layer.hideFinishBlock)
        {
            layer.hideFinishBlock(finished);
            layer.hideFinishBlock = nil;
        }
    }];
}

+ (void)hideCompletion:(void (^)(BOOL))completion
{
    LayerCustom *layer = (LayerCustom *) [[[UIApplication sharedApplication] keyWindow] viewWithTag:MASK_LAYER_TAG];
    UIView *view = layer.showedView;
    [UIView animateWithDuration:0.3 animations:^{
        layer.alpha = 0;
        view.frame = CGRectMake(view.frame.origin.x, layer.frame.size.height , view.frame.size.width, view.frame.size.height);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [layer removeFromSuperview];
        
        if(completion)
        {
            completion(finished);
        }
    }];
}

- (void)doTap
{
    UIView *view = self.showedView;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        view.frame = CGRectMake(view.frame.origin.x, self.frame.size.height , view.frame.size.width, view.frame.size.height);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
        [self removeFromSuperview];
        if(self.hideFinishBlock)
        {
            self.hideFinishBlock(finished);
            self.hideFinishBlock = nil;
        }
    }];
}
@end
