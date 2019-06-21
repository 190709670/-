//
//  DownLoadedTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/7/18.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadedTableViewCell : UITableViewCell
-(void)setCellInfoWithFileInfo:(NSDictionary *)dic;
+(NSInteger)CellHeight;

@end
