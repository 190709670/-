//
//  CustomSelectedCellTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSelectedCellTableViewCell : UITableViewCell
+(NSInteger)CellHeight;
-(void)setCellInfoWithDic:(NSDictionary *)InfoDic Recomment:(NSString *)Recomment;
-(void)setSelectBtnSelected:(BOOL)Selected;
-(BOOL)CellSelectedStatus;
@end
