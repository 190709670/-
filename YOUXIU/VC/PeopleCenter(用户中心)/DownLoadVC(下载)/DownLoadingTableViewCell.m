//
//  DownLoadingTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/7/18.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownLoadingTableViewCell.h"
@interface DownLoadingTableViewCell()
@property (nonatomic, retain) UILabel *MusicNameLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *MusicSizeLabel;
@property (nonatomic, retain) UIProgressView *progressview;
@end
@implementation DownLoadingTableViewCell

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
        self.MusicNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                        Macro_AutoWidth_7p(5),
                                                                        Macro_AutoWidth_7p(320),
                                                                        Macro_AutoWidth_7p(20))];
        [self.MusicNameLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.progressview = [[UIProgressView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                             CGRectGetMaxY(self.MusicNameLabel.frame) + Macro_AutoWidth_7p(10),
                                                                            Macro_AutoWidth_7p(300),
                                                                             Macro_AutoWidth_7p(20))];
        [self.progressview setTrackTintColor:[UIColor grayColor]];
        [self.progressview setTintColor:[UIColor greenColor]];
        
        self.Btn = [CustomBtnAddObject buttonWithType:UIButtonTypeCustom];
        [self.Btn setFrame:CGRectMake(Macro_ScreenWidth - Macro_AutoWidth_7p(80),
                                      Macro_AutoWidth_7p(5),
                                      Macro_AutoWidth_7p(40),
                                      Macro_AutoWidth_7p(40))];
        [self.Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.MusicNameLabel.frame),
                                                                     CGRectGetMaxY(self.progressview.frame) + Macro_AutoWidth_7p(5),
                                                                     Macro_AutoWidth_7p(250),
                                                                     Macro_AutoWidth_7p(20))];
        [self.timeLabel setFont:[UIFont systemFontOfSize:12]];
        [self.timeLabel setTextColor:[UIColor grayColor]];
        
        self.MusicSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_ScreenWidth - Macro_AutoWidth_7p(120),
                                                                        CGRectGetMinY(self.timeLabel.frame),
                                                                        Macro_AutoWidth_7p(120),
                                                                        Macro_AutoWidth_7p(20))];
        [self.MusicSizeLabel setFont:[UIFont systemFontOfSize:12]];
        [self.MusicSizeLabel setTextColor:[UIColor grayColor]];
        [self.MusicSizeLabel setTextAlignment:NSTextAlignmentLeft];
        
        [self.contentView addSubview:self.MusicNameLabel];
        [self.contentView addSubview:self.Btn];
        [self.contentView addSubview:self.progressview];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.MusicSizeLabel];
    }
    return self;
}

-(void)setCellInfoWithFileInfo:(NSDictionary *)dic{
    NSString *musicname = dic[@"fileName"];
    //musicname = [musicname stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSInteger buyDateInt = [dic[@"buyDate"] integerValue];
    CGFloat musicSize = [dic[@"DownLoad_FileSize"] floatValue];
    CGFloat rate = [dic[@"DownLoad_Rate"] floatValue];
    NSInteger isLoad = [dic[@"DownLoad_isLoad"] integerValue];
    NSTimeInterval timeinter = buyDateInt/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinter];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:date];
    
    switch (isLoad) {
        case 0:
            {
                self.Btn.object = [NSNumber numberWithBool:YES]; //下载中
                [self.Btn setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
            }
            break;
        case 1:
        {
            self.Btn.object = [NSNumber numberWithBool:NO]; //暂停
            [self.Btn setImage:[UIImage imageNamed:@"suspend"] forState:UIControlStateNormal];

        }
            break;
        case 2:
        {
            self.Btn.object = [NSNumber numberWithBool:NO]; //下载完成
            [self.Btn setImage:[UIImage imageNamed:@"suspend"] forState:UIControlStateNormal];

        }
            break;
        default:
            break;
    }
    [self.MusicNameLabel setText:musicname];
    [self.progressview setProgress:rate];
    [self.timeLabel setText:[NSString stringWithFormat:@"购买时间:%@",time]];
    [self.MusicSizeLabel setText:[NSString stringWithFormat:@"%0.2fM / %0.2fM",musicSize*rate,musicSize]];
}
-(void)BtnClick:(id)sender{
    CustomBtnAddObject *btn = (CustomBtnAddObject *)sender;
    btn.object = [NSNumber numberWithBool:![btn.object boolValue] ];
    if ([btn.object boolValue]) {
        [btn setImage:[UIImage imageNamed:@"DownLoad"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"suspend"] forState:UIControlStateNormal];
    }
    self.DownLoadingTableViewCellBlock(btn);
}
+(NSInteger)CellHeight{
    return Macro_AutoWidth_7p(70);
}
@end
