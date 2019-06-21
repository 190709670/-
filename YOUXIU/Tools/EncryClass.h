//
//  EncryClass.h
//  TheGenuine
//
//  Created by lihui on 16/4/6.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryClass : NSObject
//普通字符串转换为十六进制的。
+(NSData *)dataFromHexString:(NSString *)str;
+(NSString *)byteArr2HexStr:(NSData *)data;
+(NSString *)AES128Encrypt:(NSString *)plainText;
+(NSString *)AES128Decrypt:(NSString *)encryptText;
@end
