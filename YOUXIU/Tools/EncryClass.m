//
//  EncryClass.m
//  TheGenuine
//
//  Created by lihui on 16/4/6.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import "EncryClass.h"
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

#define gkey @"9f0300c2a088fc405a57eb1052dbaa15" //自行修改
#define gIv @""

@implementation EncryClass
+(NSString *)AES128Encrypt:(NSString *)plainText
{
    NSData *keyHexdata =[self dataFromHexString:gkey];
    NSString *keyStr =[[NSString alloc] initWithData:keyHexdata encoding:NSUTF8StringEncoding];
    const void *keyByte=[keyHexdata bytes];
    
    char keyPtr[kCCKeySizeAES128];
    memset(keyPtr, 0, sizeof(keyPtr));
    [keyStr getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    int dataLength = (int)[data length];
    
    int diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    int newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x00;
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    

    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          keyByte,
                                          kCCKeySizeAES128,
                                          ivPtr,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        NSString *hexStr =[self byteArr2HexStr:resultData];
        return hexStr;
    }
    free(buffer);
    return nil;
}

+(NSString *)AES128Decrypt:(NSString *)encryptText
{
    NSData *keyHexdata =[self dataFromHexString:gkey];
    NSString *keyStr =[[NSString alloc] initWithData:keyHexdata encoding:NSUTF8StringEncoding];
    const void *keyByte=[keyHexdata bytes];
    char keyPtr[kCCKeySizeAES128];
    memset(keyPtr, 0, sizeof(keyPtr));
    [keyStr getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    char ivPtr[kCCBlockSizeAES128];
    memset(ivPtr, 0, sizeof(ivPtr));
    [gIv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    
    
    
    NSData *data = [self dataFromHexString:encryptText];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus =CCCrypt(kCCDecrypt,
                                 kCCAlgorithmAES128,
                                 kCCOptionPKCS7Padding,
                                 keyByte,
                                 kCCBlockSizeAES128,
                                 ivPtr,
                                 [data bytes],
                                 dataLength,
                                 buffer,
                                 bufferSize,
                                 &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

+(NSData *)dataFromHexString:(NSString *)str {
    const char *chars = [str UTF8String];
    int i = 0, len = (int)str.length;
    
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
        [stringBuffer appendFormat:@"%02lx", (unsigned long)dataBuffer[i]];
    }
    return [NSString stringWithString:stringBuffer];
}
@end
