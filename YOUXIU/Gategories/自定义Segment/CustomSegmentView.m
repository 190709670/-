//
//  CustomSegmentView.m
//  TheGenuine
//
//  Created by lihui on 16/4/12.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import "CustomSegmentView.h"
@interface CustomSegmentView()
@property (nonatomic, assign) NSInteger SelectedBtnCount;
@end
@implementation CustomSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setTitles:(NSArray *)titles withColor:(UIColor *)color font:(UIFont *)font{
    self.width=self.frame.size.width/[titles count];
    self.themecolor=color;
    for (int i=0; i<[titles count]; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title =[titles objectAtIndex:i];
        [btn setTitle:title forState:UIControlStateNormal];
        if (i == 0) {
            [btn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
        }else{
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        }
        [btn setFrame:CGRectMake(self.width*i, 0, self.width, self.frame.size.height)];
        [btn.titleLabel setFont:font];
        btn.tag=i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if (i+1<titles.count) {
            UIImageView *verticalline = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame),
                                                                                      5,
                                                                                      1,
                                                                                      btn.frame.size.height - 10)];
            [verticalline setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
            [self addSubview:verticalline];
        }
    }
    
}
-(void)selectSegmentBtn:(int)btnNumber{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag=btnNumber;
    if (btn.tag>KWidth/self.width) {
        NSLog(@"自定义Segumnet越界");
    }else{
        [self btnClick:btn];
        self.SelectedBtnCount = btnNumber;
    }
}

-(void)btnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *subbtn =(UIButton *)subview;
            [subbtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            if (subbtn.tag == btn.tag) {
                btn = subbtn;
            }
        }
    }
    [self.delegate customSegmentClick:(int)btn.tag];

    [UIView animateWithDuration:0.5 animations:^{
        [btn setTitleColor:self.themecolor forState:UIControlStateNormal];
    }];
}
-(NSInteger)SelectedBtn{
    return self.SelectedBtnCount;
}

-(UIImageView *)imageLine{
    if (_imageLine == nil) {
        _imageLine = [[UIImageView alloc] init];
    }
    return _imageLine;
}

@end
