//
//  BaseMethod.h
//  QiXiuApp
//
//  Created by lihui on 2017/5/31.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PeopleInfoModel.h"
//#import "findCarBrandAllModel.h"
//#import "CarSeriesModel.h"
//#import "CarModelModel.h"

@interface BaseMethod : NSObject

/**
 是否是新版本第一次启动

 @return YES 新版本第一次启动
 */
+(BOOL)isNewVersionFirstLaunch;
+(CGSize)GetFitSize_With:(UIFont *)font String:(NSString *)string Size:(CGSize)size;
+(NSString *)getEncryAes128KeyID;

#pragma mark PeopleInfo
+(BOOL)UserIsLogin;
+(BOOL)UserIsLoginAndShowLoginVC:(UIViewController *)CurrentView;
+(void)SetUserLogin:(BOOL)isLogin;
+(void)SetUserInfo:(id)userinfo;
+(PeopleInfoModel *)getUserInfo;
+(NSString *)getUserAccount;
+(void)DelegateUserInfo;

#pragma mark 用户选择车系
//+(void)SetUserChooseCarBrand:(findCarBrandAllDataModel *)carBrand carSeries:(CarSeriesDataModel *)carSeries car:(CarModeldataModel *)car;
#pragma mark 根据时间戳获取时间
+(NSString *)getDateStringWithTimestamp:(NSInteger)timestamp;
/**
 用户已选择的车辆信息
 @return 车牌 UserChoose_CarBrandID，车系UserChoose_CarSeriesID，具体车辆UserChoose_CarID
 */
+(NSDictionary *)GetUserChoose;
+(void)DeleCarBrand;
+(void)DeleCarSeries;
+(void)DeleCarID;
#pragma mark loadingView
+ (void)showLoading:(UIView *)view;
+ (void)showLoadingWithText:(NSString *)text inView:(UIView *)view;
+ (void)hideAllHudsInView:(UIView *)view;
+ (void)showToast:(NSString *)text hideAfterSecond:(NSInteger)second inView:(UIView *)view;
+ (void)showToastOnWindowWithString:(NSString *)text hideAfterSecond:(NSInteger)second;
+ (void)showSpecialToastOnWindow:(NSString *)text hideAfterSecond:(NSInteger)second;
#pragma mark DeveloperingWaiting
+ (void)showDeveloperWaitingView;

#pragma mark 用户登录
+(UIViewController *)getCurrentVC;
#pragma mark 支付宝支付结果代码解析
+(void)AlipayRechargeWithAlipayCode:(NSInteger)AlipayCode Result:(void(^)(NSDictionary* result))result;
#pragma mark 微信支付结果解析
+(void)WXRechargeWithWXCode:(NSInteger)WXCode Result:(void(^)(NSDictionary* result))result;
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 获取购物车数量
 */
+(void)CartVCUpDateCartNumber;
@end
