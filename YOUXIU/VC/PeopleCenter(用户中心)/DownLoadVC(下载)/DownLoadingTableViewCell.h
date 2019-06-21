//
//  DownLoadingTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/7/18.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomBtnAddObject.h"
@interface DownLoadingTableViewCell : UITableViewCell
@property (nonatomic, copy) void (^DownLoadingTableViewCellBlock)(CustomBtnAddObject *Btn);
-(void)setCellInfoWithFileInfo:(NSDictionary *)dic;
@property (nonatomic, retain) CustomBtnAddObject *Btn;
+(NSInteger)CellHeight;
@end
