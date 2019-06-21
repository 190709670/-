//
//  RechargeRecordViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/22.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "RechargeRecordViewController.h"
#import "CustomSegmentView.h"
#import "NetWorkingRequest.h"
#import "RechargeViewController.h"
@interface RechargeRecordViewController ()<UITableViewDelegate,UITableViewDataSource,CustomSegmentViewDelegate>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *rechargeRecodeArray;
@property (nonatomic, retain) CustomSegmentView *segmentView;
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation RechargeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值记录";
    [self setNavgationBackButton];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"充值" style:UIBarButtonItemStylePlain target:self action:@selector(RightBarButtonClick:)];
    [rightBarButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self RequestNetData];
}
-(void)setObject{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, KWidth, KHeight - 64) style:UITableViewStyleGrouped];
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
-(void)RequestNetData{
    __weak typeof(self) weakSelf = self;
    [BaseMethod showLoading:self.view];
    NSString  *account = [BaseMethod getUserAccount];
    [[NetWorkingRequest share_MainViewRequest] SendRechargerecordListWithPageNo:self.pageNumber Account:account Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];
        if (self.pageNumber == 0) {
            self.rechargeRecodeArray = [NSMutableArray arrayWithArray:info.data];
        }else{
            [self.rechargeRecodeArray addObjectsFromArray:info.data];
        }
        self.pageNumber = self.pageNumber + 1;
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showLoadingWithText:error.description inView:self.view];
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
    
    NSDictionary *dic = [self.rechargeRecodeArray objectAtIndex:indexPath.row];
    
    NSString *titleString;
    if([dic[@"payMethod"] isEqualToString:@"WxApp"]){
        titleString = @"微信支付";
    }else if([dic[@"payMethod"] isEqualToString:@"AliApp"]){
        titleString = @"支付宝支付";
    }else{
        titleString = @"未知支付方式";
    }
    
    NSString *timeString = [NSString stringWithFormat:@"%@",dic[@"createDate"]].length>0?dic[@"createDate"]:@"未查询到日期";
    NSString *rechargeSrring = [NSString stringWithFormat:@"%@",dic[@"rechargeAmount"]];
    NSString *uAmountString = [NSString stringWithFormat:@"悠点：%@",dic[@"uAmount"]];
    [titleLabel setText:titleString];
    [subLabel setText:timeString];
    [rechargeLabel setText:rechargeSrring];
    [balanceLabel setText:uAmountString];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rechargeRecodeArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(60);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Macro_AutoWidth_7p(10);
}
-(void)RightBarButtonClick:(id)sender{
    RechargeViewController *vc = [[RechargeViewController alloc] init];
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
