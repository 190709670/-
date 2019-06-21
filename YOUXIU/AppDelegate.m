//
//  AppDelegate.m
//  YOUXIU
//
//  Created by lihui on 2018/3/20.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "AppDelegate.h"
#import "MacroDefine.h"
#import "GuidePageViewController.h"
#import "RootTabBarViewController.h"
#import "BaseMethod.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "RechargeViewController.h"
@interface AppDelegate ()<GuidePageDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setLaunchWindowWay];
    //注册app支付
    return YES;
}
/**
 设置程序加载时是加载引导页还是主页
 */
-(void)setLaunchWindowWay{
    UIWindow *window = [[UIWindow alloc] initWithFrame:Macro_ScreenBound];
    if (NO) {
        GuidePageViewController *guidePageVC = [[GuidePageViewController alloc] init];
        guidePageVC.delegate = self;
        window.rootViewController = guidePageVC;
    }else{
        RootTabBarViewController *tabbarVC = [[RootTabBarViewController alloc] init];
        window.rootViewController = tabbarVC;
    }
    
    self.window = window;
    [self.window makeKeyAndVisible];
}
-(void)guidePageDisapper{
    RootTabBarViewController *tabbarVC = [[RootTabBarViewController alloc] init];
    self.window.rootViewController = tabbarVC;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark 处理回调
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
     [self AlipayPayResultUrl:url];
    [self WXPayResultURL:url];
    return YES;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    [self AlipayPayResultUrl:url];
    [self WXPayResultURL:url];
    return YES;
}
-(void)WXPayResultURL:(NSURL *)Url{
    [WXApi handleOpenURL:Url delegate:self];
}
-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        [[NSNotificationCenter defaultCenter] postNotificationName:WXRechargeNotice object:response];
    }
}
-(void)AlipayPayResultUrl:(NSURL *)Url{
    if ([Url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:Url standbyCallback:^(NSDictionary *resultDic) {
            [[NSNotificationCenter defaultCenter] postNotificationName:AlipayRechargeNotice object:resultDic];
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:Url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
        }];
    }
}
@end
