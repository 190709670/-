//
//  CustonSelectedImageTableViewCell.m
//  QiXiuApp
//
//  Created by lihui on 2017/7/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "CustonSelectedImageTableViewCell.h"

@implementation CustonSelectedImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        [img setTintColor:ThemeRedColor];
                    }else
                    {
                    }
                }
            }
        }
    }
}
@end
