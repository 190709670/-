//
//  UnZipMetchod.h
//  YOUXIU
//
//  Created by lihui on 2018/3/21.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnZipMetchod : NSObject
//+(void)UnZipMetchod:(NSString *)patch;
+(void)UnZipMetchod:(NSString *)filename isSingleMusic:(BOOL)isSingleMusic progressHandler:(void (^)(NSString * entry, long entryNumber, long total))progressHandler completionHandler:(void (^)(NSString *  path, BOOL succeeded, NSError * error))completionHandler;
@end
