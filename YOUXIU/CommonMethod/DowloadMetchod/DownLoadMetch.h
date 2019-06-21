//
//  DownLoadMetch.h
//  YOUXIU
//
//  Created by lihui on 2018/7/16.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DownLoadDelegate <NSObject>
-(void)DownLoadingProgress:(NSProgress *)progress FilePath:(NSString *)FileURL DownloadTask:(NSURLSessionDownloadTask *)DownloadTask;
-(void)DownLoadedfinished:(NSString *)FileURL DownloadTask:(NSURLSessionDownloadTask *)DownloadTask;

/**
 解压
 
 @param Rate 解压比例
 */
-(void)UnZipRateWith:(CGFloat)Rate;
-(void)UnZipSuccess;
-(void)UnZipFailure;
@end
@interface DownLoadMetch : NSObject
@property (nonatomic, retain) id <DownLoadDelegate> delegate;
+(DownLoadMetch *)shareInstance;
/**
 获取下载中的文件
 @return 下载中的文件数组
 */
-(NSArray *)GetDownLoadingFileIsSingleMusic:(BOOL)isSingleMusic;
/**
 获取下载完成的文件
 @return 下载完成的文件数组
 */
-(NSArray *)GetDownLoadedFileIsSingleMusic:(BOOL)isSingleMusic;

/**
 获取文件信息

 @param FileURL 文件网络地址
 @return 文件信息的DIC
 */
-(NSDictionary *)GetFileDicWithFileURL:(NSString *)FileURL;
/**
 按指定的url开始下载
 */
-(void)StartLoadFileWithPath:(NSString *)FilePath fileName:(NSString *)fileName fileDic:(NSDictionary *)fileDic isSingleMusic:(BOOL)isSingleMusic complete:(void(^)(id))complete;
/**
 设置文件下载完成
 @param FileURL 文件网络地址，
 */
-(void)FileDownLoadComplete:(NSString *)FileURL;
/**
 查询该url是否存在
 */
-(BOOL)TaskIsExist:(NSString *)FilePath;
/**
 删除下载任务以及文件
 @param FileURL 文件的url
 */
-(void)DeledateTaskAndFile:(NSString *)FileURL;
/**
 按指定的url重新下载
 */
-(void)ResumeLoadFileWithPath:(NSString *)FilePath downType:(NSString *)downtype;
/**
 按指定的url暂停下载
 */
-(void)StopLoadFileWithPath:(NSString *)FilePath downType:(NSString *)downtype;
/**
 按指定的url重新下载
 */
-(void)ResumeLoadFileWithPath:(NSString *)FilePath Success:(void(^)(bool result))Success;
/**
 按指定的url暂停下载
 */
-(void)StopLoadFileWithPath:(NSString *)FilePath Success:(void(^)(bool result))Success;


/**
 查询该url状态
 */
-(NSInteger)GetTaskState:(NSString *)FilePath downType:(NSString *)downtype;

@end
