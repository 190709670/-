//
//  DES.h
//  aes
//
//  Created by Jack_wang on 14-5-27.
//  Copyright (c) 2014年 Jack_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DES : NSObject
+ (NSString *)encryptWithText:(NSString *)sText;//加密
+ (NSString *)decryptWithText:(NSString *)sText;//解密

+(NSData *)dataFromHexString:(NSString *)str ;


+ (NSString *)encryptLoginWithText:(NSString *)sText;
+ (NSString *)decryptLoginWithText:(NSString *)sText;

+ (NSString *)encryptSanJinWithText:(NSString *)sText;
//

@end
