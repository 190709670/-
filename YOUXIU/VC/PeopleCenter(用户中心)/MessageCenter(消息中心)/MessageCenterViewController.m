//
//  MessageCenterViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/6/23.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "NetWorkingRequest.h"
#import "MessageReplyDetailViewController.h"
@interface MessageCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息中心";
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self ReqeustNetWorkData];
}
-(void)setObject{
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    [self.view addSubview:self.MainTableView];
}
-(void)ReqeustNetWorkData{
    NSString *account =[BaseMethod getUserAccount];
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendMessageListAccount:account Success:^(BaseModel *result) {
        [BaseMethod hideAllHudsInView:self.view];
        if (self.dataArray == nil) {
            self.dataArray = [[NSMutableArray alloc] init];
        }
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:result.data];
        [self.MainTableView reloadData];
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
    }];
}
#pragma mark tableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Macro_AutoWidth_7p(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(70);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        
        UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                      Macro_AutoWidth_7p(5),
                                                                      KWidth - Macro_AutoWidth_7p(10),
                                                                      Macro_AutoWidth_7p(20))];
        titLabel.tag = 1;
        [titLabel setFont:[UIFont systemFontOfSize:14]];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titLabel.frame),
                                                                          CGRectGetMaxY(titLabel.frame) + Macro_AutoWidth_7p(5),
                                                                          CGRectGetWidth(titLabel.frame),
                                                                          Macro_AutoWidth_7p(15))];
        [contentLabel setFont:[UIFont systemFontOfSize:12]];
        contentLabel.tag = 3;
        
        UILabel *repaycontent = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(contentLabel.frame),
                                                                          CGRectGetMaxY(contentLabel.frame),
                                                                          Macro_AutoWidth_7p(190),
                                                                          Macro_AutoWidth_7p(20))];
        repaycontent.tag = 4;
        [repaycontent setFont:[UIFont systemFontOfSize:12]];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(200),
                                                                       CGRectGetMaxY(contentLabel.frame),
                                                                       Macro_AutoWidth_7p(190),
                                                                       Macro_AutoWidth_7p(20))];
        timeLabel.tag = 2;
        [timeLabel setTextColor:[UIColor grayColor]];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        [timeLabel setTextAlignment:NSTextAlignmentRight];
        
        [cell.contentView addSubview:repaycontent];
        [cell.contentView addSubview:titLabel];
        [cell.contentView addSubview:timeLabel];
        [cell.contentView addSubview:contentLabel];
    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
     UILabel *timeLabel = (UILabel *)[cell viewWithTag:2];
     UILabel *contnetLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *repayLabel = (UILabel *)[cell viewWithTag:4];
    NSDictionary *dic = self.dataArray[indexPath.row];

    NSInteger isread = [dic[@"isRead"] integerValue];
    if (isread == 0) {
        NSMutableAttributedString *attristring = [[NSMutableAttributedString alloc] initWithString:@" ○  通知"];
        [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
        [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(4, 2)];
        [titleLabel setAttributedText:attristring];
    }else{
        NSMutableAttributedString *attristring = [[NSMutableAttributedString alloc] initWithString:@"通知"];
        [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, 2)];
        [titleLabel setAttributedText:attristring];
    }
    NSString *time = dic[@"occurDate"];
    NSString *content = dic[@"content"];
    NSString *replycontentString = dic[@"replyContent"];
    [timeLabel setText:[NSString stringWithFormat:@"反馈时间:%@" ,time]];
    [contnetLabel setText:content];
    if (replycontentString.length > 0) {
        [repayLabel setText:[NSString stringWithFormat:@"回复：%@", replycontentString]];
        [repayLabel setTextColor:[UIColor darkTextColor]];
    }else{
        [repayLabel setText:@"未回复"];
        [repayLabel setTextColor:[UIColor redColor]];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageReplyDetailViewController *VC = [[MessageReplyDetailViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
