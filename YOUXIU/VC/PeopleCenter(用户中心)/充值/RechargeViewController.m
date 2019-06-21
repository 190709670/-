//
//  RechargeViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/31.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "RechargeViewController.h"
#import "CustomSelectedCellTableViewCell.h"
#import <AlipaySDK/AlipaySDK.h>
#import "NetWorkingRequest.h"
#import "WXApi.h"
typedef NS_ENUM(NSInteger, RechargeType) {
    RechargeType_50 = 1,
    RechargeType_100 = 2,
    RechargeType_200 =3,
    RechargeType_300=4
};

@interface RechargeViewController ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) UIButton *btn50;
@property (nonatomic, retain) UIButton *btn100;
@property (nonatomic, retain) UIButton *btn200;
@property (nonatomic, retain) UIButton *btn300;
@property (nonatomic, retain) NSArray *cellinfoArray;
@property (nonatomic, assign) RechargeType rechargeType;
@end

@implementation RechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"充值";
    [self addNotice];
    [self setNavgationBackButton];
    [self setObject];
}
-(void)addNotice{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AlipayRechargerResult:) name:AlipayRechargeNotice object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXRechargerResult:) name:WXRechargeNotice object:nil];
}
-(void)setObject{
    self.cellinfoArray = @[
                           @{
                               @"imagename":@"order_zhifubao",
                               @"title":@"支付宝支付",
                               @"subtitle":@"支持有支付宝、网银的用户使用"
                               },
                           @{
                               @"imagename":@"order_weixin",
                               @"title":@"微信支付",
                               @"subtitle":@"使用微信支付、安全便捷"
                               }];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStyleGrouped];
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self.view addSubview:self.mainTableView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
#pragma mark tableviewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(40))];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(40))];
        [titleLabel setText:@"  选择支付方式"];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        [headview addSubview:titleLabel];
        return headview;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return Macro_AutoWidth_7p(40);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Macro_AutoWidth_7p(100);
    }else{
        return Macro_AutoWidth_7p(50);
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(300), Macro_AutoWidth_7p(12))];
        [titleLabel setText:@"请选择充值金额"];
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        [titleLabel setTextColor:[UIColor grayColor]];
        
        self.btn50 = [self setBtnType:self.btn50 type:RechargeType_50];
        self.btn50.tag = RechargeType_50;
        
        self.btn100 = [self setBtnType:self.btn100 type:RechargeType_100];
        self.btn100.tag = RechargeType_100;

        self.btn200 = [self setBtnType:self.btn200 type:RechargeType_200];
        self.btn200.tag = RechargeType_200;

        self.btn300 = [self setBtnType:self.btn300 type:RechargeType_300];
        self.btn300.tag = RechargeType_300;

        [self.btn50 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn100 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn200 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn300 addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat width = Macro_AutoWidth_7p(80);
        CGFloat height = Macro_AutoWidth_7p(40);
        [self.btn50 setFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                        CGRectGetMaxY(titleLabel.frame) + Macro_AutoWidth_7p(15),
                                        width,
                                        height)];
        [self.btn100 setFrame:CGRectMake(CGRectGetMaxX(self.btn50.frame) + Macro_AutoWidth_7p(10),
                                         CGRectGetMinY(self.btn50.frame),
                                         width,
                                         height)];
        [self.btn200 setFrame:CGRectMake(CGRectGetMaxX(self.btn100.frame) +Macro_AutoWidth_7p(10),
                                         CGRectGetMinY(self.btn50.frame),
                                         width,
                                         height)];
        [self.btn300 setFrame:CGRectMake(CGRectGetMaxX(self.btn200.frame) +Macro_AutoWidth_7p(10),
                                         CGRectGetMinY(self.btn50.frame),
                                         width,
                                         height)];

        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:self.btn50];
        [cell.contentView addSubview:self.btn100];
        [cell.contentView addSubview:self.btn200];
        [cell.contentView addSubview:self.btn300];
        
        [self BtnClick:self.btn300];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
        
        NSDictionary *dic = self.cellinfoArray[indexPath.row];
        [cell.imageView setImage:[UIImage imageNamed:dic[@"imagename"]]];
        [cell.textLabel setText:dic[@"title"]];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *amount,*uAmount;
    switch (self.rechargeType) {
            case RechargeType_50:{
                amount = @"0.01";
                uAmount = @"50";
            }break;
            case RechargeType_100:{
                amount = @"100";
                uAmount = @"110";
            }break;
            case RechargeType_200:{
                amount = @"200";
                uAmount = @"230";
            }break;
            case RechargeType_300:{
                amount = @"300";
                uAmount = @"360";
            }break;
        default:
            break;
    }

    if (indexPath.section == 1 && indexPath.row == 0) {
        //支付宝充值
        [self AlipayRechargeWithAmount:amount uAmount:uAmount];
    }else if (indexPath.section == 1 && indexPath.row == 1){
        [self WXRechargeWithAmount:amount uAmount:uAmount];
    }
    
}
//支付宝充值
-(void)AlipayRechargeWithAmount:(NSString *)Amount uAmount:(NSString *)uAmount{
    NSString *username = [BaseMethod getUserAccount];
    [[NetWorkingRequest share_MainViewRequest] SendPaymentAliAppPayWithRechargeAmount:Amount Account:username uAmount:uAmount Success:^(BaseModel *info) {
        if(info.success){
            [self addNotice];
            NSString *orderString = [info.data valueForKey:@"orderInfo"];
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"UXiu" callback:^(NSDictionary *resultDic) {
                //wap支付的时候回调，跳转支付宝的时候不回调此方法
            }];
        }
    } failure:^(NSError *error) {
    }];
}
-(void)WXRechargeWithAmount:(NSString *)Amount uAmount:(NSString *)uAmount{
    NSString *username = [BaseMethod getUserAccount];

    [[NetWorkingRequest share_MainViewRequest] SendPaymentWXAppRechargeWithRechargeAmount:Amount Account:username uAmount:uAmount Success:^(BaseModel *info) {
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
         [self addNotice];
    } failure:^(NSError *error) {
        NSLog(@"error.description : %@",error.description);
    }];
}
-(void)AlipayRechargerResult:(NSNotification *)notice{
   id result = notice.object;
    NSInteger resultStatus = [result[@"resultStatus"] integerValue];
    [BaseMethod AlipayRechargeWithAlipayCode:resultStatus Result:^(NSDictionary *result) {
        NSString *msg = result[@"msg"];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"继续充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *twoAction = [UIAlertAction actionWithTitle:@"取消充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVC addAction:oneAction];
        [alertVC addAction:twoAction];
        
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
        [self removeNotice];
    }];
}
-(void)WXRechargerResult:(NSNotification *)notice{
    PayResp *result = notice.object;
    [BaseMethod WXRechargeWithWXCode:result.errCode Result:^(NSDictionary *result) {
        NSString *msg = result[@"msg"];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *oneAction = [UIAlertAction actionWithTitle:@"继续充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *twoAction = [UIAlertAction actionWithTitle:@"取消充值" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertVC addAction:oneAction];
        [alertVC addAction:twoAction];
        
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
        [self removeNotice];
    }];
}

-(void)BtnClick:(UIButton *)btn{
    [self setBtnShowbtn:btn];
    self.rechargeType = btn.tag;
}
-(void)setBtnShowbtn:(UIButton *)Btn{
    if (Btn == nil) {
        Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [self.btn50.titleLabel setTextColor:[UIColor grayColor]];
    self.btn50.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.btn100.titleLabel setTextColor:[UIColor grayColor]];
    self.btn100.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.btn200.titleLabel setTextColor:[UIColor grayColor]];
    self.btn200.layer.borderColor = [UIColor grayColor].CGColor;
    
    [self.btn300.titleLabel setTextColor:[UIColor grayColor]];
    self.btn300.layer.borderColor = [UIColor grayColor].CGColor;
    
  //  [Btn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    [Btn.titleLabel setTextColor:ThemeRedColor];
    Btn.layer.borderColor = ThemeRedColor.CGColor;
}
-(UIButton *)setBtnType:(UIButton *)Btn type:(RechargeType)type{
    NSString *string;
    NSMutableAttributedString *attriString;
    switch (type) {
        case RechargeType_50:
            {
                string = @"50元\n到账：50.00";
                attriString = [[NSMutableAttributedString alloc] initWithString:string];
                [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 3)];
                [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(3, attriString.length - 3)];
            }
            break;
        case RechargeType_100:
        {
            string = @"100元\n到账：110.00";
            attriString = [[NSMutableAttributedString alloc] initWithString:string];
            [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
            [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(4, attriString.length - 4)];
        }
            break;
        case RechargeType_200:
        {
            string = @"200元\n到账：230.00";
            attriString = [[NSMutableAttributedString alloc] initWithString:string];
            [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
            [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(4, attriString.length - 4)];
        }
            break;
        case RechargeType_300:
        {
            string = @"300元\n到账：360.00";
            attriString = [[NSMutableAttributedString alloc] initWithString:string];
            [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 4)];
            [attriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(4, attriString.length - 4)];
        }
            break;
        default:
            break;
    }
    if (Btn == nil) {
        Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [Btn setAttributedTitle:attriString forState:UIControlStateNormal];
    Btn.titleLabel.numberOfLines = 0;
    [Btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [Btn.titleLabel setTextColor:[UIColor grayColor]];
    Btn.layer.cornerRadius = 5;
    Btn.layer.borderWidth = 1;
    Btn.layer.borderColor = [UIColor grayColor].CGColor;
    return Btn;
}
-(void)removeNotice{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AlipayRechargeNotice object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:WXRechargeNotice object:nil];
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
