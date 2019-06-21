//
//  PayRecodTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/22.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "PayRecodTableViewCell.h"
@interface PayRecodTableViewCell()
@property (nonatomic, retain) CustomFitContentLabel *musicName;
@property (nonatomic, retain) UILabel *musicAuthor;
@property (nonatomic, retain) UILabel *musicLevel;
@property (nonatomic, retain) UILabel *payProgress;
@end
@implementation PayRecodTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    if(!self.editing)
//        return;
//    if (self.editing && self.isSelected) {
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.textLabel.backgroundColor = [UIColor clearColor];
//        [self.musicName setBackgroundColor:[UIColor clearColor]];
//        [self.musicAuthor setBackgroundColor:[UIColor clearColor]];
//        [self.musicLevel setBackgroundColor:[UIColor clearColor]];
//        [self.payProgress setBackgroundColor:[UIColor clearColor]];
//
//        UIControl *control = [self.subviews lastObject];
//        UIImageView *imageview = [[control subviews] objectAtIndex:0];
//        imageview.image = [UIImage imageNamed:@"shopping_choise"];
//    }
    // Configure the view for the selected state
}
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;//防止狂点闪现系统图片
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        UIView *backGroundView = [[UIView alloc] init];
        backGroundView.backgroundColor = [UIColor clearColor];
        self.selectedBackgroundView = backGroundView;
        [self createUI];
    }
    return self;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
//    if (self.editing && !self.isSelected) {
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.textLabel.backgroundColor = [UIColor clearColor];
//        UIControl *control = [self.subviews lastObject];
//        UIImageView *imageview = [[control subviews] objectAtIndex:0];
//        imageview.image = [UIImage imageNamed:@"shopping_unselected"];
//    }
}
-(void)createUI{
    self.musicName = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                             Macro_AutoWidth_7p(5),
                                                                             KWidth,
                                                                             Macro_AutoWidth_7p(30))];
    
    self.musicAuthor = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.musicName.frame), CGRectGetMaxY(self.musicName.frame), Macro_AutoWidth_7p(300), Macro_AutoWidth_7p(20))];
    [self.musicAuthor setFont:[UIFont systemFontOfSize:12]];
    [self.musicAuthor setTextColor:[UIColor grayColor]];
    
    self.musicLevel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                CGRectGetMinY(self.musicName.frame),
                                                                Macro_AutoWidth_7p(40),
                                                                Macro_AutoWidth_7p(20))];
    self.musicLevel.layer.cornerRadius = CGRectGetHeight(self.musicLevel.frame)/2.0;
    [self.musicLevel setTextColor:[UIColor blueColor]];
    self.musicLevel.layer.borderColor = [UIColor blueColor].CGColor;
    self.musicLevel.layer.borderWidth = 1;
    [self.musicLevel setTextAlignment:NSTextAlignmentCenter];
    [self.musicLevel setCenter:CGPointMake(0, self.musicName.center.y)];
    [self.musicLevel setFont:[UIFont systemFontOfSize:12]];
    
    self.payProgress = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(80), CGRectGetMinX(self.musicAuthor.frame), Macro_AutoWidth_7p(80), CGRectGetHeight(self.musicAuthor.frame))];
    [self.payProgress setTextColor:[UIColor grayColor]];
    [self.payProgress setFont:[UIFont systemFontOfSize:12]];
    
    [self.contentView addSubview:self.musicName];
    [self.contentView addSubview:self.musicAuthor];
    [self.contentView addSubview:self.payProgress];
    [self.contentView addSubview:self.musicLevel];
}
-(void)setPayRecodInfoWithMusicInfo:(id)MusicInfo{
    [self.musicName setText:@"雨的印记 Kiss the Rain"];
    [self.musicName fitcontentWithWidth];
    [self.musicLevel setFrame:CGRectMake(CGRectGetMaxX(self.musicName.frame) + Macro_AutoWidth_7p(5), self.musicLevel.frame.origin.y, self.musicLevel.frame.size.width, self.musicLevel.frame.size.height)];
    [self.musicAuthor setText:@"YiruMa。 李闰珉"];
    [self.musicLevel setText:@"4级"];
    [self.payProgress setText:@"观看至10%"];
    [self.payProgress setHidden:YES];
}
+ (CGFloat)cellHeight{
    return Macro_AutoWidth_7p(60);
}
@end
