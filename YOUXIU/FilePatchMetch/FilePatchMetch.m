//
//  FilePatchMetch.m
//  YOUXIU
//
//  Created by lihui on 2018/3/21.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "FilePatchMetch.h"

@implementation FilePatchMetch
+(NSString *)getUserFilePatch{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"/UserFile"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
+(NSString *)getUserDownLoadZipPatch{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"/DownLoad/DownFile"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
+(NSString *)getUserDownLoadZipPatchAppendCatalogue:(NSString *)catalogue{
    NSString *path = [self getUserDownLoadZipPatch];
    path = [path stringByAppendingPathComponent:catalogue];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+(NSString *)getUserUnZipFilePatch{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"/DownLoad/UnZip"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}
@end
