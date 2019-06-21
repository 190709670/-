//
//  BaseMethod.m
//  QiXiuApp
//
//  Created by lihui on 2017/5/31.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseMethod.h"
#import "MacroDefine.h"
#import "MacroKeyWord.h"
#import "MBProgressHUD.h"
#import "EncryClass.h"
#import "LoginMainViewController.h"
#import "BaseNavigationViewController.h"
#import "WXApi.h"
#import "NetWorkingRequest.h"
#import "RootTabBarViewController.h"
@implementation BaseMethod
+(BOOL)isNewVersionFirstLaunch{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *appVersion = [userDefaults valueForKey:Macro_Version];
    if ([appVersion isEqualToString:Macro_AppVersion]){
        return NO;
    }else{
        [userDefaults setValue:Macro_AppVersion forKey:Macro_Version];
        return YES;
    }
}

+(CGSize)GetFitSize_With:(UIFont *)font String:(NSString *)string Size:(CGSize)size{
    CGRect s = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return s.size;
}
+(NSString *)getEncryAes128KeyID{
    NSDate *date =[NSDate new];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr =[NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    NSString *key =[EncryClass AES128Encrypt:dateStr];
    return key;
}

#pragma mark peopleinfo
+(BOOL)UserIsLogin{
   NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
   BOOL login = [[userinfo valueForKey:UserIsLogin_KeyWord] boolValue];
    return login;
}
+(BOOL)UserIsLoginAndShowLoginVC:(UIViewController<LoginDelegate> *)CurrentView{
    BOOL isLogin = [BaseMethod UserIsLogin];
    if (!isLogin) {
        LoginMainViewController *loginVC = [[LoginMainViewController alloc] init];
        loginVC.delegate = CurrentView;
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:loginVC];
        [CurrentView presentViewController:nav animated:YES completion:nil];
    }
        return isLogin;
}

+(void)SetUserLogin:(BOOL)isLogin{
    NSUserDefaults *userinfo = [NSUserDefaults standardUserDefaults];
     [userinfo setValue:[NSNumber numberWithBool:isLogin] forKey:UserIsLogin_KeyWord];
}
+(void)SetUserInfo:(id)userinfo{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:userinfo forKey:UserInfo_KeyWord];
    [archiver finishEncoding];
    
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserDataFile_KeyWord];
    [data writeToFile:file atomically:YES];

}
+(PeopleInfoModel *)getUserInfo{
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserDataFile_KeyWord];
    NSData *data = [NSData dataWithContentsOfFile:file];
    
    NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
   id userinfo = [archiver decodeObjectForKey:UserInfo_KeyWord];
    
    PeopleInfoModel *model = [[PeopleInfoModel alloc] init];
    [model setValuesForKeysWithDictionary:userinfo];
    
    return model;
}
+(NSString *)getUserAccount{
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserDataFile_KeyWord];
    NSData *data = [NSData dataWithContentsOfFile:file];
    
    NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id userinfo = [archiver decodeObjectForKey:UserInfo_KeyWord];
    
    PeopleInfoModel *model = [[PeopleInfoModel alloc] init];
    [model setValuesForKeysWithDictionary:userinfo];
    PeopleInfoDataModel *datamodel = model.data;
    NSString *account = datamodel.account?datamodel.account:@"";
    return account;
}

+(void)DelegateUserInfo{
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserDataFile_KeyWord];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:file error:nil];
}

//#pragma mark 用户选择车系
//+(void)SetUserChooseCarBrand:(findCarBrandAllDataModel *)carBrand carSeries:(CarSeriesDataModel *)carSeries car:(CarModeldataModel *)car{
//    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserInfo_ChooseCarInfo_file];
//    
//    NSInteger thisCarBrandID = carBrand.thisid?carBrand.thisid:0;
//    NSInteger thisCarSeriesID = carSeries.thisid?carSeries.thisid:0;
//    NSInteger thisCarID = car.thisid?car.thisid:0;
//    
//    NSString *thisCarBrandName = carBrand.name?carBrand.name:@"";
//    NSString *thisCarSeriesName = carSeries.name?carSeries.name:@"";
//    NSString *thisCarName = car.name?car.name:@"";
//
//    NSString *thisCarBrandImage = carBrand.icon?carBrand.icon:@"";
//    NSString *thisCarSeriesImage = carSeries.image?carSeries.image:@"";
//    NSString *thisCarImage = car.image?car.image:@"";
//    
//    NSDictionary *userChoosedCarInfo = @{
//                                         UserChoose_CarBrand:@{
//                                                    UserChoose_Image:thisCarBrandImage,
//                                                    UserChoose_ID:[NSNumber numberWithInteger:thisCarBrandID],
//                                                    UserChoose_Name:thisCarBrandName
//                                                 },
//                                         UserChoose_CarSeries:@{
//                                                 UserChoose_Image:thisCarSeriesImage,
//                                                 UserChoose_ID:[NSNumber numberWithInteger:thisCarSeriesID],
//                                                 UserChoose_Name:thisCarSeriesName
//                                                 },
//                                         UserChoose_Car:@{
//                                                 UserChoose_Image:thisCarImage,
//                                                 UserChoose_ID:[NSNumber numberWithInteger:thisCarID],
//                                                 UserChoose_Name:thisCarName
//                                                 }
//                                        };
//    [userChoosedCarInfo writeToFile:filePath atomically:YES];
//}

+(NSDictionary *)GetUserChoose{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserInfo_ChooseCarInfo_file];
    NSDictionary *ChooseCarInfo = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return ChooseCarInfo;
}
+(void)DeleCarBrand{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserInfo_ChooseCarInfo_file];
    NSMutableDictionary *ChooseCarInfo = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    [ChooseCarInfo removeObjectForKey:UserChoose_CarBrand];
    [ChooseCarInfo writeToFile:filePath atomically:YES];
}
+(void)DeleCarSeries{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserInfo_ChooseCarInfo_file];
    NSMutableDictionary *ChooseCarInfo = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    [ChooseCarInfo removeObjectForKey:UserChoose_CarSeries];
    [ChooseCarInfo writeToFile:filePath atomically:YES];
}
+(void)DeleCarID{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:UserInfo_ChooseCarInfo_file];
    NSMutableDictionary *ChooseCarInfo = [NSMutableDictionary dictionaryWithDictionary:[NSDictionary dictionaryWithContentsOfFile:filePath]];
    [ChooseCarInfo removeObjectForKey:UserChoose_Car];
    [ChooseCarInfo writeToFile:filePath atomically:YES];
}
+(NSString *)getDateStringWithTimestamp:(NSInteger)timestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *createtime = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSString *createtimeString = [formatter stringFromDate:createtime];
    return createtimeString;
}

#pragma mark Loading
+ (void)showLoading:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
}
+ (void)showLoadingWithText:(NSString *)text inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text= text;
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES];
}
+ (void)hideAllHudsInView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}
+ (void)showToast:(NSString *)text hideAfterSecond:(NSInteger)second inView:(UIView *)view{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(17)]];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, - 100.f)];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:second];
}
+(void)showToastOnWindowWithString:(NSString *)text hideAfterSecond:(NSInteger)second{
    UIApplication *application = [UIApplication sharedApplication];
   UIWindow *window = [application keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(17)]];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, - 100.f)];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:second];
}
+ (void)showSpecialToastOnWindow:(NSString *)text hideAfterSecond:(NSInteger)second{
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *window = [application keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    [hud.detailsLabel setTextColor:[UIColor whiteColor]];
    [hud setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.8]];
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(17)]];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, 00.f)];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:second];
}

+ (void)showDeveloperWaitingView{
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *window = [application keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = @"尚未开放";
    [hud.detailsLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(17)]];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, - 100.f)];
    hud.userInteractionEnabled = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:Macro_ShowLoadingDefaultTime];
}
+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];  //  这方法下面有详解    </span>
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}
#pragma mark 支付宝支付结果代码解析
+(void)AlipayRechargeWithAlipayCode:(NSInteger)AlipayCode Result:(void(^)(NSDictionary* result))result{
    NSDictionary *dic;
    switch (AlipayCode) {
        case 9000:
            dic = @{
                    @"success":[NSNumber numberWithBool:YES],
                    @"msg":@"订单支付成功"
                    };
            break;
        case 8000:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"正在处理中,请稍后查询"
                    };
            break;
        case 4000:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"支付失败"
                    };
            break;
        case 5000:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"重复请求"
                    };
            break;
        case 6001:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"用户取消"
                    };
            break;
        case 6002:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"网络连接出错"
                    };
            break;
        case 6004:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"未获取支付状态，请稍后查询"
                    };
            break;
        default:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"未知错误，请稍后再试"
                    };
            break;
    }
    result(dic);
}
#pragma mark 微信支付结果解析
+(void)WXRechargeWithWXCode:(NSInteger)WXCode Result:(void(^)(NSDictionary* result))result{
    NSDictionary *dic;
    switch (WXCode) {
        case WXSuccess :
            dic = @{
                    @"success":[NSNumber numberWithBool:YES],
                    @"msg":@"订单支付成功"
                    };
            break;
        case WXErrCodeCommon:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"发生错误，请稍后再试"
                    };
            break;
        case WXErrCodeUserCancel:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"用户取消"
                    };
            break;
        case WXErrCodeSentFail:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"请求失败"
                    };
            break;
        case WXErrCodeAuthDeny:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"授权失败"
                    };
            break;
        case WXErrCodeUnsupport:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"微信不支持"
                    };
        default:
            dic = @{
                    @"success":[NSNumber numberWithBool:NO],
                    @"msg":@"未知错误，请稍后再试"
                    };
            break;
    }
    result(dic);
}
+ (UIImage *)imageWithColor:(UIColor *)color//颜色直接转图片（借鉴的其他大牛的代码）
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/**
 获取购物车数量
 */
+(void)CartVCUpDateCartNumber{
    [[NetWorkingRequest share_MainViewRequest] SendCartListAccount:[BaseMethod getUserAccount] Success:^(BaseModel *info) {
        if(info.success){
            RootTabBarViewController *VC = (RootTabBarViewController *)[UIApplication sharedApplication].delegate.window.rootViewController;
            NSInteger number = [[NSMutableArray arrayWithArray:info.data[@"items"]] count];
            UITabBarItem *item = VC.tabBar.items[1];
            if (number == 0) {
                item.badgeValue = nil;
            }else{
                item.badgeValue = [NSString stringWithFormat:@"%ld",number];
            }
        }
    } failure:^(NSError *error) {
    }];
}
@end
