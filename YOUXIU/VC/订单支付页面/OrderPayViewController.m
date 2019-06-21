//
//  OrderPayViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "OrderPayViewController.h"
#import "CustomSelectedCellTableViewCell.h"
#import "NetWorkingRequest.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/UIImage+AFNetworking.h>
#import "DownLoadMetch.h"
#import "OrderDetailViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "RechargeViewController.h"

@interface OrderPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) UILabel *orderNumberLabel;
@property (nonatomic, retain) UILabel *priceLabel;
@property (nonatomic, retain) NSArray *cellinfoarray;
@property (nonatomic, retain) UIButton *PayBtn;
@property (nonatomic, assign) NSInteger selectedRow;
@property (nonatomic, retain) NSDictionary *OrderInfoDic;
@end

@implementation OrderPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付订单";
    [self setNavgationBackButton];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"订单详情" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick:)];
    [rightBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self setObject];
}
-(void)setObject{
    if(!self.isPay){
    self.cellinfoarray = @[@{
                               @"imagename":@"order_youxiu",
                               @"title":@"悠点余额支付",
                               @"subtitle":@"可到个人中心充值"
                               },
                           @{
                               @"imagename":@"order_zhifubao",
                               @"title":@"支付宝",
                               @"subtitle":@"支持有支付宝、网银的用户使用"
                               },
                           @{
                               @"imagename":@"order_weixin",
                               @"title":@"微信支付",
                               @"subtitle":@"使用微信支付、安全便捷"
                               }];
    }else{
        self.cellinfoarray =@[];
    }
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Macro_AutoWidth_7p(5), KWidth,KHeight - Macro_AutoWidth_7p(50) - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    
    self.PayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.PayBtn setFrame:CGRectMake(0, CGRectGetMaxY(self.MainTableView.frame), KWidth, Macro_AutoWidth_7p(50))];
    [self.PayBtn setBackgroundColor:ThemeRedColor];
    [self.PayBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.PayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.PayBtn addTarget:self action:@selector(PayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.MainTableView];
    if (self.isPay) {
        
    }else{
        [self.view addSubview:self.PayBtn];
    }
    [self.view setBackgroundColor:self.MainTableView.backgroundColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self RequestNetWorkData];
}
-(void)RequestNetWorkData{
    NSString *account = [BaseMethod getUserAccount];
    [[NetWorkingRequest share_MainViewRequest] SendOrderViewAccount:account SN:self.sn Success:^(BaseModel *info) {
        NSLog(@"info: %@",info);
        self.OrderInfoDic = info.data;
        [self.MainTableView reloadData];
    } failure:^(NSError *error) {
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
    }];
}

-(void)PayBtnClick:(id)sender{
    if(self.selectedRow == 0){
        //悠点支付
        NSString *account = [BaseMethod getUserAccount];
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendPaymentUshowPayWithSN:self.sn Account:account Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToastOnWindowWithString:info.message hideAfterSecond:2];
            if (info.success) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否立即开始下载\n也可以在购买页面进行下载" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"暂不下载" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];

                }];
                UIAlertAction *trueBtn = [UIAlertAction actionWithTitle:@"立即下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [self DownLoadWithSN:self.sn];
                }];
                [alertVC addAction:cancelBtn];
                [alertVC addAction:trueBtn];
                
                [self presentViewController:alertVC animated:YES completion:nil];
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
                if ([info.message isEqualToString:@"余额不足"]) {
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"余额不足，是否现在充值" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"暂不充值" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
                    }];
                    UIAlertAction *trueBtn = [UIAlertAction actionWithTitle:@"立即充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
                        [rechargeVC setHidesBottomBarWhenPushed:YES];
                        [self.navigationController pushViewController:rechargeVC animated:YES];
                    }];
                    [alertVC addAction:cancelBtn];
                    [alertVC addAction:trueBtn];
                    
                    [self presentViewController:alertVC animated:YES completion:nil];
                    
                   
                }
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
        }];
    }else if(self.selectedRow == 1){//支付支付
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendPaymentAliAppPayWithSN:self.sn Account:[BaseMethod getUserAccount] Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];

            if (info.success){
                NSString *orderString = [info.data valueForKey:@"orderInfo"];
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"UXiu" callback:^(NSDictionary *resultDic) {
                }];
                //添加通知
                [self addNotice];
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
        }];
    }else if (self.selectedRow == 2){//微信支付
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendPaymentWXAppPayWithSN:self.sn Account:[BaseMethod getUserAccount] Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];

            if (info.success){
                NSDictionary *orderinfoDic = info.data[@"orderInfo"];
                [WXApi registerApp:orderinfoDic[@"appid"]];
                
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = orderinfoDic[@"partnerid"];
                request.prepayId = orderinfoDic[@"prepayid"];
                request.package = orderinfoDic[@"package"];
                request.nonceStr = orderinfoDic[@"noncestr"];
                request.timeStamp = [orderinfoDic[@"timestamp"] intValue];
                request.sign = orderinfoDic[@"sign"];
                [WXApi sendReq:request];
                
                //添加通知
                [self addNotice];
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
        }];
    }
}
-(void)DownLoadWithSN:(NSString *)SN{
    NSString *account = [BaseMethod getUserAccount];
    [[NetWorkingRequest share_MainViewRequest] SendOrderGetOrderFileViewAccount:account SN:SN Success:^(BaseModel *info) {
        NSArray *itemsArray = [info.data valueForKey:@"items"];
        for (NSInteger i = 0; i < itemsArray.count; i++) {
            NSDictionary *itemDic = itemsArray[i];
            if(itemDic == nil||[itemDic isKindOfClass:[NSNull class]]){
                [BaseMethod showToastOnWindowWithString:@"下载获取数据异常，请至个人中心下载" hideAfterSecond:Macro_ShowLoadingDefaultTime];
                return ;
            }
            [self DownLoadWithZipPath:itemDic];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)DownLoadWithZipPath:(NSDictionary *)fileDic{
    NSString *zipPath = [fileDic valueForKey:@"zipPath"];
    BOOL isSingleMusic =fileDic[@"type"];
    if(zipPath.length > 0){
        [[DownLoadMetch shareInstance] StartLoadFileWithPath:zipPath fileName:@"" fileDic:fileDic isSingleMusic:isSingleMusic complete:nil];
    }else{
        [BaseMethod showToast:@"获取文件出错，请稍后再试" hideAfterSecond:2 inView:self.view];
    }
}

#pragma mark tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *kcell = @"KCell";
    CustomSelectedCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell];
    if (cell == nil) {
        cell = [[CustomSelectedCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    NSDictionary *dic = self.cellinfoarray[indexPath.row];
    if (indexPath.row == 0) {
        [cell setCellInfoWithDic:dic Recomment:@"推荐"];
    }else{
        [cell setCellInfoWithDic:dic Recomment:nil];
    }
    if (indexPath.row == self.selectedRow) {
        [cell setSelectBtnSelected:YES];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.selectedRow == indexPath.row){
        CustomSelectedCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setSelectBtnSelected:!cell.CellSelectedStatus];
    }else{
        CustomSelectedCellTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedRow inSection:1]];
        [cell setSelectBtnSelected:NO];
        
        CustomSelectedCellTableViewCell *cell2 = [tableView cellForRowAtIndexPath:indexPath];
        [cell2 setSelectBtnSelected:!cell.CellSelectedStatus];
    }
    self.selectedRow = indexPath.row;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return Macro_AutoWidth_7p(50);
    }
    return Macro_AutoWidth_7p(5);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(50))];
    [headview setBackgroundColor:[UIColor whiteColor]];
    
    self.orderNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(5), KWidth - Macro_AutoWidth_7p(20), Macro_AutoWidth_7p(20))];
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), CGRectGetMaxY(self.orderNumberLabel.frame), KWidth - Macro_AutoWidth_7p(20), Macro_AutoWidth_7p(20))];
        
        
        NSString *orderString = self.OrderInfoDic[@"sn"];
        NSString *priceString = self.OrderInfoDic[@"amount"];
    [self.orderNumberLabel setAttributedText:[self getAttributeStringWithStringInfo:[NSString stringWithFormat:@"订单编号：%@",orderString]]];
    [self.priceLabel setAttributedText:[self getPriceAttributeStringWithStringInfo:[NSString stringWithFormat:@"订单金额：%@",priceString]]];
        
        
    [headview addSubview:self.orderNumberLabel];
    [headview addSubview:self.priceLabel];
    return headview;
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return self.cellinfoarray.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return [CustomSelectedCellTableViewCell CellHeight];
}
-(NSMutableAttributedString *)getAttributeStringWithStringInfo:(NSString *)string{
    NSMutableAttributedString *attristring = [[NSMutableAttributedString alloc] initWithString:string];
    [attristring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 5)];
    [attristring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(5, string.length - 5)];
    [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 5)];
    return attristring;
}
-(NSMutableAttributedString *)getPriceAttributeStringWithStringInfo:(NSString *)string{
    NSMutableAttributedString *attristring = [[NSMutableAttributedString alloc] initWithString:string];
    [attristring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 5)];
    [attristring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(5, string.length - 5)];
    [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 5)];
    [attristring addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, string.length - 5)];

    return attristring;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(void)rightBarItemClick:(id)sender{
    OrderDetailViewController *orderDetail = [[OrderDetailViewController alloc] init];
    orderDetail.musicArray = self.OrderInfoDic[@"items"];
    [self.navigationController pushViewController:orderDetail animated:YES];
}
-(void)addNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AlipayRechargerResult:) name:AlipayRechargeNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXRechargerResult:) name:WXRechargeNotice object:nil];
}
-(void)removeNotice{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)AlipayRechargerResult:(NSNotification *)notice{
    id result = notice.object;
    NSInteger resultStatus = [result[@"resultStatus"] integerValue];
    if (resultStatus == 9000) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否立即开始下载\n也可以在购买页面进行下载" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"暂不下载" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        UIAlertAction *trueBtn = [UIAlertAction actionWithTitle:@"立即下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            //   [self DownLoadNow];//开始下载
            [self DownLoadWithSN:self.sn];
        }];
        [alertVC addAction:cancelBtn];
        [alertVC addAction:trueBtn];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        [BaseMethod showToast:result[@"memo"] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
    }
    [self removeNotice];
}
-(void)WXRechargerResult:(NSNotification *)notice{
    PayResp *result = notice.object;
    [BaseMethod WXRechargeWithWXCode:result.errCode Result:^(NSDictionary *result) {
        if ([result[@"success"] boolValue]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否立即开始下载\n也可以在购买页面进行下载" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"暂不下载" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            UIAlertAction *trueBtn = [UIAlertAction actionWithTitle:@"立即下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
                //   [self DownLoadNow];//开始下载
                [self DownLoadWithSN:self.sn];
            }];
            [alertVC addAction:cancelBtn];
            [alertVC addAction:trueBtn];
            
            [self presentViewController:alertVC animated:YES completion:nil];
        }else{
            [BaseMethod showToast:result[@"msg"] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }
        [self removeNotice];
    }];
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
