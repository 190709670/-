//
//  NSString+URLEncoding.h
//  sixin
//
//  Created by qaz218098 on 13-6-24.
//  Copyright (c) 2013年 Netcoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncodingAdditions)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end