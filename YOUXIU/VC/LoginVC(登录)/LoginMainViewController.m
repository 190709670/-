//
//  LoginMainViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/5.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "LoginMainViewController.h"
#import "UserRegisterViewController.h"
#import "NetWorkingRequest.h"
@interface LoginMainViewController ()
@property (nonatomic, retain) UIImageView *logoImageView;
@property (nonatomic, retain) UITextField *userAccountTextField;
@property (nonatomic, retain) UITextField *userPassWordTextField;
@property (nonatomic, retain) UITextField *userMobileTextField;
@property (nonatomic, retain) UITextField *sortmessageTextField;
@property (nonatomic, retain) UIButton *LoginBtn;
@property (nonatomic, retain) UIButton *WXLoginBtn; //短信登录
@property (nonatomic, retain) UIButton *registerBtn;
@property (nonatomic, retain) UIButton *rememberBtn;
@property (nonatomic, retain) UIButton *forgetBtn;
@property (nonatomic, assign) BOOL isPassWordLogin;
@property (nonatomic, retain) UILabel *rememberLabel;
@end

@implementation LoginMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"登录";
  
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self add_Tap_TextFieldKeyBoardDismiss];
    [self setNavBackBtn_DisVC];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.userPassWordTextField setText:@""];
    BOOL remeberusername = [[[NSUserDefaults standardUserDefaults] valueForKey:REMEMBERUSERNAME] boolValue];
    if (!remeberusername) {
        [self.userAccountTextField setText:@""];
    }
}
-(void)setObject{
    self.isPassWordLogin = YES;
    self.logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainPage_Logo"]];
    [self.logoImageView sizeToFit];
    [self.logoImageView setCenter:CGPointMake(self.view.center.x, Macro_AutoHeight_7p(100))];
    
    [self.view addSubview:self.logoImageView];
    
    self.userAccountTextField = [[UITextField alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(40),
                                                                              CGRectGetMaxY(self.logoImageView.frame) + Macro_AutoWidth_7p(85),
                                                                              Macro_AutoWidth_7p(334),
                                                                              Macro_AutoWidth_7p(50))];
    [self.userAccountTextField setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(14)]];
    [self.userAccountTextField setPlaceholder:@"请输入账号"];
    [self.userAccountTextField addLine];
    
    UIImageView *userAccountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"login_Account_iphone"]];
    self.userAccountTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(30), self.userAccountTextField.frame.size.height)];
    [self.userAccountTextField.leftView addSubview:userAccountImageView];
    userAccountImageView.center = CGPointMake(userAccountImageView.center.x, self.userAccountTextField.frame.size.height/2.0);
    self.userAccountTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userAccountTextField];
    
    self.userPassWordTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userAccountTextField.frame),
                                                                               CGRectGetMaxY(self.userAccountTextField.frame) + Macro_AutoWidth_7p(20),
                                                                               self.userAccountTextField.frame.size.width,
                                                                               self.userAccountTextField.frame.size.height)];
    [self.userPassWordTextField setPlaceholder:@"请输入密码"];
    self.userPassWordTextField.font = self.userAccountTextField.font;
    [self.userPassWordTextField addLine];
    [self.userPassWordTextField setSecureTextEntry:YES];
    
    UIImageView *passImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    self.userPassWordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(30), self.userPassWordTextField.frame.size.height)];
    [self.userPassWordTextField.leftView addSubview:passImageView];
    passImageView.center = CGPointMake(passImageView.center.x, self.userPassWordTextField.frame.size.height/2.0);
    self.userPassWordTextField.leftViewMode = UITextFieldViewModeAlways;

    UIButton *showbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [showbtn setImage:[UIImage imageNamed:@"eye_close"] forState:UIControlStateNormal];
    [showbtn setFrame:CGRectMake(0, 0, 20, 20)];
    [showbtn addTarget:self action:@selector(showBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userPassWordTextField.rightView = showbtn;
    self.userPassWordTextField.rightViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userPassWordTextField];
    
    self.userMobileTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userAccountTextField.frame),
                                                                             CGRectGetMinY(self.userAccountTextField.frame),
                                                                             self.userAccountTextField.frame.size.width,
                                                                             self.userAccountTextField.frame.size.height)];
    [self.userMobileTextField addVerificationCode];
    [self.userMobileTextField setPlaceholder:@"请输入手机号"];
    self.userMobileTextField.font = self.userAccountTextField.font;
    self.userMobileTextField.tag = 3;
     [self.userMobileTextField addLine];
    UIImageView *userMobileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"login_Account_iphone"]];
    self.userMobileTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(30), self.userAccountTextField.frame.size.height)];
    [self.userMobileTextField.leftView addSubview:userMobileImageView];
    userMobileImageView.center = CGPointMake(userMobileImageView.center.x, self.userAccountTextField.frame.size.height/2.0);
    self.userMobileTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.userMobileTextField];
    [self.userMobileTextField setHidden:YES];
    
    self.sortmessageTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.userAccountTextField.frame),
                                                                              CGRectGetMaxY(self.userAccountTextField.frame) + Macro_AutoWidth_7p(20),
                                                                              self.userAccountTextField.frame.size.width,
                                                                              self.userAccountTextField.frame.size.height)];
    [self.sortmessageTextField setPlaceholder:@"短信验证码"];
    self.sortmessageTextField.font = self.userAccountTextField.font;
    [self.sortmessageTextField addLine];
    UIImageView *sortmessageImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    self.sortmessageTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(30), self.sortmessageTextField.frame.size.height)];
    [self.sortmessageTextField.leftView addSubview:sortmessageImageView];
    sortmessageImageView.center = CGPointMake(passImageView.center.x, self.sortmessageTextField.frame.size.height/2.0);
    self.sortmessageTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.sortmessageTextField];
    [self.sortmessageTextField setHidden:YES];
    
    self.LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.LoginBtn setFrame:CGRectMake(self.userAccountTextField.frame.origin.x,
                                       CGRectGetMaxY(self.userPassWordTextField.frame) + Macro_AutoWidth_7p(60),
                                       self.userAccountTextField.frame.size.width,
                                       self.userAccountTextField.frame.size.height)];
    [self.LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.LoginBtn setTitleColor:MacroDV_ThemeColor_white forState:UIControlStateNormal];
    self.LoginBtn.layer.borderWidth = 1;
    self.LoginBtn.layer.borderColor = ThemeRedColor.CGColor;
    self.LoginBtn.layer.cornerRadius = self.LoginBtn.frame.size.height/10.0;
    [self.LoginBtn setBackgroundColor:ThemeRedColor];
    [self.LoginBtn.titleLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(18)]];
    [self.LoginBtn addTarget:self action:@selector(LoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.LoginBtn];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setFrame:CGRectMake(-1,
                                          self.view.frame.size.height - self.LoginBtn.frame.size.height+1 - CGRectGetMaxY(self.navigationController.navigationBar.frame) ,
                                          self.view.frame.size.width+2,
                                          self.LoginBtn.frame.size.height)];
    [self.registerBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    self.registerBtn.layer.borderWidth = 0.5;
    self.registerBtn.layer.borderColor = [UIColor grayColor].CGColor;
    [self.registerBtn.titleLabel setFont:self.LoginBtn.titleLabel.font];
    
    [self.registerBtn addTarget:self action:@selector(RegisterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.bottom.equalTo(self.view.mas_bottom);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(self.LoginBtn.mas_height) ;
    }];
    
    BOOL rememberLogin = [[[NSUserDefaults standardUserDefaults] valueForKey:UserRememberLogin] boolValue];
    self.rememberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rememberBtn setFrame:CGRectMake(CGRectGetMinX(self.userPassWordTextField.frame) ,
                                        CGRectGetMaxY(self.userPassWordTextField.frame) + Macro_AutoWidth_7p(10),
                                        Macro_AutoWidth_7p(15),
                                        Macro_AutoWidth_7p(15))];
    [self.rememberBtn setBackgroundImage:[UIImage imageNamed:rememberLogin?@"rememberUserAccount_select":@"rememberUserAccount_Noselect"] forState:UIControlStateNormal];
    [self.rememberBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    [self.rememberBtn.titleLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(14)]];
    [self.rememberBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.rememberBtn addTarget:self action:@selector(rememberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rememberBtn];
    
    self.rememberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.rememberBtn.frame) + Macro_AutoWidth_7p(10),
                                                                       CGRectGetMinY(self.rememberBtn.frame),
                                                                       Macro_AutoWidth_7p(80),
                                                                       Macro_AutoWidth_7p(15))];
    [self.rememberLabel setText:@"记住用户名"];
    [self.rememberLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(14)]];
    [self.rememberLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.rememberLabel];

    self.forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetBtn setFrame:CGRectMake(CGRectGetMaxX(self.userPassWordTextField.frame) - Macro_AutoWidth_7p(100),
                                        CGRectGetMaxY(self.userPassWordTextField.frame) + Macro_AutoWidth_7p(5),
                                        Macro_AutoWidth_7p(100),
                                        Macro_AutoWidth_7p(30))];
    [self.forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [self.forgetBtn setTitleColor:ThemeRedColor forState:UIControlStateNormal];
    [self.forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(14)]];
    [self.forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.forgetBtn addTarget:self action:@selector(forgetBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgetBtn];
    
    self.WXLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.WXLoginBtn setFrame:CGRectMake(self.LoginBtn.frame.origin.x,
                                         CGRectGetMaxY(self.LoginBtn.frame) + Macro_AutoWidth_7p(15),
                                         CGRectGetWidth(self.LoginBtn.frame),
                                         self.LoginBtn.frame.size.height)];
    [self.WXLoginBtn setTitle:@"短信登录" forState:UIControlStateNormal];
    [self.WXLoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.WXLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(18)]];
   // [self.WXLoginBtn setImage:[UIImage imageNamed:@"login_button_WX"] forState:UIControlStateNormal];
    [self.WXLoginBtn setBackgroundColor:[UIColor clearColor]];
    [self.WXLoginBtn addTarget:self action:@selector(WXLoginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.WXLoginBtn];
    
//    UILabel *wxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.WXLoginBtn.frame) + Macro_AutoWidth_7p(5), Macro_AutoWidth_7p(200), Macro_AutoWidth_7p(20))];
//    [wxLabel setText:@"使用微信登录"];
//    [wxLabel setTextColor:[UIColor grayColor]];
//    [wxLabel setTextAlignment:NSTextAlignmentCenter];
//    [wxLabel setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(13)]];
//    [wxLabel setCenter:CGPointMake(self.WXLoginBtn.center.x, wxLabel.center.y)];
//    [self.view addSubview:wxLabel];
}


#pragma mark BtnClick
-(void)rememberBtnClick:(id)sender{
  BOOL rememberLogin =  [[[NSUserDefaults standardUserDefaults] valueForKey:UserRememberLogin] boolValue];
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:!rememberLogin] forKey:UserRememberLogin];
    [self.rememberBtn setBackgroundImage:[UIImage imageNamed:!rememberLogin?@"rememberUserAccount_select":@"rememberUserAccount_Noselect"] forState:UIControlStateNormal];
}
-(void)showBtnClick:(id)sender{
    [self.userPassWordTextField setSecureTextEntry:!self.userPassWordTextField.isSecureTextEntry];
    UIButton *btn = (UIButton *)self.userPassWordTextField.rightView;
    [btn setImage:[UIImage imageNamed:self.userPassWordTextField.isSecureTextEntry?@"eye_close":@"login_eye"] forState:UIControlStateNormal];
}
-(void)LoginBtnClick:(id)sender{
    if (self.isPassWordLogin) { //账号密码登录
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendUserLogin_login_Request:self.userAccountTextField.text password:self.userPassWordTextField.text Success:^(PeopleInfoModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            if (info.success) {
                //测试，后面删除
                if ([self.delegate respondsToSelector:@selector(LoginSuccess:)]) {
                    [self.delegate LoginSuccess:YES];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }];
    }else{ //短信登录
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SendLoginLoginByValidate:self.userMobileTextField.text validate:self.sortmessageTextField.text Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            if (info.success) {
                //测试，后面删除
                if ([self.delegate respondsToSelector:@selector(LoginSuccess:)]) {
                    [self.delegate LoginSuccess:YES];
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }];
    }

}

-(void)WXLoginBtnClick:(id)sender{
    self.isPassWordLogin = !self.isPassWordLogin;
    if (self.isPassWordLogin) {
        [self.sortmessageTextField setHidden:YES];
        [self.userMobileTextField setHidden:YES];
        
        [self.userAccountTextField setHidden:NO];
        [self.userPassWordTextField setHidden:NO];
        [self.WXLoginBtn setTitle:@"短信登录" forState:UIControlStateNormal];
        [self.rememberBtn setHidden:NO];
        [self.rememberLabel setHidden:NO];
        [self.forgetBtn setHidden:NO];
    }else{
        [self.userMobileTextField setHidden:NO];
        [self.sortmessageTextField setHidden:NO];
        
        [self.userAccountTextField setHidden:YES];
        [self.userPassWordTextField setHidden:YES];
        [self.WXLoginBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [self.rememberBtn setHidden:YES];
        [self.rememberLabel setHidden:YES];
        [self.forgetBtn setHidden:YES];
    }
}

-(void)RegisterBtnClick:(id)sender{
    UserRegisterViewController *registerVC = [[UserRegisterViewController alloc] init];
    registerVC.FunctionStype = 1;
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)forgetBtnBtnClick:(id)sneder{
    UserRegisterViewController *registerVC = [[UserRegisterViewController alloc] init];
    registerVC.FunctionStype = 2;
    [self.navigationController pushViewController:registerVC animated:YES];
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
