//
//  CartTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "CartTableViewCell.h"
#import "CustomFitContentLabel.h"
@interface CartTableViewCell()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) CustomFitContentLabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *musicLevelLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation CartTableViewCell

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
        self.icon = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(5), Macro_AutoWidth_7p(60), Macro_AutoWidth_7p(60))];
        self.icon.layer.cornerRadius = 5;
        self.icon.layer.masksToBounds = YES;
        
        self.titleLabel = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.icon.frame) + Macro_AutoWidth_7p(10),
                                                                                  CGRectGetMinY(self.icon.frame),
                                                                                  Macro_AutoWidth_7p(100),
                                                                                  Macro_AutoWidth_7p(20))];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame) ,
                                                                       CGRectGetMaxY(self.titleLabel.frame) + Macro_AutoWidth_7p(5),
                                                                       Macro_AutoWidth_7p(200),
                                                                       Macro_AutoWidth_7p(20))];
        [self.subtitleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.subtitleLabel setTextColor:[UIColor grayColor]];
        
        self.musicLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(60),
                                                                         CGRectGetMinY(self.icon.frame) + Macro_AutoWidth_7p(5),
                                                                         Macro_AutoWidth_7p(40),
                                                                         Macro_AutoWidth_7p(20))];
        [self.musicLevelLabel setFont:[UIFont systemFontOfSize:12]];
        self.musicLevelLabel.layer.cornerRadius = CGRectGetHeight(self.musicLevelLabel.frame)/2.0;
        [self.musicLevelLabel setTextColor:[UIColor blueColor]];
        self.musicLevelLabel.layer.borderColor = [UIColor blueColor].CGColor;
        self.musicLevelLabel.layer.borderWidth = 1;
        [self.musicLevelLabel setTextAlignment:NSTextAlignmentCenter];
      //  [self.musicLevelLabel setCenter:CGPointMake(0, self.titleLabel.center.y)];
        
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(80),
                                                                    Macro_AutoWidth_7p(40),
                                                                    Macro_AutoWidth_7p(80),
                                                                    Macro_AutoWidth_7p(20))];
        [self.priceLabel setFont:[UIFont systemFontOfSize:14]];
        [self.priceLabel setTextColor:ThemeRedColor];
        
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.subtitleLabel];
        [self.contentView addSubview:self.musicLevelLabel];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}
-(void)setCartInfoWithMusicInfo:(id)MusicInfo{
    NSString *author = [MusicInfo valueForKey:@"author"]?[MusicInfo valueForKey:@"author"]:@"未获取";
    NSInteger difficult = [[MusicInfo valueForKey:@"difficult"] integerValue];
    
    [self.icon setImageWithURL:[NSURL URLWithString:MusicInfo[@"songCover"]]];
    [self.titleLabel setText:MusicInfo[@"songName"]];
    [self.titleLabel fitcontentWithWidth];
//    [self.musicLevelLabel setFrame:CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + Macro_AutoWidth_7p(5), self.musicLevelLabel.frame.origin.y, self.musicLevelLabel.frame.size.width, self.musicLevelLabel.frame.size.height)];
    [self.subtitleLabel setText:author];
    [self.musicLevelLabel setText:[NSString stringWithFormat:@"%ld级",(long)difficult]];
    [self.priceLabel setText:[NSString stringWithFormat:@"¥%@",MusicInfo[@"price"]]];
}
+ (CGFloat)cellHeight{
    return Macro_AutoWidth_7p(70);
}
@end
