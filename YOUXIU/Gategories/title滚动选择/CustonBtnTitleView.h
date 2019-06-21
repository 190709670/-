//
//  CustonBtnTitleView.h
//  YOUXIU
//
//  Created by lihui on 2018/5/25.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustonBtnTitleView;
@protocol CustonBtnTitleViewDelegate <NSObject>
-(void)CustonBtnTitleView_BtnClick:(id)clickinfo titleview:(CustonBtnTitleView *)CustonBtnTitleView;
-(void)ShowBtnInfo:(id)ShowBtnInfo;
@end
@interface CustonBtnTitleView : UIView
-(void)setWithTitleArray:(NSArray *)titleArray;
-(void)setImagePostionTop:(BOOL)top;
-(void)SelectBtnPosition:(NSInteger)Position;
@property (nonatomic, retain) id <CustonBtnTitleViewDelegate> delegate;
@end
