//
//  TuPuViewController.h
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "BaseViewController.h"

@interface TuPuViewController : BaseViewController
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger selectedNumber;
@property (nonatomic, strong) NSArray *TuPuArray;
@property (nonatomic, assign) BOOL isLocalType;
@end
