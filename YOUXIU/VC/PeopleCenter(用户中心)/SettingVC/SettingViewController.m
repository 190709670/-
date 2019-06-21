//
//  SettingViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/8/24.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "SettingViewController.h"
#import "NetWorkingRequest.h"
#import "AlertUserPassWordViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *RowInfoArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"设置";
    [self setNavgationBackButton];
    
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)setObject{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Macro_ScreenWidth, Macro_ScreenHeight - 64 - Macro_AutoWidth_7p(60)) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    if(@available(iOS 11,*)){
        [self.mainTableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    [self.view addSubview:self.mainTableView];
    [self.view setBackgroundColor:self.mainTableView.backgroundColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(Macro_AutoWidth_7p(15), Macro_ScreenHeight - 64 - Macro_AutoWidth_7p(60), Macro_ScreenWidth - Macro_AutoWidth_7p(30), Macro_AutoWidth_7p(50))];
    [btn setBackgroundColor:ThemeRedColor];
    btn.layer.cornerRadius = Macro_AutoWidth_7p(5);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.RowInfoArray = [NSMutableArray arrayWithArray:@[
                   @{
                       @"title":@"关于",
                       @"content":[NSString stringWithFormat:@"Ver %@",app_Version],
                       @"icon":@"about"
                     },
                   @{
                       @"title":@"密码修改",
                       @"content":@"",
                       @"icon":@"alertpasw"
                       }
                   ]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"KCell"];
    if (indexPath.section == 0) {
        NSDictionary *dic = [self.RowInfoArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:[dic valueForKey:@"title"]];
        UIImage *icon =[UIImage imageNamed:[dic valueForKey:@"icon"]];
        [cell.detailTextLabel setText:[dic valueForKey:@"content"]];
        CGSize itemSize = CGSizeMake(Macro_AutoWidth_7p(25), Macro_AutoWidth_7p(25));
        UIGraphicsBeginImageContextWithOptions(itemSize, NO ,0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [icon drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [cell.textLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
        [cell.detailTextLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        [cell.textLabel setText:@"退出登录"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(15)]];
    }
   
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.RowInfoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(50);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if(indexPath.section == 0 && indexPath.row == 1){
        AlertUserPassWordViewController *vc = [[AlertUserPassWordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)btnClick:(id)sender{
    //退出
//    [BaseMethod showLoadingWithText:@"正在退出" inView:self.view];
//    [[NetWorkingRequest share_MainViewRequest] SendUserLogin_loginout_Request:((PeopleInfoDataModel *)[BaseMethod getUserInfo].data).username Success:^(BaseModel *info) {
//        [BaseMethod hideAllHudsInView:self.view];
//        [self.tabBarController setSelectedIndex:0];
//    } failure:^(NSError *error) {
//        [BaseMethod hideAllHudsInView:self.view];
//        [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
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
