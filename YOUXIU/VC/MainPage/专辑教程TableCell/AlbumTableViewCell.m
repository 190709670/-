//
//  AlbumTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "AlbumTableViewCell.h"
#import "ScoreView.h"
#import "NetWorkingRequest.h"
@interface AlbumTableViewCell()
@property (nonatomic, retain) UIImageView *authorHeadImageView;
@property (nonatomic, retain) UILabel *AlbumLabel; //
@property (nonatomic, retain) UILabel *AlbumNameLabel;
@property (nonatomic, retain) UILabel *marketPricelabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) UIButton *JoinBtn;
@property (nonatomic, retain) ScoreView *hardLevelView;
@property (nonatomic, retain) ScoreView *RecommendView;
@property (nonatomic, retain) NSDictionary *infoDic;
@end
@implementation AlbumTableViewCell

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
        self.authorHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                                 Macro_AutoWidth_7p(10),
                                                                                 Macro_AutoWidth_7p(105),
                                                                                 Macro_AutoWidth_7p(105))];
        self.authorHeadImageView.layer.cornerRadius = 5;
        self.authorHeadImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.authorHeadImageView];
        
        self.AlbumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.authorHeadImageView.frame) + Macro_AutoWidth_7p(5),
                                                                    CGRectGetMinY(self.authorHeadImageView.frame),
                                                                    KWidth - CGRectGetMaxX(self.authorHeadImageView.frame),
                                                                    Macro_AutoWidth_7p(20))];
        [self.AlbumLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:self.AlbumLabel];
        
        self.AlbumNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.AlbumLabel.frame),
                                                                        CGRectGetMaxY(self.AlbumLabel.frame) + Macro_AutoWidth_7p(5),
                                                                        KWidth - CGRectGetMaxX(self.authorHeadImageView.frame) - Macro_AutoWidth_7p(10),
                                                                        Macro_AutoWidth_7p(35))];
        [self.AlbumNameLabel setFont:[UIFont systemFontOfSize:14]];
        self.AlbumNameLabel.numberOfLines = 2;
        [self.contentView addSubview:self.AlbumNameLabel];
        
        self.hardLevelView = [[ScoreView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.AlbumLabel.frame),
                                                                         CGRectGetMaxY(self.AlbumNameLabel.frame) + Macro_AutoWidth_7p(5),
                                                                         Macro_AutoWidth_7p(130),
                                                                         Macro_AutoWidth_7p(20))];
        self.RecommendView = [[ScoreView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hardLevelView.frame) + Macro_AutoWidth_7p(10),
                                                                         CGRectGetMaxY(self.AlbumNameLabel.frame) + Macro_AutoWidth_7p(5),
                                                                         Macro_AutoWidth_7p(130),
                                                                         Macro_AutoWidth_7p(20))];
        [self.contentView addSubview:self.hardLevelView];
        [self.contentView addSubview:self.RecommendView];
        
        self.marketPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.authorHeadImageView.frame) + Macro_AutoWidth_7p(10),
                                                                          CGRectGetMaxY(self.hardLevelView.frame),
                                                                          Macro_AutoWidth_7p(80),
                                                                          Macro_AutoWidth_7p(20))];
        [self.marketPricelabel setFont:self.AlbumNameLabel.font];
        [self.marketPricelabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.marketPricelabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.marketPricelabel.frame) + Macro_AutoWidth_7p(10),
                                                                    CGRectGetMaxY(self.hardLevelView.frame),
                                                                    Macro_AutoWidth_7p(80),
                                                                    Macro_AutoWidth_7p(20))];
        [self.priceLabel setFont:self.AlbumNameLabel.font];
        [self.priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentView addSubview:self.priceLabel];
        
        self.JoinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.JoinBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(110),
                                          CGRectGetMinY(self.priceLabel.frame),
                                          Macro_AutoWidth_7p(100),
                                          Macro_AutoWidth_7p(25))];
        [self.JoinBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.JoinBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:ThemeRedColor];
        self.JoinBtn.layer.cornerRadius = self.JoinBtn.frame.size.height/2.0;
        [self.JoinBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.JoinBtn addTarget:self action:@selector(JoinBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.JoinBtn];
    }
    return self;
}
-(void)setAlbumInfoWithData:(id)AlbumInfo{
    NSDictionary *dic = AlbumInfo;
    self.infoDic = AlbumInfo;
    [self.authorHeadImageView setImageWithURL:[NSURL URLWithString:dic[@"cover"]]];
    BOOL orderHas = [[dic valueForKey:@"orderHas"] boolValue];
    BOOL cartHas = [[dic valueForKey:@"cartHas"] boolValue];

    [self.AlbumLabel setText:dic[@"name"]];
    [self.AlbumNameLabel setText:dic[@"content"]];
    [self.hardLevelView setScroreWithTitle:@"难度:" Scroe:[dic[@"difficult"] integerValue] ];
    [self.RecommendView setScroreWithTitle:@"推荐度:" Scroe:[dic[@"referral"] integerValue]];
    CGFloat marketPrice = [dic[@"marketprice"] floatValue];
    CGFloat price = [dic[@"price"] floatValue];
    
    NSMutableAttributedString *marketPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价:%0.1f",marketPrice]];
    [marketPriceString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, marketPriceString.length)];
    [marketPriceString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, marketPriceString.length)];
    
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"优惠价:%0.1f",price]];
    [priceString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, 3)];
    [priceString addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(3, priceString.length - 3)];
    
    [self.marketPricelabel setAttributedText:marketPriceString];
    [self.priceLabel setAttributedText:priceString];
    
    if (orderHas) {
        [self.JoinBtn setTitle:@"已购买" forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:[UIColor grayColor]];
        [self.JoinBtn setEnabled:NO];
    }else if (cartHas) {
        [self.JoinBtn setTitle:@"已加入购物车" forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:[UIColor grayColor]];
        [self.JoinBtn setEnabled:NO];
    }else{
        [self.JoinBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:ThemeRedColor];
        [self.JoinBtn setEnabled:YES];
    }
    
}
-(void)setAlbumAddCartStatus:(NSInteger)status{
    if (status == 0) {//已购买
        [self.JoinBtn setTitle:@"已购买" forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:[UIColor grayColor]];
        [self.JoinBtn setEnabled:NO];
    }else if (status == 1) { //已加入购物车
        [self.JoinBtn setTitle:@"已加入购物车" forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:[UIColor grayColor]];
        [self.JoinBtn setEnabled:NO];
    }else{
        [self.JoinBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.JoinBtn setBackgroundColor:ThemeRedColor];
        [self.JoinBtn setEnabled:YES];
    }
}
+(NSInteger)CellHeight{
    return Macro_AutoWidth_7p(125);
}
-(void)JoinBtnClick:(id)sender{
    NSString *account = [BaseMethod getUserAccount];
    NSString *goodsId = self.infoDic[@"id"];
    [BaseMethod showLoading:self.superview];
    [[NetWorkingRequest share_MainViewRequest] SendCartDoAddAccount:account GoodsID:goodsId Type:1 Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.superview];
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.superview];
        if(info.success){
            [self setAlbumAddCartStatus:1];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.superview];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.superview];
    }];
}


@end
