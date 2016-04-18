//
//  UIShareView.m
//  userclient
//
//  Created by sdzhu on 15/7/2.
//  Copyright (c) 2015年 supaide. All rights reserved.
//

#import "UIShareView.h"
//#import "ShareActive.h" //跳转到微信和QQ的组件，略
#import "SDWebImageDownloader.h"
#import "UIImage+Scale.h"
#import "LayerCustom.h"
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"

@interface UIShareView()<UICollectionViewDataSource,UICollectionViewDelegate,MFMessageComposeViewControllerDelegate>
{
    UIView *container;
    NSArray *shareArr;
    UICollectionView *collection;
}
@end

@implementation UIShareView

#define countPerLine 3
#define itemH 80

- (id)initWithContent:(NSString *)content
                  url:(NSString *)url
                title:(NSString *)title
             imageUrl:(NSString *)imageUrl
           placeImage:(UIImage *)placeImage
{
    self = [super init];
    if(self)
    {
        self.content = content;
        self.url = url;
        self.title = title;
        self.imageUrl = imageUrl;
        self.placeImage = placeImage;
        [self createView];
    }
    return self;
}

- (void)createView
{
    
    //预加载图片
    if(!isBlankString(self.imageUrl)){
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.imageUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if(image != nil){
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    UIImage *newImage = [image scaleToSize:CGSizeMake(150, 150)]; //必须压缩，否则太大无法分享成功
                    self.placeImage = newImage;
                    self.imageUrl = nil;
                });
            }
            else{
                self.imageUrl = nil;
            }
        }];
    }
    
    shareArr = @[[UIImage imageNamed:@"pengyouquan"],[UIImage imageNamed:@"weixin"],[UIImage imageNamed:@"QQ"]];
    container = [[UIView alloc] init];
    container.backgroundColor = UIColorFromRGB(0xf2f3f7);
    [self addSubview:container];
    container.layer.cornerRadius = 5;
    container.clipsToBounds = YES;
    
    CGFloat padding = 10;
    CGFloat w = SCREEN_WIDTH - padding * 2;
    UILabel *tip = [[UILabel alloc] init];
    [container addSubview:tip];
    tip.frame = CGRectMake(0, 10, w, 20);
    tip.textColor = UIColorFromRGB(0x404657);
    tip.font = [UIFont systemFontOfSize:15];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.text = @"立即分享";
    
    CGFloat containerH = itemH * [self lineCount] + tip.bottomY;
    container.frame = CGRectMake(padding , 0 , w, containerH);

    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:View_Seperate(CGRectMake(0, container.bottomY, SCREEN_WIDTH, 1))];
    btnCancel.layer.cornerRadius = 5;
    btnCancel.clipsToBounds = YES;
    [btnCancel setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xf2f3f7) size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    btnCancel.frame = CGRectMake(padding, container.bottomY + 5, w, 44);
    [self addSubview:btnCancel];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:UIColorFromRGB(0xfe5b4c) forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(doCancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, btnCancel.bottomY + 10);

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    collection = [[UICollectionView alloc] initWithFrame:CGRectMake(15, tip.bottomY, container.width - 15 * 2, container.height) collectionViewLayout:layout];
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GradientCell"];
    collection.backgroundColor = [UIColor clearColor];
    collection.dataSource = self;
    collection.delegate = self;
    [container addSubview:collection];
}

- (void)doCancel
{
    [LayerCustom hide];
}

- (NSInteger)lineCount
{
    NSInteger count = shareArr.count / countPerLine + 1;
    if(shareArr.count % countPerLine == 0)
    {
        count --;
    }
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return shareArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"GradientCell";
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImage *image = [shareArr objectAtIndex:indexPath.row];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    CGFloat w = collectionView.width / countPerLine;
    CGFloat h = itemH;
    iv.frame = CGRectMake(w / 2 - iv.width / 2, h / 2 - iv.height / 2, iv.width, iv.height);
    
    [cell.contentView addSubview:iv];
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.width / countPerLine ,itemH);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
     //跳转到微信或者QQ，此处略
//    NSString *content = self.content;
//    UIImage *image = self.placeImage?self.placeImage :[UIImage imageNamed:@"icon_client.jpg"];
//    NSString *url = self.url;
//    NSString *title = [CommonMethod isBlankString:self.title]?@"让城市物流更痛快":self.title;
//    NSString *imageUrl = self.imageUrl;
//    
//    
//    ShareActive *shareActive;
//    if(indexPath.row == 0)
//    {
//        shareActive = [[ShareActiveWeixinQuan alloc] init];
//    }
//    else if(indexPath.row == 1)
//    {
//        shareActive = [[ShareActiveWeixinFriend alloc] init];
//    }
//    else if (indexPath.row == 2)
//    {
//        shareActive = [[ShareActiveQQ alloc] init];
//    }
//    
//    if([CommonMethod isBlankString:imageUrl]){
//        if(![shareActive shareTitle:title content:content image:image url:url])
//        {
//            [CommonMethod showAlert:shareActive.errorMsg];
//        }
//    }
//    else{
//        
//        
//        if([shareActive isKindOfClass:[ShareActiveWeixinQuan class]]){
//            [MBProgressHUD showHUDAddedTo:self.controller.view];
//        }
//        
//        [shareActive shareTitle:title content:content imageUrl:imageUrl placeImage:image url:url block:^(BOOL result) {
//            [MBProgressHUD hideAllHUDsForView:self.controller.view];
//            if(!result)
//            {
//                [CommonMethod showAlert:shareActive.errorMsg];
//            }
//        }];
//    }
//    
//    [LayerCustom hide];

}

- (BOOL)shareMessage:(NSString *)content image:(UIImage *)image url:(NSString *)url
{
    [MBProgressHUD showHUDAddedTo:self];
    
    if([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.body= content;
        
        //        [picker addAttachmentData:[image toData]  typeIdentifier:@"image/png" filename:@"/Assets/icon_client@2x.png"];
        //短信接收者，可设置多个
        //         picker.recipients = @[@"18855152670"];
        [self.controller presentViewController:picker animated:YES completion:^{
            [MBProgressHUD hideAllHUDsForView:self.controller.view];
        }];
        return YES;
    }
    else
    {
        [MBProgressHUD hideAllHUDsForView:self.controller.view];
        return NO;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
