//
//  SPDCommand.m
//  userclient
//
//  Created by sdzhu on 15/11/4.
//  Copyright © 2015年 supaide. All rights reserved.
//

#import "SPDCommand.h"
//#import "SupaideTplCache.h"
#import "UISupaideHybridWebViewController.h"
//#import "PatchManager.h"
#import "MBProgressHUD.h"
@implementation SupaideHybridModel
@end

@interface SPDCommand()
{
    __weak UISupaideHybridWebViewController *_viewController;
}
@end

@implementation SPDCommand

- (instancetype)initWithViewController:(UISupaideHybridWebViewController *)viewController{
    self = [super init];
    if(self){
        _viewController = viewController;
    }
    return self;
}

#pragma baseMethod

- (void)opSuccess:(SupaideHybridModel *)hybrid
{
    NSString *event = [hybrid.params objectForKey:@"event"];
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@:",event]);
    if([self respondsToSelector:sel])
    {
        [self performSelector:sel withObject:hybrid];
    }
    else
    {
        NSLog(@"hybrid opSuccess method -> %@ 不存在",event);
    }
}

- (void)goBack:(SupaideHybridModel *)hybridModel
{
    if(self.viewController.navigationController && self.viewController.navigationController.viewControllers.count > 1)
    {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    }
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
    
}

- (void)goForward:(SupaideHybridModel *)hybridModel
{
    NSString *url = [hybridModel.params objectForKey:@"url"];
    NSString *title = [hybridModel.params objectForKey:@"title"];
    UISupaideHybridWebViewController *ctrl = [[UISupaideHybridWebViewController alloc] initWithUrl:url title:title];
    if(self.viewController.navigationController)
    {
        [self.viewController.navigationController pushViewController:ctrl animated:YES];
    }
    else
    {
        [self.viewController presentViewController:ctrl animated:YES completion:nil];
    }
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
}

- (void)showLoading:(SupaideHybridModel *)hybridModel
{
    NSString *text = [hybridModel.params objectForKey:@"message"];
    [MBProgressHUD showHUDAddedTo:self.viewController.view lableText:text];
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
}

- (void)hideLoading:(SupaideHybridModel *)hybridModel
{
    [MBProgressHUD hideAllHUDsForView:self.viewController.view];
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
}

- (void)alert:(SupaideHybridModel *)hybridModel
{
    NSString *title = [hybridModel.params objectForKey:@"title"];
    NSString *message = [hybridModel.params objectForKey:@"message"];
    NSString *sure = [hybridModel.params objectForKey:@"sureText"];
    NSString *cancel = [hybridModel.params objectForKey:@"cancelText"];
    NSString *callback = [hybridModel.params objectForKey:@"callback"];
    
//    [BlockAlertView alertWithTitle:title message:message cancelButtonWithTitle:cancel cancelBlock:^{
//        [self doJSWithCallback:callback status:statusSuccess dictionary:@{@"result":@(NO)}];
//    } confirmButtonWithTitle:sure confrimBlock:^{
//        [self doJSWithCallback:callback status:statusSuccess dictionary:@{@"result":@(YES)}];
//    }];
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
}

- (void)showToast:(SupaideHybridModel *)hybridModel
{
    
}

//取模板
- (void)getTpl:(SupaideHybridModel *)hybridModel{
    NSString *url = [hybridModel.params objectForKey:@"url"];
    //    url = @"http://img.spd56.cn/driver/html_to_js/??taskhall/index.js,taskhall/taskItem.js";
    NSLog(@"hybrid getTpl url = %@",url);
    //    //从url获取模板
    
//    if([SupaideTplCache instance].useCache){
//        [SupaideTplCache getTplWithUrl:url success:^(NSString *result) {
//            NSLog(@"SupaideTplCache getTplWithUrl : %@",result);
//            [self doJSWithCallback:hybridModel.callback status:statusSuccess string:[[result stringByReplacingOccurrencesOfString:@"\r" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
//        } fail:^{
//            [self doJSWithCallback:hybridModel.callback status:statusFail];
//        }];
//
//    }
//    else{
//        [AFNetClient GlobalGetText:url parameters:@{} success:^(AFHTTPRequestOperation *operation, NSString *responseString) {
//            NSLog(@"response = %@",responseString);
//            [self doJSWithCallback:hybridModel.callback status:statusSuccess string:[[responseString stringByReplacingOccurrencesOfString:@"\r" withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [self doJSWithCallback:hybridModel.callback status:statusFail];
//        }];
//    }
    
}

//获取接口取数据
- (void)post:(SupaideHybridModel *)hybridModel{
    NSString *url = [hybridModel.params objectForKey:@"url"];
    NSDictionary *params = [hybridModel.params objectForKey:@"data"];
    NSLog(@"hybrid post url = %@ , params = %@",url,params);
    
//    [CommonMethod GlobalUrl:@{@"url":url,@"requestType":@"post"} parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *dataDict) {
//        [self doJSWithCallback:hybridModel.callback status:statusSuccess dictionary:dataDict];
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self doJSWithCallback:hybridModel.callback status:statusFail];
//    } refreshTokenFail:^{
//        [self doJSWithCallback:hybridModel.callback status:statusSuccess dictionary:@{@"status":@(-3),@"result":@{}}];
//    }];
    
//    [AFNetClient GlobalPost:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *dataDict) {
//        [self doJSWithCallback:hybridModel.callback status:statusSuccess dictionary:dataDict];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [self doJSWithCallback:hybridModel.callback status:statusFail];
//    }];
}

- (void)setWebTitle:(SupaideHybridModel *)hybridModel{
    NSString *title = [hybridModel.params objectForKey:@"message"];
    [self.viewController setTitle:title];
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
}

- (void)forward:(SupaideHybridModel *)hybridModel{
    [self.viewController recordHistory];
    [self doJSWithCallback:hybridModel.callback status:statusSuccess];
}


#pragma -mark private

#pragma -mark SupaideJavascirptProtocal
- (void)callAppWithMethod:(NSString *)method params:(JSValue *)params callbackId:(NSString *)callbackId {
    
    //线程锁
    @synchronized(self){
        NSLog(@"callApp method = %@ , callbackId = %@, params = %@",method,callbackId,params);
        
        SupaideHybridModel *hybrid = [[SupaideHybridModel alloc] init];
        hybrid.cmd = method;
        hybrid.callback = callbackId;
        hybrid.params = @{};
        if(params.isObject){
            NSDictionary *dic = [params toDictionary];
            hybrid.params = dic;
            
            NSLog(@"callApp method = %@ , callbackId = %@, params = %@",method,callbackId,dic);
        }
        [self excuteCmd:hybrid];
    }
}


- (void)excuteCmd:(SupaideHybridModel *)hybrid
{
    if([hybrid isKindOfClass:[SupaideHybridModel class]]){
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@:",hybrid.cmd]);
        if([self respondsToSelector:sel])
        {
//            [self performSelector:sel withObject:hybrid afterDelay:0.1];
            [self performSelectorOnMainThread:sel withObject:hybrid waitUntilDone:NO];
        }
        else
        {
            NSLog(@"excuteCmd method -> %@ 不存在",hybrid.cmd);
        }
    }
}

- (void)excuteJs:(NSString *)jsString
{
    //    [self performSelectorOnMainThread:@selector(doJSString:) withObject:jsString waitUntilDone:YES];
    [self performSelector:@selector(doJSString:) withObject:jsString afterDelay:0.1]; //否则会阻塞js的UI
    //    [self doJSString:jsString];
}

- (void)doJSString:(NSString *)jsString
{
    NSLog(@"doJSString: %@",jsString);
    @synchronized(self){
        [self.viewController excuteJs:jsString];
    }
}

- (NSString *)dictionaryToJson:(NSDictionary *)dictionary
{
    if(!dictionary){
        return nil;
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status
{
    [self doJSWithCallback:callback status:status string:nil];
}

- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status string:(NSString *)string
{
    if(isBlankString(callback))
    {
        return;
    }
    NSString *jsString ;
    if(isBlankString(string))
    {
        jsString = [NSString stringWithFormat:@"SPD.jsCallback('%@')",callback];
    }
    else
    {
        jsString = [NSString stringWithFormat:@"SPD.jsCallback('%@','%@')",callback,string];
    }
    NSLog(@"hybrid callbackJSString = %@",jsString);
    [self excuteJs:jsString];
}

- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status jsonArgs:(NSString *)jsonArgs
{
    if(isBlankString(callback))
    {
        return;
    }
    NSString *jsString ;
    if(isBlankString(jsonArgs))
    {
        jsString = [NSString stringWithFormat:@"SPD.jsCallback('%@')",callback];
    }
    else
    {
        jsString = [NSString stringWithFormat:@"SPD.jsCallback('%@',%@)",callback,jsonArgs];
    }
    NSLog(@"hybrid callbackJSString = %@",jsString);
    [self excuteJs:jsString];
}

- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status dictionary:(NSDictionary *)dictionary
{
    NSString *jsonArgs = [self dictionaryToJson:dictionary];
    [self doJSWithCallback:callback status:statusSuccess jsonArgs:jsonArgs];
}

- (UISupaideHybridWebViewController *)viewController{
    return _viewController;
}

- (void)dealloc{
    _viewController = nil;
}

@end
