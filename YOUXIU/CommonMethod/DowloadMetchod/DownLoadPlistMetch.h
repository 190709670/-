//
//  DownLoadPlistMetch.h
//  YOUXIU
//
//  Created by lihui on 2018/7/18.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FileType_SingleMusic  @"FileType_SingleMusic"
#define FileType_AlbumMusic  @"FileType_AlbumMusic"

@interface DownLoadPlistMetch : NSObject
/**
 下载时存入下载文件的其它信息
 @param FileDic 文件信息
 @param FileURL 文件的下载地址
 @param FileDownLoadPath 文件存储的路径
 */
+(void)setDowndLoadTaskInfo:(NSDictionary *)FileDic FileURL:(NSString *)FileURL FileDownLoadPath:(NSString *)FileDownLoadPath DownType:(NSString *)DownType;
/**
 文件下载完成
 @param FileURL 文件网络地址
 */
+(void)FileDownLoadComplete:(NSString *)FileURL;
/**
 更新下载信息
 @param isLoading 0 下载，1暂停 ,2 下载完成
 @param FilePath 文件url
 */
+(void)UpDateTaskState:(NSInteger)isLoading FilePath:(NSString *)FilePath downloadRate:(CGFloat)downLoadRate downLoadSize:(CGFloat)downLoadSize FileInfo:(NSDictionary *)FileInfo DownType:(NSString *)DownType;

/**
 获取任务下载状态

 @param FilePath 文件url
 @return0下载中，1暂停 2,完成
 */
+(NSInteger)getTaskStateWithFilePath:(NSString *)FilePath DownType:(NSString *)DownType;
/**
 获取下载中的文件路线
 */
+(NSArray *)GetDownLoadingFileInfoDownType:(NSString *)DownType;
/**
 获取下载完成的文件信息
 */
+(NSArray *)GetDownLoadedFileInfoDownType:(NSString *)DownType;
+(BOOL)GetTaskIsExit:(NSString *)FilePath;
/**
 删除下载的文件
 */
+(void)DeledateFileInfoWithPath:(NSString *)FilePath;
/**
 获取文件信息
 
 @param FileURL 文件网络地址
 @return 文件信息的DIC
 */
+(NSDictionary *)GetFileDicWithFileURL:(NSString *)FileURL;
@end
