//
//  ChooseButton.m
//  TheGenuine
//
//  Created by lihui on 16/4/19.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import "ChooseButton.h"

@implementation ChooseButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setBackgroundImage:[UIImage imageNamed:@"icon_select_nor"] forState:UIControlStateNormal];

    self.choosed=NO;
    [self addTarget:self action:@selector(selfclick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setChoosed{
    self.choosed=YES;
    [self setBackgroundImage:[UIImage imageNamed:@"icon_select_sel"] forState:UIControlStateNormal];
}
-(void)setUnChoosed{
    [self setBackgroundImage:[UIImage imageNamed:@"icon_select_nor"] forState:UIControlStateNormal];
    self.choosed=NO;
}
-(void)selfclick:(id)sender{
    if (self.delegate!=nil) {
        if ([self.delegate respondsToSelector:@selector(ChooseBtnValueChange:chooseBtn:)]) {
            if ([self.delegate ChooseBtnValueChange:self.choosed chooseBtn:self]) {
                if (self.choosed) {
                    [self setUnChoosed];
                }else{
                    [self setChoosed];
                }
            }else{//返回NO。不操作
                
            }
        }else{//没实现delegate方法，
            if (self.choosed) {
                [self setUnChoosed];
            }else{
                [self setChoosed];
            }
        }
        if ([self.delegate respondsToSelector:@selector(chooseDidEndWithChoosestate:chooseBtn:)]) {
            [self.delegate chooseDidEndWithChoosestate:self.choosed chooseBtn:self];
        }
    }else{//没有实现delegate
        if (self.choosed) {
            [self setUnChoosed];
        }else{
            [self setChoosed];
        }
    }

}
-(void)click{
    [self selfclick:nil];
}
@end
