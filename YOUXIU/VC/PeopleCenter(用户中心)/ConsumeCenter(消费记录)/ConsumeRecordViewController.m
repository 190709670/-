//
//  ConsumeRecordViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/8/14.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "ConsumeRecordViewController.h"
#import "NetWorkingRequest.h"
#import "OrderPayViewController.h"
@interface ConsumeRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation ConsumeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消费记录";
    [self setNavgationBackButton];
    [self setUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self RequestNetData];
}
- (void)setUI{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - 64) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    __weak typeof(self) weakSelf = self;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 0;
        [weakSelf RequestNetData];
    }];
    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf RequestNetData];
    }];
}
- (void)RequestNetData{
    __weak typeof(self) weakSelf = self;
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendOrderListWithAccount:[BaseMethod getUserAccount] status:@"2" pageNo:self.pageNumber Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];
        if (info.success) {
            if (self.pageNumber == 0) {
                self.dataArray = [NSMutableArray arrayWithArray:info.data];
            }else{
                [self.dataArray addObjectsFromArray:info.data];
            }
            self.pageNumber = self.pageNumber + 1;
            [self.mainTableView reloadData];
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }
    } failure:^(NSError *error) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:@"获取数据失败，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
        UILabel *titLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(200), Macro_AutoWidth_7p(20))];
        [titLabel setFont:[UIFont systemFontOfSize:14]];
        titLabel.tag = 1;
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titLabel.frame),
                                                                       CGRectGetMaxY(titLabel.frame),
                                                                       CGRectGetWidth(titLabel.frame),
                                                                       Macro_AutoWidth_7p(20))];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        timeLabel.tag = 2;
        [timeLabel setTextColor:[UIColor grayColor]];
        
        UILabel *rechargeLabel = [[UILabel alloc] initWithFrame:CGRectMake( CGRectGetMaxX(titLabel.frame),
                                                                           CGRectGetMinY(titLabel.frame),
                                                                           KWidth - CGRectGetMaxX(titLabel.frame) - Macro_AutoWidth_7p(10),
                                                                           CGRectGetHeight(titLabel.frame))];
        rechargeLabel.textColor = ThemeRedColor;
        rechargeLabel.tag = 3;
        [rechargeLabel setFont:[UIFont systemFontOfSize:14]];
        [rechargeLabel setTextAlignment:NSTextAlignmentRight];
        
        UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(rechargeLabel.frame),
                                                                          CGRectGetMinY(timeLabel.frame),
                                                                          CGRectGetWidth(rechargeLabel.frame),
                                                                          CGRectGetHeight(timeLabel.frame))];
        [balanceLabel setFont:timeLabel.font];
        balanceLabel.textColor = timeLabel.textColor;
        [balanceLabel setTextAlignment:NSTextAlignmentRight];
        balanceLabel.tag = 4;
        
        [cell.contentView addSubview:titLabel];
        [cell.contentView addSubview:timeLabel];
        [cell.contentView addSubview:rechargeLabel];
        [cell.contentView addSubview:balanceLabel];
    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *subLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *rechargeLabel = (UILabel *)[cell viewWithTag:3];
    UILabel *balanceLabel = (UILabel *)[cell viewWithTag:4];
    
    NSDictionary *dic = [self.dataArray objectAtIndex:indexPath.row];
    
    NSString *titleString;
    if([dic[@"paymentMethod"] isEqualToString:@"WxApp"]){
        titleString = @"微信支付";
    }else if([dic[@"paymentMethod"] isEqualToString:@"AliApp"]){
        titleString = @"支付宝支付";
    }else if([dic[@"paymentMethod"] isEqualToString:@"ushow_pay"]){
        titleString = @"悠点支付";
    }
    
    NSString *timeString = [BaseMethod getDateStringWithTimestamp:[dic[@"occurDate"] integerValue]];
    NSString *rechargeSrring = [NSString stringWithFormat:@"消费:%@",dic[@"paidAmount"]];
    [titleLabel setText:titleString];
    [subLabel setText:timeString];
    [rechargeLabel setText:rechargeSrring];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(60);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *sn = dic[@"sn"];
    OrderPayViewController *vc = [[OrderPayViewController alloc] init];
    vc.sn = sn;
    vc.isPay = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
