//
//  UserRegisterViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/7.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "NetWorkingRequest.h"
@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackButton];
    [self setUI];
    [self add_Tap_TextFieldKeyBoardDismiss];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
}
-(void)setUI{
    if (self.moblieTextField ==nil) {
        
        self.moblieTextField =[[UITextField alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(20),
                                                                           Macro_AutoWidth_7p(100),
                                                                           Macro_AutoWidth_7p(374),
                                                                           Macro_AutoWidth_7p(50))];
        [self.moblieTextField setFont:[UIFont systemFontOfSize:14]];
        [self.moblieTextField addLine];
        [self.moblieTextField addVerificationCode];//验证码
        self.moblieTextField.tag = self.FunctionStype;
        self.moblieTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName: ThemeRedColor}];
        [self.view addSubview:self.moblieTextField];
    }
    
    if (self.CodetextField ==nil) {
        self.CodetextField =[[UITextField alloc]initWithFrame:CGRectMake(self.moblieTextField.frame.origin.x,
                                                                         CGRectGetMaxY(self.moblieTextField.frame) + Macro_AutoWidth_7p(10),
                                                                         Macro_AutoWidth_7p(374),
                                                                         Macro_AutoWidth_7p(50))];
        [self.CodetextField setFont:self.moblieTextField.font];
        [self.CodetextField addLine];
        self.CodetextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入验证码" attributes:@{NSForegroundColorAttributeName: ThemeRedColor}];
        [self.view addSubview:self.CodetextField];
    }
    
    if (self.passwordTextField ==nil) {
        self.passwordTextField =[[UITextField alloc]initWithFrame:CGRectMake(self.moblieTextField.frame.origin.x,
                                                                             CGRectGetMaxY(self.CodetextField.frame) + Macro_AutoWidth_7p(10),
                                                                             Macro_AutoWidth_7p(374),
                                                                             Macro_AutoWidth_7p(50))];
        [self.passwordTextField setFont:self.CodetextField.font];
        [self.passwordTextField addLine];
        [self.passwordTextField setSecureTextEntry:YES];
        if (self.FunctionStype==2) {
            //忘记密码进来
            self.title = @"重置密码";
            self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入新密码" attributes:@{NSForegroundColorAttributeName: ThemeRedColor}];
        }else{
            self.title = @"注册";
            self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入密码" attributes:@{NSForegroundColorAttributeName: ThemeRedColor}];
        }
        [self.view addSubview:self.passwordTextField];
    }
    
    if (self.registerBtn ==nil){
        self.registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        if (self.FunctionStype==2) {
            [self.registerBtn setTitle:@"确定" forState:UIControlStateNormal];
        }else{
            [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        }
        [self.registerBtn setTitleColor:MacroDV_ThemeColor_white forState:UIControlStateNormal];
        self.registerBtn.layer.cornerRadius = Macro_AutoWidth_7p(10);
        self.registerBtn.layer.borderColor = ThemeRedColor.CGColor;
        self.registerBtn.layer.borderWidth = Macro_AutoWidth_7p(1);
        [self.registerBtn setBackgroundColor:ThemeRedColor];
        [self.registerBtn setFrame:CGRectMake(self.moblieTextField.frame.origin.x,
                                              Macro_AutoWidth_7p(300) + CGRectGetMaxY(self.passwordTextField.frame),
                                              Macro_AutoWidth_7p(374),
                                              Macro_AutoWidth_7p(50))];
        [self.registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.registerBtn];
    }
    
}

-(void)registerBtnClick:(id)sender{
    BOOL canReg=YES;
    NSString *errorInfo;
    if ([self.CodetextField.text isEqualToString:@""]||self.CodetextField.text == nil) {
        errorInfo=@"验证码不能为空";
        canReg=NO;
    }else if([self.moblieTextField.text isEqualToString:@""]||self.moblieTextField.text == nil){
        errorInfo =@"手机号不能为空";
        canReg=NO;
        
    }else if ([self.passwordTextField.text isEqualToString:@""]||self.passwordTextField.text == nil){
        errorInfo =@"密码不能为空";
        canReg=NO;
        
    }
    if(canReg){
        if (self.FunctionStype==1) {//注册
            [BaseMethod showLoading:self.view];
            [[NetWorkingRequest share_MainViewRequest] SendMobileCaptcha_doRegister_Request:self.moblieTextField.text step:@"2" password:self.passwordTextField.text validate:self.CodetextField.text Success:^(BaseModel *info) {
                [BaseMethod hideAllHudsInView:self.view];
                [BaseMethod showToastOnWindowWithString:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime];
                if (info.success){
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }];
        }else{
            //找回密码
            [[NetWorkingRequest share_MainViewRequest] SendMobileCaptcha_doForgetPwd_Request:self.moblieTextField.text step:@"2" password:self.passwordTextField.text validate:self.CodetextField.text Success:^(BaseModel *info) {
                [BaseMethod hideAllHudsInView:self.view];
                [BaseMethod showToastOnWindowWithString:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime];
                if (info.success) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(NSError *error) {
                [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];

            }];
        }
        
    }else{
        [BaseMethod showToast:errorInfo hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
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
