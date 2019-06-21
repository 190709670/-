//
//  DownLoadedTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/7/18.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownLoadedTableViewCell.h"
@interface DownLoadedTableViewCell()
@property (nonatomic, retain) UILabel *MusicNameLabel;
@property (nonatomic, retain) UILabel *authorLabel;
@property (nonatomic, retain) UILabel *MusicSizeLabel;
@end
@implementation DownLoadedTableViewCell

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
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.MusicNameLabel.frame),
                                                                     CGRectGetMaxY(self.MusicNameLabel.frame),
                                                                     Macro_AutoWidth_7p(250),
                                                                     Macro_AutoWidth_7p(20))];
        [self.authorLabel setFont:[UIFont systemFontOfSize:12]];
        [self.authorLabel setTextColor:[UIColor grayColor]];
        
        self.MusicSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_ScreenWidth - Macro_AutoWidth_7p(100),
                                                                   CGRectGetMinY(self.authorLabel.frame),
                                                                   Macro_AutoWidth_7p(100),
                                                                   Macro_AutoWidth_7p(20))];
        [self.MusicSizeLabel setFont:[UIFont systemFontOfSize:12]];
        [self.MusicSizeLabel setTextColor:[UIColor grayColor]];
        
        [self.contentView addSubview:self.MusicNameLabel];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.MusicSizeLabel];
    }
    return self;
}

-(void)setCellInfoWithFileInfo:(NSDictionary *)dic{
    NSString *musicname = dic[@"fileName"];
    NSInteger buyDateInt = [dic[@"buyDate"] integerValue];
    CGFloat musicSize = [dic[@"DownLoad_FileSize"] floatValue];
    
   NSTimeInterval timeinter = buyDateInt/1000;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinter];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:date];
    
    [self.MusicNameLabel setText:musicname];
    [self.authorLabel setText:[NSString stringWithFormat:@"购买时间:%@",time]];
    [self.MusicSizeLabel setText:[NSString stringWithFormat:@"%0.3fM",musicSize]];
}
+(NSInteger)CellHeight{
    return Macro_AutoWidth_7p(50);
}

@end
