//
//  BaseRequest.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "AFHTTPSessionManager+Synchronous.h"
@interface BaseRequest : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    NSMutableData *xmldata;
    NSURLConnection *urlConnection;
}
@property (nonatomic, copy) void (^success)(id);
@property (nonatomic, copy) void (^failure)(NSError *);

+(id)share_MainViewRequest;
-(AFHTTPSessionManager *)getManager;
-(void)RequestWithPost:(NSString *)urlString parameters:(NSString *)params success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
-(void)RequestWithGet:(NSString *)urlString parameters:(NSDictionary *)params success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
-(id)RequestSynWithGet:(NSString *)urlString parameters:(NSDictionary *)params;
-(void)RequestWithPost:(NSString *)urlString body:(NSDictionary *)body success:(void(^)(id result))success failure:(void (^)(NSError *error))failure;
@end
