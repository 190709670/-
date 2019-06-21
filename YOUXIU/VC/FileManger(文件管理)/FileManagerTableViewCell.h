//
//  FileManagerTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/24.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FileManagerTableViewCell;
typedef void (^RigBtnClickBlock)(FileManagerTableViewCell *);

@interface FileManagerTableViewCell : UITableViewCell
@property (nonatomic, copy) RigBtnClickBlock rightbtnclickBlock;
+ (CGFloat)cellHeight;
-(void)setFileInfoWith:(id)FileInfo isLocal:(BOOL)Local;
@end
