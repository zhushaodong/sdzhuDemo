//
//  UIShareWebViewContrller.m
//  userclient
//
//  Created by sdzhu on 15/9/8.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import "UIShareWebViewContrller.h"
#import "UIShareView.h"
#import "LayerCustom.h"
@implementation UIShareWebViewContrller

- (id)initWithUrl:(NSString *)url
            title:(NSString *)title
     shareContent:(NSDictionary *)shareContent{
    self = [super initWithUrl:url title:title];
    if(self){
        self.shareContent = shareContent;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if(self.shareContent != nil && [self.shareContent objectForKey:@"url"] != nil){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fenxiang"] style:UIBarButtonItemStylePlain target:self action:@selector(doShare)];
    }
}

- (void)doShare
{
    NSString *url = isBlankString([self.shareContent objectForKey:@"url"])?self.url:[self.shareContent objectForKey:@"url"];
    NSString *title = isBlankString([self.shareContent objectForKey:@"title"])?self.title:[self.shareContent objectForKey:@"title"];
    NSString *imageUrl = [self.shareContent objectForKey:@"imgsrc"];
    NSString *content = isBlankString([self.shareContent objectForKey:@"content"])?title:[self.shareContent objectForKey:@"content"];
    UIImage *placeImage = [self.shareContent objectForKey:@"img"];
    
    UIShareView *shareView = [[UIShareView alloc] initWithContent:content url:url title:title imageUrl:imageUrl placeImage:placeImage];
    shareView.controller = self;
    [LayerCustom showWithView:shareView];
}
@end
