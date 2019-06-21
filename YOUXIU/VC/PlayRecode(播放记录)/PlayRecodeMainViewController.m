//
//  PlayRecodeMainViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/17.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "PlayRecodeMainViewController.h"
#import "PayRecodTableViewCell.h"
#import "NetWorkingRequest.h"
@interface PlayRecodeMainViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) NSMutableArray *payrecodeArray;
@property (nonatomic, assign) NSInteger PageNo;
@end

@implementation PlayRecodeMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"播放记录";
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"清空播放记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick:)];
    [rightBarButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self NetWorkingRequest];
    self.PageNo = 1;
}

-(void)setObject{
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    __weak typeof(self) weakSelf = self;
    self.MainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf NetWorkingRequest];
        self.PageNo = 1;
    }];
    self.MainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf NetWorkingRequest];
    }];
    [self.view addSubview:self.MainTableView];
}
-(void)NetWorkingRequest{
     NSString *account = [BaseMethod getUserAccount];
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendPlayRecordListWithPageNo:self.PageNo Account:account Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        if (info.success) {
            if (self.PageNo == 1) {
                self.payrecodeArray = [[NSMutableArray alloc] initWithArray:info.data];
            }else{
                [self.payrecodeArray addObjectsFromArray:info.data];
            }
            self.PageNo = self.PageNo + 1;
            [self.MainTableView reloadData];
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
    }];
}
-(void)rightBarButtonClick:(id)sender{
    NSMutableString *idsString = [[NSMutableString alloc] init];
    for (NSDictionary *dic in self.payrecodeArray) {
        NSString *thisid = dic[@"id"];
        if (idsString.length <= 0) {
            [idsString appendFormat:@"%@",thisid];
        }else{
            [idsString appendFormat:@"-%@",thisid];
        }
    }
     NSString  *account = [BaseMethod getUserAccount];
    [BaseMethod showLoading:self.view];
   [[NetWorkingRequest share_MainViewRequest] SendPlayrecordDoHatchDeleteWithIDS:idsString Account:account Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        if (info.success) {
            [self.payrecodeArray removeAllObjects];
            [self.MainTableView reloadData];
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.payrecodeArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    PayRecodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[PayRecodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
    }
    NSDictionary *dic = self.payrecodeArray[indexPath.row];
    [cell setPayRecodInfoWithMusicInfo:dic];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PayRecodTableViewCell cellHeight];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{//请求数据源提交的插入或删除指定行接收者。
    if (editingStyle ==UITableViewCellEditingStyleDelete) {//如果编辑样式为删除样式
         NSString  *account = [BaseMethod getUserAccount];
        NSDictionary *dic = self.payrecodeArray[indexPath.row];
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendPlayrecordDoHatchDeleteWithIDS:dic[@"id"] Account:account Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
            if (info.success) {
                [self.payrecodeArray removeObjectAtIndex:indexPath.row];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
}
-(NSMutableArray *)payrecodeArray{
    if (_payrecodeArray == nil) {
        _payrecodeArray = [[NSMutableArray alloc]init];
    }
    return _payrecodeArray;
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
