//
//  CustomSelectedCellTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//
#import "CustomSelectedCellTableViewCell.h"
#import "CustomBtnAddObject.h"

@interface CustomSelectedCellTableViewCell()
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;
@property (nonatomic, retain) CustomBtnAddObject *selectBtn;
@property (nonatomic, retain) UILabel *recommendLabel;
@end

@implementation CustomSelectedCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(15), Macro_AutoWidth_7p(30), Macro_AutoWidth_7p(30))];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + Macro_AutoWidth_7p(10),
                                                                    CGRectGetMinY(self.icon.frame),
                                                                    Macro_AutoWidth_7p(100),
                                                                    Macro_AutoWidth_7p(20))];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.recommendLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) ,
                                                                        CGRectGetMinY(self.titleLabel.frame)+ Macro_AutoWidth_7p(2),
                                                                        Macro_AutoWidth_7p(30),
                                                                        Macro_AutoWidth_7p(15))];
        self.recommendLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        self.recommendLabel.layer.borderWidth = 1;
        self.recommendLabel.layer.cornerRadius = 2;
        [self.recommendLabel setTextColor:[UIColor orangeColor]];
        [self.recommendLabel setFont:[UIFont systemFontOfSize:10]];
        [self.recommendLabel setTextAlignment:NSTextAlignmentCenter];
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame),
                                                                       CGRectGetMaxY(self.titleLabel.frame),
                                                                       Macro_AutoWidth_7p(300),
                                                                       Macro_AutoWidth_7p(15))];
        [self.subtitleLabel setFont:[UIFont systemFontOfSize:13]];
        [self.subtitleLabel setTextColor:[UIColor grayColor]];
        
        self.selectBtn = [CustomBtnAddObject buttonWithType:UIButtonTypeCustom];
        self.selectBtn.object =[NSNumber numberWithBool:NO];
        [self.selectBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(30),
                                            Macro_AutoWidth_7p(15),
                                            Macro_AutoWidth_7p(20),
                                            Macro_AutoWidth_7p(20))];
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"shopping_unselected"] forState:UIControlStateNormal];
      //  [self.selectBtn setEnabled:NO];
        [self.selectBtn setUserInteractionEnabled:NO];
      //  [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //shopping_choise
        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.recommendLabel];
    }
    return self;
}
-(void)setCellInfoWithDic:(NSDictionary *)InfoDic Recomment:(NSString *)Recomment{
    NSString *imagename = InfoDic[@"imagename"];
    NSString *titlestring = InfoDic[@"title"];
    NSString *subtitlestring = InfoDic[@"subtitle"];
    if (Recomment.length > 0) {
        [self.recommendLabel setText:Recomment];
        [self.recommendLabel setHidden:NO];
    }else{
        [self.recommendLabel setHidden:YES];
    }
    [self.icon setImage:[UIImage imageNamed:imagename]];
    [self.titleLabel setText:titlestring];
    [self.subtitleLabel setText:subtitlestring];
}
-(void)selectBtnClick:(id)sender{
    self.selectBtn.object =[NSNumber numberWithBool:![self.selectBtn.object boolValue]];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed: [self.selectBtn.object boolValue] ?@"shopping_choise": @"shopping_unselected"] forState:UIControlStateNormal];
}
-(void)setSelectBtnSelected:(BOOL)Selected{
    self.selectBtn.object = [NSNumber numberWithBool:Selected];
    [self.selectBtn setBackgroundImage:[UIImage imageNamed: [self.selectBtn.object boolValue] ?@"shopping_choise": @"shopping_unselected"] forState:UIControlStateNormal];
}
-(BOOL)CellSelectedStatus{
    return [self.selectBtn.object boolValue];
}

+(NSInteger)CellHeight{
    return Macro_AutoWidth_7p(60);
}
@end
