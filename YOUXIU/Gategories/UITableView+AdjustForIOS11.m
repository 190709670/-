//
//  UITableView+AdjustForIOS11.m
//  QiXiuApp
//
//  Created by lihui on 2017/10/9.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "UITableView+AdjustForIOS11.h"
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
@implementation UITableView (AdjustForIOS11)
-(instancetype)initWithFrame:(CGRect)frame{
    if (@available(iOS 11.0, *)) {
        [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    } 
   return  [super initWithFrame:frame];
}
@end
