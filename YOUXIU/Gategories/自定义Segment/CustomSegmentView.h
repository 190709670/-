//
//  CustomSegmentView.h
//  TheGenuine
//
//  Created by lihui on 16/4/12.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomSegmentViewDelegate <NSObject>
-(void)customSegmentClick:(int)witchbtn;
@end

@interface CustomSegmentView : UIView
@property(nonatomic, retain) UIImageView *imageLine;
@property (nonatomic) CGFloat width;
@property (nonatomic, retain) UIColor *themecolor;
-(void)setTitles:(NSArray *)titles withColor:(UIColor *)color font:(UIFont *)font;
-(void)selectSegmentBtn:(int)btnNumber;
-(NSInteger)SelectedBtn;
@property (nonatomic, retain) id <CustomSegmentViewDelegate> delegate;
@end
