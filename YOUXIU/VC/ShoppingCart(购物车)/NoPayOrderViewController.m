//
//  NoPayOrderViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/8/8.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "NoPayOrderViewController.h"
#import "OrderPayViewController.h"
#import "NetWorkingRequest.h"

@interface NoPayOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *orderArray;
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation NoPayOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"待支付订单";
    [self setNavgationBackButton];

    
    [self setObject];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestNetWorkData];
}
-(void)setObject{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame))
                                                      style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    __weak typeof(self) weakSelf = self;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 0;
        [weakSelf requestNetWorkData];
    }];
    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestNetWorkData];
    }];
}
- (void)requestNetWorkData{
    __weak typeof(self) weakSelf = self;
    [[NetWorkingRequest share_MainViewRequest] SendOrderListWithAccount:[BaseMethod getUserAccount] status:@"0" pageNo:self.pageNumber Success:^(BaseModel *info) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];
        if (info.success) {
           
            if (self.pageNumber == 0) {
                self.orderArray = [NSMutableArray arrayWithArray:info.data];
            }else{
                [self.orderArray addObjectsFromArray:info.data];
            }
            self.pageNumber = self.pageNumber + 1;
            [self.mainTableView reloadData];
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }
    } failure:^(NSError *error) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        [weakSelf.mainTableView.mj_footer endRefreshing];
        [BaseMethod showToast:@"获取数据失败，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        UILabel *snLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                     Macro_AutoWidth_7p(5),
                                                                     KWidth - Macro_AutoWidth_7p(20),
                                                                     Macro_AutoWidth_7p(20))];
        [snLabel setFont:[UIFont systemFontOfSize:14]];
        snLabel.tag = 10;
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                       CGRectGetMaxY(snLabel.frame),
                                                                       KWidth - Macro_AutoWidth_7p(20),
                                                                       Macro_AutoWidth_7p(20))];
        [timeLabel setFont:[UIFont systemFontOfSize:12]];
        [timeLabel setTextAlignment:NSTextAlignmentRight];
        [timeLabel setTextColor:[UIColor grayColor]];
        timeLabel.tag = 11;
        [cell.contentView addSubview:snLabel];
        [cell.contentView addSubview:timeLabel];
    }
    UILabel *snLabel = (UILabel *)[cell viewWithTag:10];
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:11];
    
    NSDictionary *dic = self.orderArray[indexPath.row];
    NSInteger occurDate = [dic[@"occurDate"] integerValue];
    NSString *sn = dic[@"sn"];
    [snLabel setText:[NSString stringWithFormat:@"订单号: %@", sn]];
    NSString *timeString = [BaseMethod getDateStringWithTimestamp:occurDate];
    [timeLabel setText:timeString];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(50);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.orderArray[indexPath.row];
    NSString *sn = dic[@"sn"];
    OrderPayViewController *vc = [[OrderPayViewController alloc] init];
    vc.sn = sn;
    vc.isPay = NO;
    [self.navigationController pushViewController:vc animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
        NSString  *account = [BaseMethod getUserAccount];
        NSDictionary *dic = self.orderArray[indexPath.row];
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendOrderAbolishAccount:account SN:dic[@"sn"] Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
            if (info.success) {
                [self.orderArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
        }];
    }
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
