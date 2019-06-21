//
//  PeopleMainViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "PeopleMainViewController.h"
#import "PeopleInfoViewController.h"
#import "LoginMainViewController.h"
#import "BaseNavigationViewController.h"
#import "PeopleInfoModel.h"
#import "NetWorkingRequest.h"
#import "SettingViewController.h"
#import "UserFeedbackViewController.h"
#import "RechargeRecordViewController.h"
#import "DownRecordViewController.h"
#import "FileManagerViewController.h"
#import "PlayRecodeMainViewController.h"
#import "SearchPageViewController.h"
#import "RechargeViewController.h"
#import "MessageCenterViewController.h"
#import "ConsumeRecordViewController.h"

#define TableViewheadHeight Macro_AutoWidth_7p(200)
@interface PeopleMainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, assign) BOOL showBlance; //是否显示悠点值
@end

@implementation PeopleMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setobject];
    
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:rightSwipeGestureRecognizer];
}

-(void)handleSwipes:(UISwipeGestureRecognizer *)paramSender{
    if (paramSender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.tabBarController setSelectedIndex:3];
    }else if(paramSender.direction == UISwipeGestureRecognizerDirectionLeft){
        [self.tabBarController setSelectedIndex:0];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self RequestNetWorkingData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)setobject{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Macro_ScreenWidth, Macro_ScreenHeight - self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    if (@available(iOS 11.0, *)) {
        [self.tableview setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:self.tableview];
    
    self.rowinfoArray = @[
                          @{@"name":@"下载队列",
                            @"imageName":@"tool_icon_order_nor"},
                          @{@"name":@"文件管理",
                            @"imageName":@""},
//                          @{@"name":@"播放记录",
//                            @"imageName":@""},
//                          @{@"name":@"蓝牙",
//                            @"imageName":@"tool_icon_comment_nor"},
//                          @{@"name":@"消息推送开关",
//                            @"imageName":@"pinglun"},
//                          @{@"name":@"省流量开关",
//                            @"imageName":@"tool_icon_address_nor"},
                          @{@"name":@"用户反馈",
                            @"imageName":@"shop"}
                          ];
    self.showBlance = YES;
}
-(void)RequestNetWorkingData{
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendFindByOauth_RequestSuccess:^(PeopleInfoModel *peopleinfo) {
        [BaseMethod hideAllHudsInView:self.view];
        if (peopleinfo.success) {
            self.peopleInfo = peopleinfo;
            [self.tableview reloadData];
        }else{
            [BaseMethod showToast:peopleinfo.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        
    }];
    
    NSString *account = [BaseMethod getUserAccount];
    [[NetWorkingRequest share_MainViewRequest] SendMessageNoticeAccount:account Success:^(BaseModel *data) {
        NSInteger num = [data.data integerValue];
        [self.infoCountLabel setText:[NSString stringWithFormat:@"%ld",(long)num]];
        NSLog(@"data: %@",data);
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark tableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return Macro_AutoWidth_7p(70);
//    }
    return Macro_DefaultRowHeiht;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
            [cell.textLabel setText:@"充值记录"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.textLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
        }else{
            [cell.textLabel setText:@"消费记录"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell.textLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
        }
    }else if(indexPath.section == 1){
        NSDictionary *dic = [self.rowinfoArray objectAtIndex:indexPath.row];
        NSString *cellname = [dic valueForKey:@"name"];
        [cell.textLabel setText:cellname];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
        
        if([cellname isEqualToString:@"蓝牙"]||
           [cellname isEqualToString:@"消息推送开关"]||
           [cellname isEqualToString:@"省流量开关"]){
            UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(70),
                                                                             (Macro_DefaultRowHeiht - Macro_AutoWidth_7p(30))/2.0,
                                                                             Macro_AutoWidth_7p(70),
                                                                             Macro_AutoWidth_7p(30))];
            //[switchBtn setTintColor:ThemeRedColor];
            [switchBtn setOnTintColor:ThemeRedColor];
            [switchBtn addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventAllTouchEvents];
            [cell addSubview:switchBtn];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        [cell.textLabel setText:@"退出登录"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];

    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return TableViewheadHeight ;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return Macro_AutoWidth_7p(70);
    }else{
        return Macro_AutoWidth_7p(10);
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
    return [self getFirstView];
    }else{
        return nil;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(50))];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(10, 10, KWidth - 20, Macro_AutoWidth_7p(40))];
        [btn setBackgroundColor:ThemeRedColor];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(logoutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footview addSubview:btn];
        return footview;
    }
    return nil;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else if (section == 1) {
        return self.rowinfoArray.count;
    }
    return 1;//退出
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            RechargeRecordViewController *myInviVC = [[RechargeRecordViewController alloc] init];
            [myInviVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:myInviVC animated:YES];
        }else{
            ConsumeRecordViewController *VC = [[ConsumeRecordViewController alloc] init];
            [VC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:VC animated:YES];
        }
    
    }else if(indexPath.section == 1){
        NSDictionary *dic =  [self.rowinfoArray objectAtIndex:indexPath.row];
        NSString *rowtitle = [dic valueForKey:@"name"];
        
        if ([rowtitle isEqualToString:@"文件管理"]){
            FileManagerViewController *fileVC = [[FileManagerViewController alloc] init];
            [fileVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:fileVC animated:YES];
        }else if([rowtitle isEqualToString:@"下载队列"]){
            DownRecordViewController  *downLoadVC = [[DownRecordViewController alloc] init];
            [downLoadVC setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:downLoadVC animated:YES];
        }else if([rowtitle isEqualToString:@"播放记录"]){
            [BaseMethod showToast:@"暂不开放" hideAfterSecond:2 inView:self.view];
        }else if ([rowtitle isEqualToString:@"用户反馈"]){
            UserFeedbackViewController *vc = [[UserFeedbackViewController alloc] init];
            [vc setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
    }
}
-(UIView *)getFirstView{
   // NSString *username = @"XXXXX";
    PeopleInfoDataModel *userinfo = self.peopleInfo.data;

    if (self.headView == nil) {
        self.headView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, Macro_ScreenWidth, TableViewheadHeight )];
        [self.headView setBackgroundColor:ThemeRedColor];
    }
    
    //用户头像
    if (self.headimage == nil) {
        self.headimage = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(20),
                                                                       Macro_AutoWidth_7p(35),
                                                                       Macro_AutoWidth_7p(80),
                                                                       Macro_AutoWidth_7p(80))];
        self.headimage.layer.cornerRadius =self.headimage.frame.size.height/2.00;
        self.headimage.layer.borderColor =[UIColor whiteColor].CGColor;
        self.headimage.layer.borderWidth = Macro_AutoWidth_7p(2);
        self.headimage.layer.masksToBounds =YES;
        [self.headimage setAlpha:1 ];
        [self.headView addSubview:self.headimage];
        
        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headImageClick:)];
        tapGesture.numberOfTapsRequired=1;
        [self.headimage addGestureRecognizer:tapGesture];
        [self.headimage setUserInteractionEnabled:YES];
    }
    [self.headimage setImageWithURL:[NSURL URLWithString:userinfo.icon]];
    
    
    if (self.nicknameLabel == nil) {
        self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headimage.frame) + Macro_AutoWidth_7p(10),
                                                                      CGRectGetMaxY(self.headimage.frame) + Macro_AutoWidth_7p(5),
                                                                      Macro_AutoWidth_7p(150),
                                                                      Macro_AutoWidth_7p(20))];
        [self.nicknameLabel setCenter:CGPointMake(self.nicknameLabel.center.x, self.headimage.center.y)];
        [self.nicknameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.nicknameLabel setFont:[UIFont boldSystemFontOfSize:18]];
        
        [self.nicknameLabel setTextColor:[UIColor whiteColor]];
        [self.headView addSubview:self.nicknameLabel];
    }
    [self.nicknameLabel setText:userinfo.userName];
    
    if (self.infoBtn == nil) {
        self.infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.infoBtn setBackgroundImage:[UIImage imageNamed:@"login_message"] forState:UIControlStateNormal];
        [self.infoBtn setFrame:CGRectMake(Macro_AutoWidth_7p(280),
                                          CGRectGetMinY(self.nicknameLabel.frame),
                                          Macro_AutoWidth_7p(30),
                                          Macro_AutoWidth_7p(25))];
        [self.infoBtn addTarget:self action:@selector(infoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:self.infoBtn];
    }
    
    if (self.infoCountLabel == nil) {
        self.infoCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(15),
                                                                        -Macro_AutoWidth_7p(5),
                                                                        Macro_AutoWidth_7p(20),
                                                                        Macro_AutoWidth_7p(15))];
        self.infoCountLabel.layer.cornerRadius = 5;
        [self.infoCountLabel setBackgroundColor:[UIColor orangeColor]];
        self.infoCountLabel.layer.masksToBounds = YES;
        [self.infoCountLabel setTextColor:[UIColor whiteColor]];
        [self.infoCountLabel setFont:[UIFont systemFontOfSize:10]];
        [self.infoCountLabel setTextAlignment:NSTextAlignmentCenter];
        [self.infoBtn addSubview:self.infoCountLabel];
    }
    if (self.RechargeBtn == nil) {
        self.RechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[self.RechargeBtn setBackgroundImage:[UIImage imageNamed:@"login_message"] forState:UIControlStateNormal];
        [self.RechargeBtn setFrame:CGRectMake(CGRectGetMaxX(self.infoBtn.frame) + Macro_AutoWidth_7p(20),
                                          CGRectGetMinY(self.nicknameLabel.frame),
                                          Macro_AutoWidth_7p(50),
                                          Macro_AutoWidth_7p(25))];
        [self.RechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [self.RechargeBtn setTintColor:[UIColor whiteColor]];
        [self.RechargeBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.RechargeBtn setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.5]];
        self.RechargeBtn.layer.cornerRadius = 10;
        [self.RechargeBtn addTarget:self action:@selector(RechargeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.headView addSubview:self.RechargeBtn];
    }
    
    UILabel *tipLabel =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.nicknameLabel.frame),
                                                            CGRectGetMaxY(self.headimage.frame),
                                                            Macro_AutoWidth_7p(100),
                                                            Macro_AutoFont_7p(18))];
    [tipLabel setFont:[UIFont boldSystemFontOfSize:Macro_AutoFont_7p(18)]];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [tipLabel setTextColor:[UIColor whiteColor]];
    [tipLabel setAlpha:1];
    [tipLabel setText:@"悠点余额 :"];
    [self.headView addSubview:tipLabel];
    
    if (self.myscore == nil) {
        self.myscore =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tipLabel.frame) + Macro_AutoWidth_7p(5),
                                                                CGRectGetMinY(tipLabel.frame),
                                                                Macro_AutoWidth_7p(300),
                                                                Macro_AutoWidth_7p(18))];
        [self.myscore setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(18)]];
        [self.myscore setTextAlignment:NSTextAlignmentLeft];
        [self.myscore setTextColor:[UIColor whiteColor]];
        [self.myscore setAlpha:1];
        [self.myscore setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesuture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MyScroreClick)];
        tapGesuture.numberOfTapsRequired = 1;
        [self.myscore addGestureRecognizer:tapGesuture];
        [self.headView addSubview:self.myscore];
    }
    [self.myscore setText:[NSString stringWithFormat:@"%ld",(long)userinfo.balance]];

    
    if (self.searchBar == nil) {
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,
                                                                       CGRectGetMaxY(self.searchBar.frame) + Macro_AutoWidth_7p(20),
                                                                       Macro_AutoWidth_7p(300),
                                                                       Macro_AutoWidth_7p(30))];
        [self.searchBar setCenter:CGPointMake(self.headView.center.x, self.headView.frame.size.height - Macro_AutoWidth_7p(40))];
        [self.searchBar setPlaceholder:@"快速搜索教程，歌曲"];
        self.searchBar.layer.cornerRadius = self.searchBar.frame.size.height/2.0;
        self.searchBar.layer.masksToBounds = YES;
        [self.searchBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:self.searchBar.frame.size]];
        self.searchBar.delegate = self;
        [self.headView addSubview:self.searchBar];
    }
    return self.headView;
}
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)MyScroreClick{
    if (self.showBlance) {
         [self.myscore setText:@"**********"];
        self.showBlance = NO;
    }else{
        PeopleInfoDataModel *userinfo = self.peopleInfo.data;
        [self.myscore setText:[NSString stringWithFormat:@"%ld",(long)userinfo.balance]];
        self.showBlance = YES;
    }
}
-(void)switchValueChange:(id)sender{
    UISwitch *switchbtn = (UISwitch *)sender;
    [switchbtn setOn:!switchbtn.isOn];
    [BaseMethod showToast:@"暂不开放" hideAfterSecond:2 inView:self.view];
}
-(void)RechargeBtnClick:(id)sender{
    RechargeViewController *rechargeVC = [[RechargeViewController alloc] init];
    [rechargeVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:rechargeVC animated:YES];
}
-(UIButton *)GetBtnViewWithTitle:(NSString *)title imageName:(NSString *)imageName{
    UIButton *btnview = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnview setFrame:CGRectMake(0, 0, (Macro_ScreenWidth/2.00), Macro_AutoWidth_7p(70))];
    [btnview setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(30), Macro_AutoWidth_7p(30))];
    [icon setImage:[UIImage imageNamed:imageName]];
    [icon setCenter:CGPointMake(btnview.frame.size.width/2.0, icon.center.y)];
    [btnview addSubview:icon];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + Macro_AutoWidth_7p(5), btnview.frame.size.width, Macro_AutoWidth_7p(20))];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [btnview addSubview:titleLabel];
    [titleLabel setText:title];
    return btnview;
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchPageViewController *searchPageVC = [[SearchPageViewController alloc] init];
    [searchPageVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:searchPageVC animated:YES];
    return NO;
}
#define mark BtnClick
-(void)infoBtnClick:(id)sender{
    MessageCenterViewController *vc = [[MessageCenterViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}
//收藏按钮点击
-(void)firBtnViewClick:(id)sender{
//    CollectionGoodsViewController *collectionvc = [[CollectionGoodsViewController alloc] init];
//    [collectionvc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:collectionvc animated:YES];
}
//优惠券
-(void)secBtnViewClick:(id)sender{
//    CouponViewController *couponvc = [[CouponViewController alloc] init];
//    [couponvc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:couponvc animated:YES];
}
//购物车
-(void)thriBtnViewClick:(id)sender{
//    ShopCartViewController *vc = [[ShopCartViewController alloc] init];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
}
-(void)LoginBtnClick:(id)sender{
    LoginMainViewController *loginVC = [[LoginMainViewController alloc] init];
    BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}
-(void)logoutBtnClick:(id)sender{
    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
    PeopleInfoDataModel *peopledataifno = peopleinfo.data;
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendLogoutMobile:peopledataifno.mobile Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        if (info.success) {
            [BaseMethod DelegateUserInfo];
            [BaseMethod SetUserLogin:NO];
            [self.tabBarController setSelectedIndex:0];
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];

    }];
}
-(void)headImageClick:(id)sender{
    PeopleInfoViewController *peopleInfoVC = [[PeopleInfoViewController alloc] init];
    [peopleInfoVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:peopleInfoVC animated:YES];
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
