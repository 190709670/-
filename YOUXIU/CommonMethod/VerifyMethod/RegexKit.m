//
//  RegexKit.m
//  Shsm
//
//  Created by oo_life on 14-9-3.
//
//

#import "RegexKit.h"
#import <math.h>
@implementation RegexKit

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^0?(13[0-9]|15[012356789]|18[0-9]|14[579]|17[0135678])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}
//用户昵称效验
+ (BOOL) ValidateUserNickName:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }else{
    NSString *eSymbol = @"[-`=\\[\\];',./~!@#$%^&*()_+{}|:\"<>?`~！@#￥%……&*（）——+{}|：“《》？`【】、；’。、， ]";
    NSString *cEx = @"[\u4e00-\u9fa5]+";//中文
    NSString *eEx = @"[0-9a-zA-Z]+";//英文
    
    NSPredicate *eSymobl_Pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",eSymbol];
    NSPredicate *cEx_Pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",cEx];
    NSPredicate *eEx_Pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",eEx];
    
    NSLog(@"1: %@  2:%@  3:%@",[eSymobl_Pre evaluateWithObject:string]?@"YES":@"NO",[cEx_Pre evaluateWithObject:string]?@"YES":@"NO",[eEx_Pre evaluateWithObject:string]?@"YES":@"NO");
    if([eSymobl_Pre evaluateWithObject:string]||
       [cEx_Pre evaluateWithObject:string]||
       [eEx_Pre evaluateWithObject:string]
       ){
        return YES;
    }else{
        return NO;
    }
    }
}
//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
  //  NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![@#$%&_]+$)[A-Za-z0-9(!@#$%&_]{6,16}$";
    NSString *passWordReChar=@"^(.*?)[A-Za-z]+(.*?){6,16}$";
    NSString *passWordReNumber =@"^(.*?)\\d+(.*?){6,16}$";
    
    NSPredicate *passWordPredicateChar = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordReChar];
    NSPredicate *passWordPredicateNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordReNumber];
    BOOL haveChar =[passWordPredicateChar evaluateWithObject:passWord];
    BOOL haveNum =[passWordPredicateNum evaluateWithObject:passWord];
    return haveChar&&haveNum;
}

+ (BOOL) validateURL:(NSString *)urlStirng{
   // NSString *phoneRegex = @"^0?(13[0-9]|15[012356789]|18[0-9]|14[579]|17[0135678])[0-9]{8}$";
    NSString *urlRegexChar = @"^(https://|http://)[\\s\\S]*";
    NSPredicate *urlPassWordPredicateChar = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegexChar];
    BOOL isurl = [urlPassWordPredicateChar evaluateWithObject:urlStirng];
    return  isurl;
}

//身份证号 
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    NSMutableString *iden =[NSMutableString stringWithFormat:@"%@",identityCard];
    [iden replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, iden.length)];
    BOOL flag;
    if (iden.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:iden];
}

//身份证号码效验，长度
+(BOOL)checkLength:(NSString *)idCard newIDFlag:(BOOL)newIDFlag{
    int oldIDLen = 15;
    int newIDLen = 18;
    BOOL right =(idCard.length ==oldIDLen)||(idCard.length ==newIDLen);
    newIDFlag =false;
    if (right) {
        newIDFlag =(idCard.length ==newIDLen);
    }
    return right;
}
// 获取时间串
+(NSString *)getIDDate:(NSString *)idCard newIDFlag:(BOOL)newIDFlag{
    NSMutableString *dateStr =[[NSMutableString alloc] init];
    int fPart = 6;  // 身份证前部分字符数
    NSString *yearFlag =@"19"; // 新身份证年份标志

    if (newIDFlag){
      //NSString *s = [@"123456789012345678" substringWithRange:NSMakeRange(2,4)];
        dateStr =[NSMutableString stringWithString:[idCard substringWithRange:NSMakeRange(fPart,8)]];
    }else{
        dateStr =[NSMutableString stringWithFormat:@"%@%@",yearFlag,[idCard substringWithRange:NSMakeRange(fPart,6)]];
    }
    return dateStr;
}
//身份证效验，最后一位计算得知
+(BOOL)checkIDCard:(NSString *)idCard{
   // 新身份证长度
    int newIDLen = 18;
    BOOL isNew =(idCard.length ==newIDLen);
    
    if (![self checkLength:idCard newIDFlag:isNew]) {
        return NO;
    }
    NSString *idDate =[self getIDDate:idCard newIDFlag:isNew];
    if (![ self checkDate:idDate] ) {
        return NO;
    }
    if (isNew) {
        NSString *checkFlag =[self getCheckFlag:idCard];
        NSString *theFlag =[idCard substringWithRange:NSMakeRange(idCard.length -1,1)];
        if (![checkFlag isEqualToString:theFlag]) {
            return NO;
        }
    }else{
        return NO;
    }
    return YES;
}
// 获取新身份证的最后一位:检验位
+(NSString *)getCheckFlag:(NSString *)idCard{
    NSString *CheckCode = @"10X98765432";
    int sum = 0;
   int fMod =11;
    NSMutableArray *Wi =[[NSMutableArray alloc] init];
    
    //初始化wi［］数组
    for (int i=0; i< 17; i++) {
        int k =(int)pow(2, 17 -i);
        [ Wi addObject: [NSNumber numberWithInt:k%fMod]];
    }
    
    // 进行加权求和
    for (int i = 0; i < 17; i++) {
        sum += [[idCard substringWithRange:NSMakeRange(i, 1)] intValue]*[Wi[i] intValue];
        
    }

    // 取模运算，得到模值
    int iCode = sum % fMod;
    return [CheckCode substringWithRange:NSMakeRange(iCode, 1)];
}
// 判断时间合法性
+(BOOL)checkDate:(NSString *)dateSource {
    NSString *dateStr =[NSString stringWithFormat:@"%@-%@-%@",[dateSource substringWithRange:NSMakeRange(0, 4)],[dateSource substringWithRange:NSMakeRange(4, 2)],[dateSource substringWithRange:NSMakeRange(6,2)]];
 
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.timeZone=[[NSTimeZone alloc]initWithName:@"GMT"];
    NSDate *date =[dateFormatter dateFromString:dateStr];
    @try {
        return (date != nil);
    }
    @catch (NSException *exception) {
        return NO;
    }
}

//真实姓名 
+ (BOOL) validateRealname: (NSString *)realname
{
    BOOL flag;
    if (realname.length <= 0) {
        flag = NO;
        return flag;
    }
    NSInteger length =realname.length;
    BOOL zhongwen=YES;
    for (int i=0; i<length; i++) {
        NSRange range =NSMakeRange(i, 1);
        NSString *subString =[realname substringWithRange:range];
        const char *CString =[subString UTF8String];
        if(CString!=NULL){
        if (strlen(CString)==3) {
           
        }else{
            zhongwen =NO;
        }
        }else{
            zhongwen =NO;
        }
    }
    return zhongwen;
}
//限制输入的字符
+(BOOL)validateStringIsOutLegalString:(NSString *)string{
    //NSString *LegalString=@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_+-=,./;\\|…?':<>{}[]()*&^%$#@!~`\";";
    NSString *LegalString = @"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ-/:;()$&@\".,?!'[]{}#%^*+=_\\|~<>";
    if ([string isEqualToString:@""]) {//删除的时候
        return YES;
    }
    if([LegalString rangeOfString:string].location == NSNotFound){
        return NO;
    }else{
        return YES;
    }
}
@end
