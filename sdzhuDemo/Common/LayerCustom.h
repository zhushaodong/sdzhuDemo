//
//  LayerCustom.h
//  client
//
//  Created by sdzhu on 15/3/30.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LayHideFinishBlock)(BOOL finished);

@interface LayerCustom : UIView
@property (nonatomic,retain) UIView *showedView;
@property (nonatomic,copy)    LayHideFinishBlock    hideFinishBlock;
+ (LayerCustom *)showWithView:(UIView *)subview;
+(void)hide;
+ (void)hideCompletion:(void(^)(BOOL finished))completion;
@end
