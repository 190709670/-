//
//  AlreadyPayTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/23.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "AlreadyPayTableViewCell.h"
@interface AlreadyPayTableViewCell()
@property (nonatomic, retain) CustomFitContentLabel *musicName;
@property (nonatomic, retain) UILabel *musicLevel;
@property (nonatomic, retain) UILabel *PayTime;
@property (nonatomic, retain) CustomFitContentLabel *type1;
@property (nonatomic, retain) UIButton *WXPPayBtn;
@property (nonatomic, retain) UIButton *JPPayBtn;
@property (nonatomic, retain) UILabel *statusLabel;
@end
@implementation AlreadyPayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(!self.editing)
        return;
    if (self.editing && self.isSelected) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self.musicName setBackgroundColor:[UIColor clearColor]];
        [self.PayTime setBackgroundColor:[UIColor clearColor]];
        [self.musicLevel setBackgroundColor:[UIColor clearColor]];
        [self.type1 setBackgroundColor:[UIColor clearColor]];


        UIControl *control = [self.subviews lastObject];
        UIImageView *imageview = [[control subviews] objectAtIndex:0];
        imageview.image = [UIImage imageNamed:@"shopping_choise"];
    }
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    if (self.editing && !self.isSelected) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        UIControl *control = [self.subviews lastObject];
        UIImageView *imageview = [[control subviews] objectAtIndex:0];
        imageview.image = [UIImage imageNamed:@"shopping_unselected"];
    }
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
-(void)createUI{
    self.musicName = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                             Macro_AutoWidth_7p(5),
                                                                             KWidth,
                                                                             Macro_AutoWidth_7p(30))];
    
    self.WXPPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.WXPPayBtn setFrame:CGRectMake(Macro_AutoWidth_7p(200),
                                          CGRectGetMinY(self.musicName.frame),
                                          Macro_AutoWidth_7p(90),
                                          Macro_AutoWidth_7p(20))];
    [self.WXPPayBtn setTitle:@"五线谱视频" forState:UIControlStateNormal];
    [self.WXPPayBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.WXPPayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.WXPPayBtn setImage:[UIImage imageNamed:@"home_video"] forState:UIControlStateNormal];
    [self.WXPPayBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, -10, -5, 0)];
    [self.WXPPayBtn addTarget:self action:@selector(wxpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.JPPayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.JPPayBtn setFrame:CGRectMake(Macro_AutoWidth_7p(300),
                                       CGRectGetMinY(self.musicName.frame),
                                       CGRectGetWidth(self.WXPPayBtn.frame),
                                       CGRectGetHeight(self.WXPPayBtn.frame))];
    [self.JPPayBtn setTitle:@"简谱视频" forState:UIControlStateNormal];
    [self.JPPayBtn.titleLabel setFont:self.WXPPayBtn.titleLabel.font];
    [self.JPPayBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.JPPayBtn setImage:[UIImage imageNamed:@"home_video"] forState:UIControlStateNormal];
    [self.JPPayBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, -10, -5, 0)];
    [self.JPPayBtn addTarget:self action:@selector(JPBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.type1 = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.musicName.frame),
                                                                         CGRectGetMaxY(self.musicName.frame),
                                                                         KWidth, Macro_AutoWidth_7p(20))];
    [self.type1 setFont:[UIFont systemFontOfSize:12]];
    [self.type1 setTextColor:[UIColor grayColor]];
    self.type1.textAlignment = NSTextAlignmentCenter;
    
    self.musicLevel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(210),
                                                                CGRectGetMaxY(self.musicName.frame),
                                                                Macro_AutoWidth_7p(40),
                                                                Macro_AutoWidth_7p(20))];
    self.musicLevel.layer.cornerRadius = CGRectGetHeight(self.musicLevel.frame)/2.0;
    [self.musicLevel setTextColor:[UIColor blueColor]];
    self.musicLevel.layer.borderColor = [UIColor blueColor].CGColor;
    self.musicLevel.layer.borderWidth = 1;
    [self.musicLevel setTextAlignment:NSTextAlignmentCenter];
    [self.musicLevel setFont:[UIFont systemFontOfSize:12]];
    
    self.PayTime = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(160),
                                                             CGRectGetMinY(self.musicLevel.frame),
                                                             Macro_AutoFont_7p(160),
                                                             Macro_AutoFont_7p(20))];
    [self.PayTime setTextColor:[UIColor grayColor]];
    [self.PayTime setFont:[UIFont systemFontOfSize:12]];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Macro_ScreenWidth, [AlreadyPayTableViewCell cellHeight])];
    [self.statusLabel setTextColor:[UIColor colorWithRed:240/255.0 green:66/255.0 blue:66/255.0 alpha:0.2]];
    [self.statusLabel setBackgroundColor:[UIColor colorWithWhite:0.6 alpha:0.1]];
    [self.statusLabel setFont:[UIFont systemFontOfSize:28]];
    [self.statusLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.musicName];
    [self.contentView addSubview:self.WXPPayBtn];
    [self.contentView addSubview:self.JPPayBtn];
    [self.contentView addSubview:self.musicLevel];
    [self.contentView addSubview:self.type1];
    [self.contentView addSubview:self.PayTime];
}

-(void)setPayRecodInfoWithSingleInfo:(id)SingleInfo{
    NSString *songName = [SingleInfo valueForKey:@"songName"];
    NSString *rank = [SingleInfo valueForKey:@"rank"];
    NSString *downloadTime = [SingleInfo valueForKey:@"downloadTime"];
    NSString *author = [SingleInfo valueForKey:@"author"];
    NSInteger time = [[SingleInfo valueForKey:@"buyTime"] integerValue];
    NSString *timeStirng = [BaseMethod getDateStringWithTimestamp:time];

    BOOL isSingle = [SingleInfo[@"type"] boolValue];

    if (!isSingle) {//单曲
        [self.WXPPayBtn setHidden:NO];
        [self.JPPayBtn setHidden:NO];
        [self.musicLevel setHidden:NO];
    }else{
        [self.WXPPayBtn setHidden:YES];
        [self.JPPayBtn setHidden:YES];
        [self.musicLevel setHidden:YES];
    }
    
    [self.musicName setText:songName?songName:@"为获取到歌曲名"];
    [self.musicName fitcontentWithWidth];
    
    [self.PayTime setText:downloadTime?downloadTime:@"未获取到时间"];
    NSMutableAttributedString *paytime = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@购买",timeStirng]];
    [paytime addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, timeStirng.length - 2)];
    [paytime addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(timeStirng.length - 2, 2)];
    [self.PayTime setAttributedText:paytime];
    
    [self.type1 setText:author];
    [self.type1 fitcontentWithWidthWithSpce:Macro_AutoWidth_7p(15)];
    [self.musicLevel setText:[NSString stringWithFormat:@"%@级",rank]];
}
-(void)JPBtnClick:(id)sender{
    if (self.jpBtnClickBlock) {
        self.jpBtnClickBlock(self);
    }
}
-(void)wxpBtnClick:(id)sender{
    if (self.wxpBtnClickBlock) {
        self.wxpBtnClickBlock(self);
    }
}
-(void)setCellStatus:(BOOL)isDowned info:(NSString *)info{
    [self.statusLabel setHidden:isDowned];
    [self.statusLabel setText:info];
}

+ (CGFloat)cellHeight{
    return Macro_AutoWidth_7p(60);
}
@end
