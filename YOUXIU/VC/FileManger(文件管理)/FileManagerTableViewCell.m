//
//  FileManagerTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/5/24.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "FileManagerTableViewCell.h"
@interface FileManagerTableViewCell()
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) UILabel *musicAuthor;
@property (nonatomic, retain) CustomFitContentLabel *musicName;
@end
@implementation FileManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
   
    }
    return self;
}
-(void)setFileInfoWith:(id)FileInfo isLocal:(BOOL)Local{
    if (Local) {
        [self.btn setBackgroundImage:[UIImage imageNamed:@"management_delete"] forState:UIControlStateNormal];
    }else{
        [self.btn setBackgroundImage:[UIImage imageNamed:@"management_recovery"] forState:UIControlStateNormal];
    }
    NSString *name = FileInfo[@"fileName"];
    NSString *author = FileInfo[@"author"]?FileInfo[@"author"]:@"未获取作者信息";
    [ self.musicName setText:name];
    [self.musicAuthor setText:author];
}

-(void)createUI{
    self.musicName = [[CustomFitContentLabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                             Macro_AutoWidth_7p(5),
                                                                             KWidth,
                                                                             Macro_AutoWidth_7p(30))];
    
    self.musicAuthor = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.musicName.frame), CGRectGetMaxY(self.musicName.frame), Macro_AutoWidth_7p(300), Macro_AutoWidth_7p(20))];
    [self.musicAuthor setFont:[UIFont systemFontOfSize:12]];
    [self.musicAuthor setTextColor:[UIColor grayColor]];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(35), 0, Macro_AutoWidth_7p(20), Macro_AutoWidth_7p(20))];
    [self.btn setCenter:CGPointMake(self.btn.center.x, Macro_AutoWidth_7p(60)/2.0)];
    [self.btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.btn];
    [self.contentView addSubview:self.musicName];
    [self.contentView addSubview:self.musicAuthor];
}
-(void)BtnClick:(id)sender{
    if (self.rightbtnclickBlock) {
        self.rightbtnclickBlock(self);
    }
}
+ (CGFloat)cellHeight{
    return Macro_AutoWidth_7p(60);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
