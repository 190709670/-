//
//  ScoreView.m
//  YOUXIU
//
//  Created by lihui on 2018/5/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "ScoreView.h"
#import "CustomFitContentLabel.h"
@implementation ScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CustomFitContentLabel *titleLabel = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(40), Macro_AutoWidth_7p(15))];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [titleLabel setTextColor:[UIColor grayColor]];
        titleLabel.tag = 100;
        [self addSubview:titleLabel];
        NSInteger spacewidth = Macro_AutoWidth_7p(2),imagewidth = Macro_AutoWidth_7p(15);
        
        for (NSInteger i =0; i< 5; i++) {
            UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + spacewidth*(i+1) + imagewidth*i,
                                                                              0,
                                                                              imagewidth,
                                                                              imagewidth)];
            [icon setImage:[UIImage imageNamed:@"course_nodisplay"]];
            icon.tag = i+10;
            [self addSubview:icon];
        }
    }
    return self;
}
-(void)setScroreWithTitle:(NSString *)Title Scroe:(NSInteger)Score{
    CustomFitContentLabel *titleLabel = [self viewWithTag:100];
    [titleLabel setText:Title];
    [titleLabel fitcontentWithWidth];
    NSInteger spacewidth = Macro_AutoWidth_7p(2),imagewidth = Macro_AutoWidth_7p(15);
    for(NSInteger i = 0; i < 5 ; i++){
        UIImageView *icon = [self viewWithTag:i+10];
        [icon setFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + spacewidth*(i+1) + imagewidth*i,
                                 0,
                                 imagewidth,
                                 imagewidth)];
        if (i <= Score - 1) {
            [icon setImage:[UIImage imageNamed:@"course_display"]];
        }else{
             [icon setImage:[UIImage imageNamed:@"course_nodisplay"]];
        }
    }
}
@end
