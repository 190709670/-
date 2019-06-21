//
//  PlayViewController.h
//  YOUXIU
//
//  Created by lihui on 2018/4/10.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "BaseViewController.h"

@interface PlayViewController : BaseViewController
@property (nonatomic, retain) NSString *MusicID;
@property (nonatomic, retain) NSDictionary *hotsongDic;
@property (nonatomic, assign) BOOL isWXP;
@property (nonatomic, assign) BOOL isSingleMusic;
@property (nonatomic, assign) BOOL isLocalType;
@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *UnZipPath;
@property (nonatomic, assign) BOOL showTuPu;
@end
