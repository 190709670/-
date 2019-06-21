//
//  PoinoTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoinoTableViewCell : UITableViewCell
+(NSInteger)CellHeight;
-(void)setPoinoTableViewCellWithDicInfo:(NSDictionary *)dic;
@property (nonatomic,strong) void (^ThisCellSelectedBlock)(PoinoTableViewCell *);
@end
