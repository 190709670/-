//
//  OrderDetailViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/8/8.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *mainTableView;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [self setNavgationBackButton];
    [self setObject];
}
- (void)setObject{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame))
                                                      style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
}

#pragma mark TableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(5),
                                                                          Macro_AutoWidth_7p(5),
                                                                          Macro_AutoWidth_7p(50),
                                                                          Macro_AutoWidth_7p(50))];
        icon.tag = 9;
        icon.layer.cornerRadius = 5;
        icon.layer.masksToBounds = YES;
        
        UILabel *musicname = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + Macro_AutoWidth_7p(10),
                                                                     Macro_AutoWidth_7p(5),
                                                                     KWidth - Macro_AutoWidth_7p(20),
                                                                     Macro_AutoWidth_7p(20))];
        [musicname setFont:[UIFont systemFontOfSize:14]];
        musicname.tag = 10;
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + Macro_AutoWidth_7p(10),
                                                                       CGRectGetMaxY(musicname.frame),
                                                                       KWidth - Macro_AutoWidth_7p(30) - CGRectGetMaxX(icon.frame),
                                                                       Macro_AutoWidth_7p(20))];
        [typeLabel setFont:[UIFont systemFontOfSize:12]];
        [typeLabel setTextAlignment:NSTextAlignmentRight];
        [typeLabel setTextColor:[UIColor grayColor]];
        typeLabel.tag = 11;
        
        [cell.contentView addSubview:icon];
        [cell.contentView addSubview:musicname];
        [cell.contentView addSubview:typeLabel];
    }
    UIImageView *icon = (UIImageView *)[cell viewWithTag:9];
    UILabel *musicname = (UILabel *)[cell viewWithTag:10];
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:11];
    
    NSDictionary *dic = self.musicArray[indexPath.row];
    NSString *imageurl = dic[@"songCover"];
    NSString *songName = dic[@"songName"];
    NSInteger type = [dic[@"type"] integerValue];
    [icon setImageWithURL:[NSURL URLWithString:imageurl]];
    [musicname setText:songName];
    [typeLabel setText:[NSString stringWithFormat:@"%@",type==0?@"单曲":@"专辑"]];
  
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musicArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(60);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
