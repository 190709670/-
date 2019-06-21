//
//  AlertUserPassWordViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/9/10.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "AlertUserPassWordViewController.h"
#import "NetWorkingRequest.h"

@interface AlertUserPassWordViewController ()
@property (nonatomic, strong) UITextField *currentPassTextField;
@property (nonatomic, strong) UITextField *NewPassTextField;
@property (nonatomic, strong) UITextField *NewPassAgainTextField;
@end

@implementation AlertUserPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改密码";
    [self setNavgationBackButton];
    [self add_Tap_TextFieldKeyBoardDismiss];
    [self setObject];
}
-(void)setObject{
    UILabel *currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(15), Macro_AutoWidth_7p(20), Macro_AutoWidth_7p(110), Macro_AutoWidth_7p(40))];
    [currentLabel setText:@"当前密码"];
    
    self.currentPassTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(currentLabel.frame) + Macro_AutoWidth_7p(15), CGRectGetMinY(currentLabel.frame),  Macro_ScreenWidth - (CGRectGetMaxX(currentLabel.frame) + Macro_AutoWidth_7p(30)), Macro_AutoWidth_7p(40))];
    self.currentPassTextField.layer.cornerRadius = Macro_AutoWidth_7p(10);
    [self.currentPassTextField setBackgroundColor:Macro_UIColorFromRGB(0xd2d2d2)];

    
    UILabel *NewPassLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(15),CGRectGetMaxY(currentLabel.frame) + Macro_AutoWidth_7p(10),currentLabel.frame.size.width, Macro_AutoWidth_7p(40))];
    [NewPassLabel setText:@"新密码"];
    
    self.NewPassTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(currentLabel.frame) + Macro_AutoWidth_7p(15), CGRectGetMinY(NewPassLabel.frame), self.currentPassTextField.frame.size.width, Macro_AutoWidth_7p(40))];
    self.NewPassTextField.layer.cornerRadius = self.currentPassTextField.layer.cornerRadius;
    [self.NewPassTextField setBackgroundColor:self.currentPassTextField.backgroundColor];
    
    UILabel *NewPassAgainLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(15),CGRectGetMaxY(NewPassLabel.frame) + Macro_AutoWidth_7p(10),currentLabel.frame.size.width, Macro_AutoWidth_7p(40))];
    [NewPassAgainLabel setText:@"确认新密码"];
    
    self.NewPassAgainTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(currentLabel.frame) + Macro_AutoWidth_7p(15), CGRectGetMinY(NewPassAgainLabel.frame), self.currentPassTextField.frame.size.width, Macro_AutoWidth_7p(40))];
    self.NewPassAgainTextField.layer.cornerRadius = self.currentPassTextField.layer.cornerRadius;
    [self.NewPassAgainTextField setBackgroundColor:self.currentPassTextField.backgroundColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(currentLabel.frame.origin.x, CGRectGetMaxY(self.NewPassAgainTextField.frame) + Macro_AutoWidth_7p(20), Macro_ScreenWidth - Macro_AutoWidth_7p(30), Macro_AutoWidth_7p(40))];
    btn.layer.cornerRadius = Macro_AutoWidth_7p(5);
    [btn setBackgroundColor:ThemeRedColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:currentLabel];
    [self.view addSubview:self.currentPassTextField];
    [self.view addSubview:NewPassLabel];
    [self.view addSubview:self.NewPassTextField];
    [self.view addSubview:NewPassAgainLabel];
    [self.view addSubview:self.NewPassAgainTextField];
    [self.view addSubview:btn];
}
-(void)btnClick:(id)sender{
    if (self.currentPassTextField.text.length <=0 ||
        self.NewPassTextField.text.length <= 0||
        self.NewPassAgainTextField.text.length <= 0){
        [BaseMethod showToast:@"不允许为空" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        return;
    }
    
    if (![self.NewPassTextField.text isEqualToString:self.NewPassAgainTextField.text]){
        [BaseMethod showToast:@"两次新密码输入不一致" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        return;
    }
//    [BaseMethod showLoading:self.view];
//    [[NetWorkingRequest share_MainViewRequest] SendMemberDoEditPwd:self.currentPassTextField.text password:self.NewPassAgainTextField.text Success:^(BaseModel *info) {
//        [BaseMethod hideAllHudsInView:self.view];
//        [BaseMethod showToastOnWindowWithString:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        if (info.success) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    } failure:^(NSError *error) {
//        [BaseMethod hideAllHudsInView:self.view];
//        [BaseMethod showToastOnWindowWithString:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime];
//
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
