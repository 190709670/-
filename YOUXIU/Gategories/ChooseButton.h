//
//  ChooseButton.h
//  TheGenuine
//
//  Created by lihui on 16/4/19.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseBtnDelegate <NSObject>
-(BOOL)ChooseBtnValueChange:(BOOL)ison chooseBtn:(id)sender;
-(void)chooseDidEndWithChoosestate:(BOOL)choosestate chooseBtn:(id)sender;
@end

@interface ChooseButton : UIButton
@property(nonatomic) BOOL choosed;
@property (nonatomic) id object;
@property (nonatomic, retain) id <ChooseBtnDelegate> delegate;
-(void)click;
-(void)setChoosed;
-(void)setUnChoosed;
@end
