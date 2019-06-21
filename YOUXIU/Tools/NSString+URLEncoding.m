//
//  NSString+URLEncoding.m
//  sixin
//
//  Created by qaz218098 on 13-6-24.
//  Copyright (c) 2013年 Netcoc. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (OAURLEncodingAdditions)

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            NULL,
                                            CFSTR("!*'();:@&=+$,/?%#[] "),
                                            kCFStringEncodingUTF8);
    [result autorelease];
    return result;
}

- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)
    CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                            (CFStringRef)self,
                                                            CFSTR(""),
                                                            kCFStringEncodingUTF8);
    [result autorelease];  
    return result;  
}  
@end