//
//  MainPageSingleMusicTableViewCell.h
//  YOUXIU
//
//  Created by lihui on 2018/5/27.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainPageSingleMusicTableViewCell;
typedef void (^AddToCartsBlock)(MainPageSingleMusicTableViewCell *);
typedef void (^WXPBtnClickBlock)(MainPageSingleMusicTableViewCell *);
typedef void (^JPClickBlock)(MainPageSingleMusicTableViewCell *);


@interface MainPageSingleMusicTableViewCell : UITableViewCell
@property(nonatomic, copy) AddToCartsBlock addToCartsBlock;
@property(nonatomic, copy) WXPBtnClickBlock wxpBtnClickBlock;
@property(nonatomic, copy) JPClickBlock jpBtnClickBlock;

-(void)setSingleMusicWithInfo:(id)sender;
-(void)setSingleAddCartStatus:(NSInteger)status;
+(NSInteger)CellHeight;
@end
