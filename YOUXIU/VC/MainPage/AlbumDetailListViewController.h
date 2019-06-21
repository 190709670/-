//
//  AlbumDetailListViewController.h
//  YOUXIU
//
//  Created by lihui on 2018/6/4.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "BaseViewController.h"

@interface AlbumDetailListViewController : BaseViewController
@property (nonatomic, retain) NSString *AlbumID;
@property (nonatomic, retain) NSDictionary *AlbumInfo;

@property (nonatomic, assign) BOOL isLocal;
@property (nonatomic, retain) NSString *albumName;
@end
