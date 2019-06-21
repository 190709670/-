//
//  AlreadyPayTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/23.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AlreadyPayTableViewCell;
typedef void (^WXPBtnClickBlock)(AlreadyPayTableViewCell *);
typedef void (^JPClickBlock)(AlreadyPayTableViewCell *);

@interface AlreadyPayTableViewCell : UITableViewCell
@property(nonatomic, copy) WXPBtnClickBlock wxpBtnClickBlock;
@property(nonatomic, copy) JPClickBlock jpBtnClickBlock;
@property(nonatomic, assign) BOOL isSingleMusic;

+ (CGFloat)cellHeight;
-(void)setPayRecodInfoWithSingleInfo:(id)SingleInfo;
-(void)setCellStatus:(BOOL)isDowned info:(NSString *)info;
@end
