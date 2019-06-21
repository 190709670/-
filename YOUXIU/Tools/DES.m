//
//  DES.m
//  aes
//
//  Created by Jack_wang on 14-5-27.
//  Copyright (c) 2014年 Jack_wang. All rights reserved.
//

#import "DES.h"
#import "GTMBase64.h"
#import<CommonCrypto/CommonCryptor.h>
#import "NSString+URLEncoding.h"
@implementation DES
static  NSString*key=@"azsxdcfv";
static  NSString*loginKey=@"s!m2y#@$";
static NSString *sanjin=@"9f0300c2a088fc405a57eb1052dbaa15";
//@"tpKtfps2S9XqYebwFOMlMuMYANjcYNEbohmUa0iL";

#define DE_CONST(konst, var) \
do { \
union { const void *k; void *v; } _u; \
_u.k = konst; \
var = _u.v; \
} while (0)


+ (NSString *)encryptSanJinWithText:(NSString *)sText
{
    //kCCEncrypt 加密
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:sanjin];
}

+ (NSString *)encryptWithText:(NSString *)sText
{
    //kCCEncrypt 加密
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:key];
}

+ (NSString *)decryptWithText:(NSString *)sText
{
    //kCCDecrypt 解密
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:key];
}

+ (NSString *)encryptLoginWithText:(NSString *)sText
{
    //kCCEncrypt 加密
    return [self encrypt:sText encryptOrDecrypt:kCCEncrypt key:loginKey];
}

+ (NSString *)decryptLoginWithText:(NSString *)sText
{
    //kCCDecrypt 解密
    return [self encrypt:sText encryptOrDecrypt:kCCDecrypt key:loginKey];
}


+(NSData *)dataFromHexString:(NSString *)str {
    const char *chars = [str UTF8String];
    int i = 0, len = str.length;
    
    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0','\0','\0'};
    unsigned long wholeByte;
    
    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    return data;
}

+(NSString *)byteArr2HexStr:(NSData *)data {
    NSUInteger capacity = [data length] * 2;
    NSMutableString *stringBuffer = [[NSMutableString alloc] initWithCapacity:capacity];
    const unsigned char *dataBuffer = [data bytes];
    NSInteger i;
    for (i=0; i<[data length]; ++i) {
        [stringBuffer appendFormat:@"%02x", (NSUInteger)dataBuffer[i]];
    }
    return [NSString stringWithString:stringBuffer];
}


+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key
{
    const void *dataIn;
    size_t dataInLength;
    
    if (encryptOperation == kCCDecrypt)//传递过来的是decrypt 解码
    {
        //解码 base64
//        NSData *decryptData = [GTMBase64 decodeData:[sText dataUsingEncoding:NSUTF8StringEncoding]];//转成utf-8并decode
        NSData *decryptData = [self dataFromHexString:sText];
        dataInLength = [decryptData length];
//        dataInLength = (([decryptData length]%8 ==0) ?[decryptData length]:([decryptData length]/8+1)*8 );
        dataIn = [decryptData bytes];
    }
    else  //encrypt
    {
        
        NSData* encryptData = [sText dataUsingEncoding:NSUTF8StringEncoding];
        dataInLength = [encryptData length];
//        dataInLength = (([encryptData length]%8 ==0) ?[encryptData length]:([encryptData length]/8+1)*8 );        
        dataIn = (const void *)[encryptData bytes];
    }
    
    /*
     DES加密 ：用CCCrypt函数加密一下，然后用base64编码下，传过去
     DES解密 ：把收到的数据根据base64，decode一下，然后再用CCCrypt函数解密，得到原本的数据
     */
    CCCryptorStatus ccStatus;
    uint8_t *dataOut = NULL; //可以理解位type/typedef 的缩写（有效的维护了代码，比如：一个人用int，一个人用long。最好用typedef来定义）
    size_t dataOutAvailable = 0; //size_t  是操作符sizeof返回的结果类型
    size_t dataOutMoved = 0;
    
    dataOutAvailable = (dataInLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    dataOut = malloc( dataOutAvailable * sizeof(uint8_t));
    memset((void *)dataOut, 0x0, dataOutAvailable);//将已开辟内存空间buffer的首 1 个字节的值设为值 0
    
    const void *vkey = (const void *) [key UTF8String];
    Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};

    
    ccStatus = CCCrypt(encryptOperation,//  加密0/解密1
                       kCCAlgorithmDES,//  加密根据哪个标准（des，3des，aes。。。。）
                       kCCOptionECBMode|kCCOptionPKCS7Padding,//  选项分组密码算法(des:对每块分组加一次密  3DES：对每块分组加三个不同的密)
                       vkey,  //密钥    加密和解密的密钥必须一致
                       kCCKeySizeDES,//   DES 密钥的大小（kCCKeySizeDES=8）
                       iv, //  可选的初始矢量
                       dataIn, // 数据的存储单元
                       dataInLength,// 数据的大小
                       (void *)dataOut,// 用于返回数据
                       dataOutAvailable,
                       &dataOutMoved);
    
    NSString *result = nil;
    
    if (encryptOperation == kCCDecrypt)//encryptOperation==1  解码
    {
        //得到解密出来的data数据，改变为utf-8的字符串
        NSString* resultString = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved] encoding:NSUTF8StringEncoding] ;
         result =[resultString URLDecodedString];

    }
    else //encryptOperation==0  （加密过程中，把加好密的数据转成base64的）
    {
        //编码 base64
        NSData *data = [NSData dataWithBytes:(const void *)dataOut length:(NSUInteger)dataOutMoved];
        result = [self byteArr2HexStr:data];
    }
    
    return result;
}
@end
