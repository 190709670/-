//
//  UnZipMetchod.m
//  YOUXIU
//
//  Created by lihui on 2018/3/21.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "UnZipMetchod.h"
#import "FilePatchMetch.h"
#import <SSZipArchive/SSZipArchive.h>
@implementation UnZipMetchod
+(void)UnZipMetchod:(NSString *)filename isSingleMusic:(BOOL)isSingleMusic progressHandler:(void (^)(NSString *entry,long entryNumber, long total))progressHandler completionHandler:(void (^)(NSString *path, BOOL succeeded, NSError * error))completionHandler{
    if(filename == nil){
        NSLog(@"未获取filename");
        return ;
    }
    //需要解压的文件路径
    NSString *zipPath = [[FilePatchMetch getUserDownLoadZipPatch] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",isSingleMusic?@"FileType_SingleMusic":@"FileType_AlbumMusic",filename]];
    //解压到的文件夹
    NSString *UnZipPath = [[FilePatchMetch getUserUnZipFilePatch] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",isSingleMusic?@"FileType_SingleMusic":@"FileType_AlbumMusic"]];

    [SSZipArchive unzipFileAtPath:zipPath toDestination:UnZipPath progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        progressHandler(entry,entryNumber,total);
    } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        completionHandler(path,succeeded,error);
        NSLog(@"解压完成");
    }];
}

@end

