//
//  ShoppingCartMainViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/17.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "ShoppingCartMainViewController.h"
#import "CartTableViewCell.h"
#import "NetWorkingRequest.h"
#import "PlayViewController.h"
#import "OrderPayViewController.h"
#import "NoPayOrderViewController.h"
@interface ShoppingCartMainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) NSMutableArray *cartInfoArray;
@property (nonatomic, retain) UILabel *totalPriceLabel;
@property (nonatomic, retain) UIButton *PayBtn;
@property (nonatomic, assign) NSInteger *pageNo;
@property (nonatomic, retain) UILabel *orderNumberLabel;
@end

@implementation ShoppingCartMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"购物车";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"清空购物车" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick:)];
    [rightBarButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(60), Macro_AutoWidth_7p(15))];
    [self.orderNumberLabel setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"未完成订单" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonClick:)];
    [leftBarButton setTintColor:[UIColor whiteColor]];
    [leftBarButton.customView addSubview:self.orderNumberLabel];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    [self setObject];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestNetWorkingData];
}
-(void)setObject{
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame) - Macro_AutoWidth_7p(50) - self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    self.MainTableView.dataSource = self;
    self.MainTableView.delegate = self;
    [self.view addSubview:self.MainTableView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                  CGRectGetMaxY(self.MainTableView.frame),
                                                                  KWidth,
                                                                  Macro_AutoWidth_7p(50))];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomView];
    
    self.totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(20),
                                                                     0,
                                                                     Macro_AutoWidth_7p(200),
                                                                     CGRectGetHeight(bottomView.frame))];
    [self.totalPriceLabel setFont:[UIFont systemFontOfSize:14]];
    [bottomView addSubview:self.totalPriceLabel];
    
    self.PayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.PayBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(120), 0, Macro_AutoWidth_7p(120), CGRectGetHeight(bottomView.frame))];
    [self.PayBtn setTitle:@"结算" forState:UIControlStateNormal];
    [self.PayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.PayBtn setBackgroundColor:ThemeRedColor];
    [bottomView addSubview:self.PayBtn];
    [self.PayBtn addTarget:self action:@selector(PayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)requestNetWorkingData{
    NSString  *account = [BaseMethod getUserAccount];
    if(account.length > 0){
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendCartListAccount:account Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            self.cartInfoArray = [NSMutableArray arrayWithArray:info.data[@"items"]];
            [self.MainTableView reloadData];
            [self refreshBottomView];
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
        }];
    }else{
        
    }
}
#pragma mark tableviewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *KCell = @"KCell";
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
    }
    NSDictionary *dic = self.cartInfoArray[indexPath.row];
    [cell setCartInfoWithMusicInfo:dic];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cartInfoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CartTableViewCell cellHeight];
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
      NSDictionary *dic = self.cartInfoArray[indexPath.row];
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendCartDoDeleteAccount:account itemID:dic[@"id"] Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
            if (info.success) {
                [self.cartInfoArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                [self refreshBottomView];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.cartInfoArray[indexPath.row];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.MusicID = dic[@"id"];
    [playVC setHidesBottomBarWhenPushed:YES];
    [playVC.navigationItem setTitle:dic[@"songName"]];
    playVC.hotsongDic = dic;
    playVC.isSingleMusic = YES;
    playVC.showTuPu = YES;
    [self.navigationController pushViewController:playVC animated:YES];
    
}
-(void)PayBtnClick:(id)sender{
     NSString  *account = [BaseMethod getUserAccount];
    [BaseMethod showLoadingWithText:@"" inView:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendOrderCreateAccount:account Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        if (info.success) {
            OrderPayViewController *orderpayVC = [[OrderPayViewController alloc] init];
            orderpayVC.sn = info.data[@"sn"];
            orderpayVC.isPay = NO;
            [orderpayVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:orderpayVC animated:YES];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
    }];
}
-(void)refreshBottomView{
    CGFloat totalprice = 0;
    for (NSInteger i = 0; i < self.cartInfoArray.count; i++) {
        NSDictionary *dic = self.cartInfoArray[i];
        totalprice = totalprice + [dic[@"price"] floatValue];
    }
    NSMutableAttributedString *attristring = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：¥%0.2f",totalprice]];
    [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, 3)];
    [attristring addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(3, attristring.length - 3)];
    [self.totalPriceLabel setAttributedText:attristring];
    
    [self.PayBtn setTitle:[NSString stringWithFormat:@"结算（%ld）",self.cartInfoArray.count] forState:UIControlStateNormal];
}
-(void)rightBarButtonClick:(id)sender{
     NSString *account = [BaseMethod getUserAccount];
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendCartDoClearAccount:account  Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        if (info.success) {
            [self viewWillAppear:YES];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
    }];
}
-(void)leftBarButtonClick:(id)sender{
//    [[NetWorkingRequest share_MainViewRequest] SendOrderListWithAccount:[BaseMethod getUserAccount] status:@"0" pageNo:0 Success:^(BaseModel *info) {
//        if (info.success) {
//            NSArray *dataArray = info.data;
//            if (dataArray.count > 0) {
                NoPayOrderViewController *vc = [[NoPayOrderViewController alloc] init];
                [vc setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:vc animated:YES];
//            }else{
//                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
//            }
//        }else{
//            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
//        }
//    } failure:^(NSError *error) {
//        [BaseMethod showToast:@"获取数据失败，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
//    }];
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
