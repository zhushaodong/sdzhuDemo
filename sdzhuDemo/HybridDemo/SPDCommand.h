//
//  SPDCommand.h
//  userclient
//
//  Created by sdzhu on 15/11/4.
//  Copyright © 2015年 supaide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#define statusSuccess 1
#define statusFail -1
@protocol SupaideJavascirptProtocal <JSExport>

JSExportAs(callApp,
           - (void)callAppWithMethod:(NSString *)method params:(JSValue *)params callbackId:(NSString *)callbackId);
@end

@interface SupaideHybridModel : NSObject
@property (nonatomic,copy)  NSString *callback;
@property (nonatomic,copy)  NSString *cmd;
@property (nonatomic,strong)  NSDictionary *params;
@end

@class UISupaideHybridWebViewController;

@interface SPDCommand : NSObject<SupaideJavascirptProtocal>

- (instancetype)initWithViewController:(UISupaideHybridWebViewController *)viewController;

//@property (nonatomic,weak) UISupaideHybridWebViewController *viewController;

- (UISupaideHybridWebViewController *)viewController;

- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status;
- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status string:(NSString *)string;
- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status jsonArgs:(NSString *)jsonArgs;
- (void)doJSWithCallback:(NSString *)callback status:(NSInteger)status dictionary:(NSDictionary *)dictionary;
- (void)excuteJs:(NSString *)jsString;
@end
