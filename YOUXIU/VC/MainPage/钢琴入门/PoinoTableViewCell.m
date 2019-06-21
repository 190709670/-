//
//  PoinoTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "PoinoTableViewCell.h"
@interface PoinoTableViewCell()
@property (nonatomic, retain) UIImageView *coverImageView;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *contentLabel;
@property (nonatomic, retain) UILabel *knowledgesNumberLabel;
@end
@implementation PoinoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(NSInteger)CellHeight{
    return Macro_AutoWidth_7p(80);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (self.ThisCellSelectedBlock){
        self.ThisCellSelectedBlock(self);
    }
    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                            Macro_AutoWidth_7p(10),
                                                                            Macro_AutoWidth_7p(60),
                                                                            Macro_AutoWidth_7p(60))];
        self.coverImageView.layer.cornerRadius = 5;
        self.coverImageView.layer.masksToBounds = YES;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverImageView.frame) + Macro_AutoWidth_7p(10),
                                                                    CGRectGetMinY(self.coverImageView.frame),
                                                                    KWidth - Macro_AutoWidth_7p(50) - CGRectGetMaxX(self.coverImageView.frame),
                                                                    Macro_AutoWidth_7p(20))];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.titleLabel.frame),
                                                                      Macro_AutoWidth_7p(5) + CGRectGetMaxY(self.titleLabel.frame),
                                                                      KWidth - Macro_AutoWidth_7p(30) - CGRectGetMaxX(self.coverImageView.frame),
                                                                      Macro_AutoWidth_7p(35))];
        [self.contentLabel setNumberOfLines:2];
        
        self.knowledgesNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(120),
                                                                               CGRectGetMinY(self.coverImageView.frame),
                                                                               Macro_AutoWidth_7p(80),
                                                                               Macro_AutoWidth_7p(20))];
        [self.knowledgesNumberLabel setTextColor:[UIColor colorWithRed:4/255.0 green:175/255.0 blue:200/255.0 alpha:1]];
        [self.knowledgesNumberLabel setFont:[UIFont systemFontOfSize:12]];
        [self.knowledgesNumberLabel setTextAlignment:NSTextAlignmentRight];
        
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentLabel setTextColor:[UIColor grayColor]];
        
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.knowledgesNumberLabel];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}
-(void)setPoinoTableViewCellWithDicInfo:(NSDictionary *)dic{
    NSString *imageurlString = [dic valueForKey:@"cover"];
    NSString *titleString = [dic valueForKey:@"title"];
    NSString *contentString = [dic valueForKey:@"content"];
    NSString *knowledgesNumber = [dic valueForKey:@"quantity"];
    [self.coverImageView setImageWithURL:[NSURL URLWithString:imageurlString]];
    
    [self.titleLabel setText:titleString];
    [self.contentLabel setText:contentString];
    [self.knowledgesNumberLabel setText:[NSString stringWithFormat: @"文章数量:%@",knowledgesNumber]];
}

@end
