//
//  CustonBtnTitleView.m
//  YOUXIU
//
//  Created by lihui on 2018/5/25.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "CustonBtnTitleView.h"
@interface CustonBtnTitleView()<UIScrollViewDelegate>
@property (nonatomic, retain) NSArray *titleInfoArray;
@property (nonatomic, retain) UIScrollView *backScrollView;
@property (nonatomic, assign) BOOL isScrollView;
@property (nonatomic, retain) UIImageView *imageLine;
@property (nonatomic, assign) BOOL ImageLineTop;
@end
@implementation CustonBtnTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                             0,
                                                                             frame.size.width - Macro_AutoWidth_7p(20),
                                                                             frame.size.height)];
        self.backScrollView.delegate = self;
        self.backScrollView.scrollEnabled = YES;
        [self.backScrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.backScrollView];
    }
    return self;
}
-(void)setImagePostionTop:(BOOL)top{
    self.ImageLineTop = top;
}

-(void)setWithTitleArray:(NSArray *)titleArray{
    NSArray *subviews = [self.backScrollView subviews];
    for (UIView *view in subviews) {
        if(![view isKindOfClass:[UIImageView class]]){
            [view removeFromSuperview];
        }
    }
    
    self.titleInfoArray = titleArray;
    CGFloat titleWidth = Macro_AutoWidth_7p(70);
    NSInteger count = titleArray.count;
    self.backScrollView.contentSize = CGSizeMake(titleWidth * count, self.frame.size.height);
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(titleWidth*i + Macro_AutoWidth_7p(5),
                                 0,
                                 titleWidth,
                                 self.frame.size.height)];
        [btn setTitle:[titleArray[i] valueForKey:@"name"] forState:UIControlStateNormal];
        if (i == 0) {
              [btn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        }
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.backScrollView addSubview:btn];
        btn.tag = i+10;
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)BtnClick:(id)sender{
    if ([self.delegate respondsToSelector:@selector(CustonBtnTitleView_BtnClick:titleview:)]) {
        UIButton *btn = (UIButton *)sender;
        CGRect visibleRect = CGRectMake(btn.center.x - self.backScrollView.center.x + 10,
                                         0,
                                         Macro_ScreenWidth,
                                         self.backScrollView.frame.size.height);
        [self.backScrollView scrollRectToVisible:visibleRect animated:YES];
        [self.delegate CustonBtnTitleView_BtnClick:self.titleInfoArray[btn.tag - 10] titleview:self];
        for (UIButton *thisview in self.backScrollView.subviews) {
            if ([thisview isKindOfClass:[UIButton class]]) {
                [thisview setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            }
        }
        [btn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    }
}
-(void)SelectBtnPosition:(NSInteger)Position{
    UIButton *btn =  [self.backScrollView viewWithTag:Position + 10];
    [self BtnClick:btn];
}

-(void)leftBtnClick:(id)sender{
    if (self.isScrollView) {
        return;
    }
    CGFloat titleWidth = self.backScrollView.frame.size.width;
    if (self.backScrollView.contentOffset.x + 1>= self.backScrollView.frame.size.width) {
       // NSLog(@"显示btn位置：%f",(self.backScrollView.contentOffset.x/titleWidth)- 1);
        CGFloat position = (self.backScrollView.contentOffset.x/titleWidth) - 1;
        [self ShowBtnPositon:ceil(position)];
        [self.backScrollView scrollRectToVisible:CGRectMake(self.backScrollView.contentOffset.x - titleWidth, 0, titleWidth, self.frame.size.height) animated:YES];
    }else{
        [BaseMethod showToast:@"没有更多" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
    }
}
-(void)rightBtnClick:(id)sender{
    if (self.isScrollView) {
        return;
    }
    CGFloat titleWidth = self.backScrollView.frame.size.width;
    NSInteger count = self.titleInfoArray.count;
    if (self.backScrollView.contentOffset.x < titleWidth*(count - 1)) {
        CGFloat position = (self.backScrollView.contentOffset.x/titleWidth) + 1;
        [self ShowBtnPositon:ceil(position)];
        [self.backScrollView scrollRectToVisible:CGRectMake(self.backScrollView.contentOffset.x + titleWidth, 0, titleWidth, self.frame.size.height) animated:YES];

    }else{
        [BaseMethod showToast:@"没有更多" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
    }
}

-(void)ShowBtnPositon:(NSInteger)position{
    if ([self.delegate respondsToSelector:@selector(ShowBtnInfo:)]) {
        [self.delegate ShowBtnInfo:self.titleInfoArray[position]];
    }
}
@end
