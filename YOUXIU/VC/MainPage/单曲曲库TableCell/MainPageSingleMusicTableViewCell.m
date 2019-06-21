//
//  MainPageSingleMusicTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/27.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "MainPageSingleMusicTableViewCell.h"
#import "CustomFitContentLabel.h"
@interface MainPageSingleMusicTableViewCell()
@property (nonatomic, retain) CustomFitContentLabel *musicName;
@property (nonatomic, retain) UIImageView *AuthorHeaderImage;
@property (nonatomic, retain) UILabel *musicAuthor;
@property (nonatomic, retain) UILabel *musicLevel;
@property (nonatomic, retain) UILabel *musicPriceLabe;
@property (nonatomic, retain) UILabel *marketPriceLabel;
@property (nonatomic, retain) UIButton *joinCarBtn;
@property (nonatomic, retain) UIButton *fiveLineBtn;    //五线谱按钮
@property (nonatomic, retain) UIButton *numberedMusicalNotationBtn;//简谱按钮
@property (nonatomic, retain) NSDictionary *dataDic;
@end
@implementation MainPageSingleMusicTableViewCell

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
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.AuthorHeaderImage = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(5),
                                                                           Macro_AutoWidth_7p(5),
                                                                           Macro_AutoWidth_7p(60),
                                                                           Macro_AutoWidth_7p(60))];
    self.AuthorHeaderImage.layer.cornerRadius = Macro_AutoWidth_7p(5);
    self.AuthorHeaderImage.layer.masksToBounds = YES;
    
    self.musicName = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10) + CGRectGetMaxX(self.AuthorHeaderImage.frame),
                                                                             Macro_AutoWidth_7p(5),
                                                                             KWidth,
                                                                             Macro_AutoWidth_7p(25))];
    
    self.musicAuthor = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.musicName.frame),
                                                                 CGRectGetMaxY(self.musicName.frame),
                                                                 Macro_AutoWidth_7p(300),
                                                                 Macro_AutoWidth_7p(20))];
    [self.musicAuthor setFont:[UIFont systemFontOfSize:12]];
    [self.musicAuthor setTextColor:[UIColor grayColor]];
    
    self.marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(190),
                                                                      CGRectGetMinY(self.musicName.frame),
                                                                      Macro_AutoWidth_7p(100),
                                                                      Macro_AutoWidth_7p(20))];
    [self.marketPriceLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.musicPriceLabe = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(190) - 12,
                                                                    CGRectGetMaxY(self.marketPriceLabel.frame),
                                                                    Macro_AutoWidth_7p(100),
                                                                    Macro_AutoWidth_7p(20))];
    [self.musicPriceLabe setFont:[UIFont systemFontOfSize:12]];
    [self.musicPriceLabe setTextColor:[UIColor redColor]];
    
    self.musicLevel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.musicName.frame),
                                                                CGRectGetMaxY(self.musicAuthor.frame),
                                                                Macro_AutoWidth_7p(40),
                                                                Macro_AutoWidth_7p(16))];
    self.musicLevel.layer.cornerRadius = CGRectGetHeight(self.musicLevel.frame)/2.0;
    [self.musicLevel setTextColor:[UIColor blueColor]];
    self.musicLevel.layer.borderColor = [UIColor blueColor].CGColor;
    self.musicLevel.layer.borderWidth = 1;
    [self.musicLevel setTextAlignment:NSTextAlignmentCenter];
    [self.musicLevel setFont:[UIFont systemFontOfSize:12]];
    
    self.joinCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.joinCarBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(100), Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(80), Macro_AutoWidth_7p(30))];
    [self.joinCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.joinCarBtn setBackgroundColor:ThemeRedColor];
    [self.joinCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.joinCarBtn.layer.cornerRadius = self.joinCarBtn.frame.size.height/2.0;
    [self.joinCarBtn .titleLabel setFont:[UIFont boldSystemFontOfSize:Macro_AutoFont_7p(12)]];
    [self.joinCarBtn addTarget:self action:@selector(joinCarBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.fiveLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.fiveLineBtn setFrame:CGRectMake(Macro_AutoWidth_7p(200),
                                          CGRectGetMaxY(self.musicAuthor.frame),
                                          Macro_AutoWidth_7p(90),
                                          Macro_AutoWidth_7p(20))];
    [self.fiveLineBtn setTitle:@"五线谱视频" forState:UIControlStateNormal];
    [self.fiveLineBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.fiveLineBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.fiveLineBtn setImage:[UIImage imageNamed:@"home_video"] forState:UIControlStateNormal];
    [self.fiveLineBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, -10, -5, 0)];
    [self.fiveLineBtn addTarget:self action:@selector(wxpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.numberedMusicalNotationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numberedMusicalNotationBtn setFrame:CGRectMake(Macro_AutoWidth_7p(300), CGRectGetMinY(self.fiveLineBtn.frame), CGRectGetWidth(self.fiveLineBtn.frame), CGRectGetHeight(self.fiveLineBtn.frame))];
    [self.numberedMusicalNotationBtn setTitle:@"简谱视频" forState:UIControlStateNormal];
    [self.numberedMusicalNotationBtn.titleLabel setFont:self.fiveLineBtn.titleLabel.font];
    [self.numberedMusicalNotationBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.numberedMusicalNotationBtn setImage:[UIImage imageNamed:@"home_video"] forState:UIControlStateNormal];
    [self.numberedMusicalNotationBtn setImageEdgeInsets:UIEdgeInsetsMake(-5, -10, -5, 0)];
    [self.numberedMusicalNotationBtn addTarget:self action:@selector(JPBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.musicName];
    [self.contentView addSubview:self.musicAuthor];
    [self.contentView addSubview:self.musicPriceLabe];
    [self.contentView addSubview:self.marketPriceLabel];
    [self.contentView addSubview:self.joinCarBtn];
    [self.contentView addSubview:self.musicLevel];
    [self.contentView addSubview:self.fiveLineBtn];
    [self.contentView addSubview:self.numberedMusicalNotationBtn];
    [self.contentView addSubview:self.AuthorHeaderImage];
}
-(void)setSingleAddCartStatus:(NSInteger)status{
    if (status == 0) {//已购买
        [self.joinCarBtn setTitle:@"已购买" forState:UIControlStateNormal];
        [self.joinCarBtn setBackgroundColor:[UIColor grayColor]];
        [self.joinCarBtn setEnabled:NO];
    }else if (status == 1) { //已加入购物车
        [self.joinCarBtn setTitle:@"已加入购物车" forState:UIControlStateNormal];
        [self.joinCarBtn setBackgroundColor:[UIColor grayColor]];
        [self.joinCarBtn setEnabled:NO];
    }else{
        [self.joinCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.joinCarBtn setBackgroundColor:ThemeRedColor];
        [self.joinCarBtn setEnabled:YES];
    }
}

-(void)setSingleMusicWithInfo:(id)sender{
    self.dataDic = sender[@"music"];
    NSString *coverurl = sender[@"cover"];
    NSString *musicname = [self.dataDic valueForKey:@"name"];
    CGFloat price = [[self.dataDic valueForKey:@"price"] floatValue];
    CGFloat marketPrice = [[self.dataDic valueForKey:@"marketPrice"] floatValue];
    
    BOOL cartHas = [[self.dataDic valueForKey:@"cartHas"] boolValue];
    BOOL orderHas = [[self.dataDic valueForKey:@"orderHas"] boolValue];

    NSMutableAttributedString *priceAttri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"优惠价:%.1f",price]];
    [priceAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 3)];
//    [priceAttri addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
    [priceAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, priceAttri.length - 3)];
    [priceAttri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, priceAttri.length)];
    
    NSMutableAttributedString *marketPriceAttri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价:%.1f",marketPrice]];
    [marketPriceAttri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, marketPriceAttri.length)];
    [marketPriceAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 3)];
    [marketPriceAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, marketPriceAttri.length - 3)];
    [marketPriceAttri addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, marketPriceAttri.length)];
    if (orderHas) {
        [self.joinCarBtn setTitle:@"已购买" forState:UIControlStateNormal];
        [self.joinCarBtn setBackgroundColor:[UIColor grayColor]];
        [self.joinCarBtn setEnabled:NO];
    }else if (cartHas) {
        [self.joinCarBtn setTitle:@"已加入购物车" forState:UIControlStateNormal];
        [self.joinCarBtn setBackgroundColor:[UIColor grayColor]];
        [self.joinCarBtn setEnabled:NO];
    }else{
        [self.joinCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [self.joinCarBtn setBackgroundColor:ThemeRedColor];
        [self.joinCarBtn setEnabled:YES];
    }
   
    
    [self.joinCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.musicName setText:musicname?musicname:@""];
    [self.musicAuthor setText:[self.dataDic valueForKey:@"author"]];
    [self.musicPriceLabe setAttributedText:priceAttri];
    [self.marketPriceLabel setAttributedText:marketPriceAttri];
    [self.musicLevel setText:[NSString stringWithFormat:@"%@级",[self.dataDic valueForKey:@"rank"]]];
    [self.musicName fitcontentWithWidth];
    if(self.musicName.frame.size.width > Macro_AutoWidth_7p(145)){
        [self.musicName setFrame:CGRectMake(self.musicName.frame.origin.x,
                                            self.musicName.frame.origin.y,
                                            Macro_AutoWidth_7p(145),
                                            self.musicName.frame.size.height)];
    }
    [self.AuthorHeaderImage setImageWithURL:[NSURL URLWithString:coverurl]];
}
-(void)joinCarBtnClick:(id)sender{
    if (self.addToCartsBlock) {
       self.addToCartsBlock(self);
    }
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
+(NSInteger)CellHeight{
    return Macro_AutoWidth_7p(70);
}
@end
