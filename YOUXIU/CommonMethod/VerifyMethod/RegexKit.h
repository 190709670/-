//
//  RegexKit.h
//  Shsm
//
//  Created by oo_life on 14-9-3.
//
//

#import <Foundation/Foundation.h>

@interface RegexKit : NSObject
//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//用户名
+ (BOOL) validateUserName:(NSString *)name;

//用户昵称效验
+ (BOOL) ValidateUserNickName:(NSString *)string;

//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//身份证号 开头是14位或者17位数字，结尾可以是数字或者是x或者是X
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//真实姓名 只允许中文
+ (BOOL) validateRealname: (NSString *)realname;
//判断是不是网络地址
+ (BOOL) validateURL:(NSString *)urlStirng;


//身份证效验，最后一位计算得知  (下面俩是辅助)
+(BOOL)checkIDCard:(NSString *)idCard;
//身份证号码效验，长度
+(BOOL)checkLength:(NSString *)idCard newIDFlag:(BOOL)newIDFlag;
// 获取时间串
+(NSString *)getIDDate:(NSString *)idCard newIDFlag:(BOOL)newIDFlag;
// 判断时间合法性
+(BOOL)checkDate:(NSString *)dateSource;
//限制输入的字符
+(BOOL)validateStringIsOutLegalString:(NSString *)string;

@end
