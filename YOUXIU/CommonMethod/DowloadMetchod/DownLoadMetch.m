//
//  DownLoadMetch.m
//  YOUXIU
//
//  Created by lihui on 2018/7/16.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownLoadMetch.h"
#import <AFNetworking/AFNetworking.h>
#import "FilePatchMetch.h"
#import "DownLoadPlistMetch.h"
#import "UnZipMetchod.h"
@interface DownLoadMetch(){
}
@property (nonatomic, retain) AFURLSessionManager *urlSessionManager;
@property (nonatomic, retain) NSMutableDictionary *downTaskDic;
@end
@implementation DownLoadMetch
+(DownLoadMetch *)shareInstance{
    static dispatch_once_t pred;
    static id share = nil;
    dispatch_once(&pred, ^{
        share = [[self alloc] init];
    });
    return share;
}

-(AFURLSessionManager *)GetURLSessionManager{
    if(self.urlSessionManager == nil){
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self.urlSessionManager;
}
/**
 获取下载中的文件
 @return 下载中的文件数组
 */
-(NSArray *)GetDownLoadingFileIsSingleMusic:(BOOL)isSingleMusic{
    return  [DownLoadPlistMetch GetDownLoadingFileInfoDownType:isSingleMusic?FileType_SingleMusic:FileType_AlbumMusic];
}
/**
 获取下载完成的文件
 @return 下载完成的文件数组
 */
-(NSArray *)GetDownLoadedFileIsSingleMusic:(BOOL)isSingleMusic{
    return [DownLoadPlistMetch GetDownLoadedFileInfoDownType:isSingleMusic?FileType_SingleMusic:FileType_AlbumMusic];
}
/**
 获取文件信息
 
 @param FileURL 文件网络地址
 @return 文件信息的DIC
 */
-(NSDictionary *)GetFileDicWithFileURL:(NSString *)FileURL{
    return [DownLoadPlistMetch GetFileDicWithFileURL:FileURL];
}
/**
 按指定的url开始下载
 */
-(void)StartLoadFileWithPath:(NSString *)FilePath fileName:(NSString *)fileName fileDic:(NSDictionary *)fileDic isSingleMusic:(BOOL)isSingleMusic complete:(void(^)(id))complete{
    AFURLSessionManager *manager = [self GetURLSessionManager];
    
    //生成下载文件存放地址
    NSArray *array = [FilePath componentsSeparatedByString:@"/"];
    NSString *DownLoadfileNameAndType = array[array.count - 1];
    NSString *downloadPath = [FilePatchMetch getUserDownLoadZipPatchAppendCatalogue:isSingleMusic?FileType_SingleMusic:FileType_AlbumMusic];
    NSString *DownLoad_StoragePath = [downloadPath stringByAppendingPathComponent:DownLoadfileNameAndType];
    
    //生成下载请求
    FilePath = [FilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:FilePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downLoadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * downloadProgress) {
            CGFloat size = downloadProgress.totalUnitCount;
        //实时更新下载信息
        [DownLoadPlistMetch UpDateTaskState:0 FilePath:FilePath downloadRate:downloadProgress.fractionCompleted  downLoadSize:size FileInfo:fileDic DownType:isSingleMusic?FileType_SingleMusic:FileType_AlbumMusic];
        if ([self.delegate respondsToSelector:@selector(DownLoadingProgress:FilePath:DownloadTask:)]) {
            [self.delegate DownLoadingProgress:downloadProgress FilePath:FilePath DownloadTask:downLoadTask];
        }
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) { //返回下载数据存放的路径
        return [NSURL fileURLWithPath:DownLoad_StoragePath];
    } completionHandler:^(NSURLResponse * response, NSURL * filePath, NSError * error) {
        NSLog(@"error info: %@",error.description);
        //下载完成，更新状态
        //成功下载时，记录下载的信息
        [[DownLoadMetch shareInstance] FileDownLoadComplete:FilePath];
        //解压
        [UnZipMetchod UnZipMetchod:response.suggestedFilename isSingleMusic:isSingleMusic progressHandler:^(NSString *entry, long entryNumber, long total) {
            if ([self.delegate respondsToSelector:@selector(UnZipRateWith:)]) {
                [self.delegate UnZipRateWith:entryNumber/total];
            }
        } completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
            if (succeeded) {
                if([self.delegate respondsToSelector:@selector(UnZipSuccess)]) {
                    [self.delegate UnZipSuccess];
                }
            }else{
                if ([self.delegate respondsToSelector:@selector(UnZipFailure)]) {
                    [self.delegate UnZipFailure];
                }
            }
        }];
        if ([self.delegate respondsToSelector:@selector(DownLoadedfinished:DownloadTask:)]) {
            [self.delegate DownLoadedfinished:FilePath DownloadTask:downLoadTask];
        }
        complete(filePath);
    }];
    
    //任务开始，记录状态，记录到plist中
    [DownLoadPlistMetch setDowndLoadTaskInfo:fileDic FileURL:FilePath FileDownLoadPath:DownLoad_StoragePath DownType:isSingleMusic?FileType_SingleMusic:FileType_AlbumMusic];
    [downLoadTask resume];
    
    //将任务加入数组
    [self.downTaskDic setValue:downLoadTask forKey:FilePath];
    [self DownTaskWriteToFile];
}
-(void)FileDownLoadComplete:(NSString *)FileURL{
    [self.downTaskDic removeObjectForKey:FileURL];
     [self DownTaskWriteToFile];
    [DownLoadPlistMetch FileDownLoadComplete:FileURL];
}
-(void)DownTaskWriteToFile{
  NSString *filePath = [FilePatchMetch getUserDownLoadZipPatch];
   filePath = [filePath stringByAppendingPathComponent:@"TaskDic.plist"];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:filePath]) {
        [filemanager createFileAtPath:filePath contents:nil attributes:nil];
    }
    NSMutableDictionary *fileDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    [self.downTaskDic setValue:@"1111" forKey:@"22222"];
    [fileDic setValuesForKeysWithDictionary:self.downTaskDic];
    [fileDic writeToFile:filePath atomically:YES];
}
-(NSMutableDictionary *)getTaskDic{
    NSString *filePath = [FilePatchMetch getUserDownLoadZipPatch];
   filePath = [filePath stringByAppendingPathComponent:@"TaskDic.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}
/**
 按指定的url重新下载
 */
-(void)ResumeLoadFileWithPath:(NSString *)FilePath DownType:(NSString *)downtype{
    NSURLSessionTask *downloadTask = [self.downTaskDic valueForKey:FilePath];
    if(downloadTask.state == NSURLSessionTaskStateSuspended){
        [DownLoadPlistMetch UpDateTaskState:0 FilePath:FilePath downloadRate:1 downLoadSize:0 FileInfo:@[] DownType:downtype];
        [downloadTask resume];
        [self DownTaskWriteToFile];
    }
}
/**
 按指定的url暂停下载
 */
-(void)StopLoadFileWithPath:(NSString *)FilePath DownType:(NSString *)downtype{
    NSURLSessionTask *downloadTask = [self.downTaskDic valueForKey:FilePath];
    if (downloadTask.state == NSURLSessionTaskStateRunning) {
        [DownLoadPlistMetch UpDateTaskState:1 FilePath:FilePath downloadRate:1 downLoadSize:0 FileInfo:@[] DownType:downtype];
        [downloadTask suspend];
        [self DownTaskWriteToFile];
    }
}

/**
 按指定的url重新下载
 */
-(void)ResumeLoadFileWithPath:(NSString *)FilePath Success:(void(^)(bool result))Success{
    NSURLSessionTask *downloadTask = [self.downTaskDic valueForKey:FilePath];
    if (downloadTask == nil) {
        Success(NO);
        return;
    }else{
        Success(YES);
    }
    if(downloadTask.state == NSURLSessionTaskStateSuspended){
        [DownLoadPlistMetch UpDateTaskState:0 FilePath:FilePath downloadRate:1 downLoadSize:0 FileInfo:@[] DownType:FileType_SingleMusic];
        [DownLoadPlistMetch UpDateTaskState:0 FilePath:FilePath downloadRate:1 downLoadSize:0 FileInfo:@[] DownType:FileType_AlbumMusic];
        [downloadTask resume];
        [self DownTaskWriteToFile];
    }
}
/**
 按指定的url暂停下载
 */
-(void)StopLoadFileWithPath:(NSString *)FilePath Success:(void(^)(bool result))Success{
    NSURLSessionTask *downloadTask = [self.downTaskDic valueForKey:FilePath];
    if (downloadTask == nil) {
        Success(NO);
        return;
    }else{
        Success(YES);
    }
    if (downloadTask.state == NSURLSessionTaskStateRunning) {
        [DownLoadPlistMetch UpDateTaskState:1 FilePath:FilePath downloadRate:1 downLoadSize:0 FileInfo:@[] DownType:FileType_SingleMusic];
        [DownLoadPlistMetch UpDateTaskState:1 FilePath:FilePath downloadRate:1 downLoadSize:0 FileInfo:@[] DownType:FileType_AlbumMusic];
        [downloadTask suspend];
        [self DownTaskWriteToFile];
    }
}

//0,单曲，1专辑
-(BOOL)TaskIsExist:(NSString *)FilePath{
    BOOL isExit = [DownLoadPlistMetch GetTaskIsExit:FilePath];
    return isExit;
}
/**
 删除下载任务以及文件
 @param FileURL 文件的url
 */
-(void)DeledateTaskAndFile:(NSString *)FileURL{
    //删除字典内存储的 NSURLSessionDownloadTask
    [self.downTaskDic removeObjectForKey:FileURL];
    //删除plist文件中存储的任务信息,和下载完成的文件
    [DownLoadPlistMetch DeledateFileInfoWithPath:FileURL];
    [self DownTaskWriteToFile];
}

-(NSURLSessionTaskState)GetTaskState:(NSString *)FilePath DownType:(NSString *)downtype{
    NSInteger taskStatus = [DownLoadPlistMetch getTaskStateWithFilePath:FilePath DownType:downtype];
    return taskStatus;
}

-(NSMutableDictionary *)downTaskDic{
    if (_downTaskDic == nil) {
        //文件读取task信息
        _downTaskDic = [self getTaskDic];
        if (_downTaskDic == nil) {
            _downTaskDic = [[NSMutableDictionary alloc] init];
        }
    }
    return _downTaskDic;
}
@end

