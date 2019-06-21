//
//  FilePatchMetch.h
//  YOUXIU
//
//  Created by lihui on 2018/3/21.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilePatchMetch : NSObject
+(NSString *)getUserFilePatch;
+(NSString *)getUserDownLoadZipPatch;
+(NSString *)getUserDownLoadZipPatchAppendCatalogue:(NSString *)catalogue;
+(NSString *)getUserUnZipFilePatch;
@end
