//
//  DownLoadPlistMetch.m
//  YOUXIU
//
//  Created by lihui on 2018/7/18.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownLoadPlistMetch.h"
#import "FilePatchMetch.h"
#import "DownLoadMetch.h"
#define DownLoad_PlistFileName @"DownLoad_FileName.plist"
#define DownLoad_FileName @"DownLoad_FileName"
#define DownLoad_URL @"DownLoad_URL"
#define DownLoad_isLoad @"DownLoad_isLoad"
#define DownLoad_Rate @"DownLoad_Rate"
#define DownLoad_Author @"DownLoad_Author"
#define DownLoad_FileSize @"DownLoad_FileSize"
#define DownLoad_DownType @"DownLoad_DownType"
@implementation DownLoadPlistMetch
/**
 开始下载时存入下载文件的其它信息
 @param FileName 文件名
 @param FilePath 文件url
 */
+(void)setDowndLoadTaskInfo:(NSDictionary *)FileDic FileURL:(NSString *)FileURL FileDownLoadPath:(NSString *)FileDownLoadPath DownType:(NSString *)DownType{
    NSString *EnCodeFileURL = FileURL;
    //[FileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    //获取plist文件路径
    NSString *filePatch = [self GetDownLoadFilePath];
    //读取plist文件到dic中
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    //按类型获取该分类下歌曲信息
    NSMutableDictionary *MusicTypeDic = [plistFileInfo valueForKey:DownType];
    if(MusicTypeDic == nil){
        MusicTypeDic = [[NSMutableDictionary alloc] init];
    }
    //
    NSMutableDictionary *musicFileInfo = [[NSMutableDictionary alloc] init];
    [musicFileInfo setValuesForKeysWithDictionary:FileDic];
    [musicFileInfo setValue:FileDownLoadPath forKey:DownLoad_URL];
    [musicFileInfo setValue:[NSNumber numberWithInteger:0] forKey:DownLoad_isLoad];
    
    [MusicTypeDic setValue:musicFileInfo forKey:EnCodeFileURL];
    [plistFileInfo setValue:MusicTypeDic forKey:DownType];
    [plistFileInfo writeToFile:filePatch atomically:YES];
}
+(void)FileDownLoadComplete:(NSString *)FileURL{
    NSString *EnCodeFileURL = FileURL;
    //= [FileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; 下载时已经编码过了

    NSString *filePath = [self GetDownLoadFilePath];
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    
    //获取单曲信息字典
    NSMutableDictionary *singleMusic_All = [plistFileInfo valueForKey:FileType_SingleMusic];
    NSMutableDictionary *singleMusic = singleMusic_All[EnCodeFileURL];
    
    //获取专辑信息字典
    NSMutableDictionary *AlbumMusic_All = [plistFileInfo valueForKey:FileType_AlbumMusic];
    NSMutableDictionary *AlbumMusic = AlbumMusic_All[EnCodeFileURL];
    
    if (singleMusic != nil) {
        [singleMusic setValue:[NSNumber numberWithInteger:1] forKey:DownLoad_Rate];
        [singleMusic setValue:[NSNumber numberWithInteger:2] forKey:DownLoad_isLoad];
        
        [singleMusic_All setValue:singleMusic forKey:EnCodeFileURL];
        [plistFileInfo setValue:singleMusic_All forKey:FileType_SingleMusic];
        [plistFileInfo writeToFile:filePath atomically:YES];
    }else if(AlbumMusic != nil){
        [AlbumMusic setValue:[NSNumber numberWithInteger:1] forKey:DownLoad_Rate];
        [AlbumMusic setValue:[NSNumber numberWithInteger:2] forKey:DownLoad_isLoad];
        
        [AlbumMusic_All setValue:AlbumMusic forKey:EnCodeFileURL];
        [plistFileInfo setValue:AlbumMusic_All forKey:FileType_AlbumMusic];
        [plistFileInfo writeToFile:filePath atomically:YES];
    }else{
        NSLog(@"未找到该url的下载信息");
    }
}
/**
 设置下载状态
 @param isLoading 0 下载，1暂停 ,2 下载完成
 @param FilePath 文件url
 */
+(void)UpDateTaskState:(NSInteger)isLoading FilePath:(NSString *)FilePath downloadRate:(CGFloat)downLoadRate downLoadSize:(CGFloat)downLoadSize FileInfo:(NSDictionary *)FileInfo DownType:(NSString *)DownType{
    if(FilePath == nil){
        NSLog(@"更新时未获取该url文件信息，退出执行");
        return;
    }
    NSString *EnCodeFileURL = FilePath;
    //= [FilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *filePatch = [self GetDownLoadFilePath];
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    NSMutableDictionary *MusicTypeDic = [plistFileInfo valueForKey:DownType];
    NSMutableDictionary *musicFileInfo = [MusicTypeDic valueForKey:EnCodeFileURL];
    if (MusicTypeDic == nil || musicFileInfo == nil) {
        NSLog(@"无该文件信息");
        return;
    }

    CGFloat filesize = downLoadSize/(1024*1024);
    if(FileInfo != nil){
        [musicFileInfo setValuesForKeysWithDictionary:FileInfo];
    }
    [musicFileInfo setValue:[NSNumber numberWithInteger:isLoading] forKey:DownLoad_isLoad];
    if (isLoading != 1){
        [musicFileInfo setValue:[NSNumber numberWithDouble:downLoadRate] forKey:DownLoad_Rate];
        [musicFileInfo setValue:[NSNumber numberWithFloat:filesize] forKey:DownLoad_FileSize];
    }
    [MusicTypeDic setValue:musicFileInfo forKey:EnCodeFileURL];
    [plistFileInfo setValue:MusicTypeDic forKey:DownType];
    [plistFileInfo writeToFile:filePatch atomically:YES];
}
/**
 获取任务下载状态
 
 @param FilePath 文件url
 @return isLoading 0 下载，1暂停 ,2 下载完成
 */
+(NSInteger)getTaskStateWithFilePath:(NSString *)FilePath DownType:(NSString *)DownType{
    NSString *EnCodeFileURL = [FilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

     NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    NSMutableDictionary *musicTypeDic = plistFileInfo[DownType];
    NSDictionary *musicFileInfo = [musicTypeDic valueForKey:EnCodeFileURL];
   NSInteger downloadstate = [[musicFileInfo valueForKey:DownLoad_isLoad] integerValue];
    return downloadstate;
}
/**
 获取下载中的文件信息
 */
+(NSArray *)GetDownLoadingFileInfoDownType:(NSString *)DownType{
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    NSMutableDictionary *musicTypeDic = plistFileInfo[DownType];

    NSMutableArray *downloadingArray = [[NSMutableArray alloc] init];
    
   NSArray *allDownarray = [musicTypeDic allValues];
   downloadingArray = [NSMutableArray arrayWithArray:[allDownarray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"DownLoad_isLoad != 2"]]];
    return downloadingArray;
}
/**
 获取下载完成的文件信息
 */
+(NSArray *)GetDownLoadedFileInfoDownType:(NSString *)DownType{
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    NSMutableDictionary *musicTypeDic = plistFileInfo[DownType];

    NSMutableArray *downloadingArray = [[NSMutableArray alloc] init];    
    NSArray *allDownarray = [musicTypeDic allValues];
    downloadingArray = [NSMutableArray arrayWithArray:[allDownarray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"DownLoad_isLoad == 2"]]];
    return downloadingArray;
}
/**
 删除下载的文件
 */
+(void)DeledateFileInfoWithPath:(NSString *)FileURL{
    NSString *EnCodeFileURL = [FileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *filePath = [self GetDownLoadFilePath];
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    
    //获取单曲信息字典
    NSMutableDictionary *singleMusic_All = [plistFileInfo valueForKey:FileType_SingleMusic];
    NSMutableDictionary *singleMusic = singleMusic_All[EnCodeFileURL];
    
    //获取专辑信息字典
    NSMutableDictionary *AlbumMusic_All = [plistFileInfo valueForKey:FileType_AlbumMusic];
    NSMutableDictionary *AlbumMusic = AlbumMusic_All[EnCodeFileURL];
    
    NSFileManager *filemanger = [NSFileManager defaultManager];
    if (singleMusic != nil) {
//        NSDictionary *dic = [singleMusic objectForKey:FileURL];
        NSString *downloadPath = singleMusic[DownLoad_URL];
        BOOL result =  [filemanger removeItemAtPath:downloadPath error:nil];
        NSLog(@"文件删除 %@",result?@"删除成功":@"删除失败");
        [singleMusic_All removeObjectForKey:EnCodeFileURL];
        [plistFileInfo setValue:singleMusic_All forKey:FileType_SingleMusic];
        
    }else if(AlbumMusic != nil){
//        NSDictionary *dic = [AlbumMusic objectForKey:FileURL];
        NSString *downloadPath = AlbumMusic[DownLoad_URL];
       BOOL result =  [filemanger removeItemAtPath:downloadPath error:nil];
        NSLog(@"文件删除 %@",result?@"删除成功":@"删除失败");

        [AlbumMusic_All removeObjectForKey:EnCodeFileURL];
        [plistFileInfo setValue:AlbumMusic_All forKey:FileType_AlbumMusic];
    }else{
        NSLog(@"未找到该url的下载信息");
    }
    [plistFileInfo writeToFile:filePath atomically:YES];
}
+(BOOL)GetTaskIsExit:(NSString *)FilePath{
    NSString *filePath = [FilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //[self GetDownLoadFilePath];
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    
    //获取单曲信息字典
    NSMutableDictionary *singleMusic_All = [plistFileInfo valueForKey:FileType_SingleMusic];
    NSMutableDictionary *singleMusic = singleMusic_All[filePath];
    
    //获取专辑信息字典
    NSMutableDictionary *AlbumMusic_All = [plistFileInfo valueForKey:FileType_AlbumMusic];
    NSMutableDictionary *AlbumMusic = AlbumMusic_All[filePath];
    
    if (singleMusic != nil) {
        return YES;
    }else if(AlbumMusic != nil){
        return YES;
    }else{
        return NO;
    }
}
+(NSMutableDictionary *)GetDownLoadFileDic{
    NSString *patch = [FilePatchMetch getUserDownLoadZipPatch];
    NSString *plistPatch = [patch stringByAppendingPathComponent:DownLoad_PlistFileName];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:plistPatch]) {
        [fileManger createFileAtPath:plistPatch contents:nil attributes:nil];
    }
    NSMutableDictionary *plistFileInfo = [NSMutableDictionary dictionaryWithContentsOfFile:plistPatch];
    if (plistFileInfo == nil) {
        plistFileInfo = [[NSMutableDictionary alloc] init];
    }
    return plistFileInfo;
}
/**
 获取文件信息
 
 @param FileURL 文件网络地址
 @return 文件信息的DIC
 */
+(NSDictionary *)GetFileDicWithFileURL:(NSString *)FileURL{
    NSString *encodeURLStirng = [FileURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *filePath = [self GetDownLoadFilePath];
    NSMutableDictionary *plistFileInfo = [self GetDownLoadFileDic];
    
    //获取单曲信息字典
    NSMutableDictionary *singleMusic_All = [plistFileInfo valueForKey:FileType_SingleMusic];
    NSMutableDictionary *singleMusic = singleMusic_All[encodeURLStirng];
    
    //获取专辑信息字典
    NSMutableDictionary *AlbumMusic_All = [plistFileInfo valueForKey:FileType_AlbumMusic];
    NSMutableDictionary *AlbumMusic = AlbumMusic_All[encodeURLStirng];
    
    if (singleMusic != nil) {
        return singleMusic;
    }else if(AlbumMusic != nil){
        return AlbumMusic;
    }else{
        return nil;
    }
}
/**
 获取plist文件路径
 */
+(NSString *)GetDownLoadFilePath{
    NSString *patch = [FilePatchMetch getUserDownLoadZipPatch];
    NSString *plistPatch = [patch stringByAppendingPathComponent:DownLoad_PlistFileName];
    return plistPatch;
}


@end
