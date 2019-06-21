//
//  BaseRequest.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest
+(id)share_MainViewRequest{
    static dispatch_once_t pred;
    static id share = nil;
    dispatch_once(&pred, ^{
        share = [[self alloc] init];
    });
    return share;
}

-(AFHTTPSessionManager *)getManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"userAgent"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:version forHTTPHeaderField:@"Version"];
    [manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"System-Version"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/javascript",@"text/html" ,nil];
    manager.requestSerializer.timeoutInterval = 10.0f;
    return manager;
}

-(void)RequestWithPost:(NSString *)urlString parameters:(NSString *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[self getManager] POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress : %@",[uploadProgress description]);
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSDictionary *userInfo1 = @{
                                    NSLocalizedDescriptionKey:@"网络开小差，请稍后再试",
                                    };
        NSError *CustonError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo1];
        failure(CustonError);
    }];
}

-(void)RequestWithGet:(NSString *)urlString parameters:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[self getManager] GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"uploadProgress : %@",[downloadProgress description]);
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSDictionary *userInfo1 = @{
                                    NSLocalizedDescriptionKey:@"网络开小差，请稍后再试"
                                    };
        NSError *CustonError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:userInfo1];
        failure(CustonError);
    }];
}

-(id)RequestSynWithGet:(NSString *)urlString parameters:(NSDictionary *)params{
    NSError *error = nil;
    id responseObj = [[self getManager] syncGET:urlString parameters:params task:NULL error:&error];
    return responseObj;
}

//传body
-(void)RequestWithPost:(NSString *)urlString body:(NSDictionary *)body success:(void(^)(id result))success failure:(void(^)(NSError *error))failure{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:5];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"ios" forHTTPHeaderField:@"userAgent"];
    NSString *version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [request setValue:version  forHTTPHeaderField:@"Thegenuine-version"];
    [request setValue:[NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]] forHTTPHeaderField:@"system-version"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:body options:NSJSONWritingPrettyPrinted  error:nil]];
    
    urlConnection =[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES];
    self.success=success;
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    xmldata =nil;
    urlConnection =nil;
    self.failure(error);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (xmldata==nil){
        xmldata=[[NSMutableData alloc]init];
    }
    [xmldata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error;
    NSDictionary *Dictionary =[NSJSONSerialization JSONObjectWithData:xmldata options:NSJSONReadingAllowFragments error:&error];
    self.success(Dictionary);
}
@end
