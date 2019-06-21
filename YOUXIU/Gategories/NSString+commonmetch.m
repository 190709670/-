//
//  NSString+commonmetch.m
//  TheGenuine
//
//  Created by lihui on 16/4/21.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import "NSString+commonmetch.h"

@implementation NSString (commonmetch)
-(BOOL)ishavevalue{
    if ([self isEqualToString:@""]||self==nil||self ==[NSNull class]) {
        return NO;
    }else{
        return YES;
    }
}
+(NSString *)getStringValueWithObject:(id)obj{
    if (obj==nil||obj ==[NSNull class]) {
        return  @"";
    }
    return  [NSString stringWithFormat:@"%@",obj];
}
@end
