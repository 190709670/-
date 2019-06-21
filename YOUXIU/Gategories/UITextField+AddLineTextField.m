//
//  UITextField+AddLineTextField.m
//  TheGenuine
//
//  Created by lihui on 16/4/2.
//  Copyright © 2016年 com.TheGenuine. All rights reserved.
//

#import "UITextField+AddLineTextField.h"
#import "RegexKit.h"
#import "NetWorkingRequest.h"
@implementation UITextField (AddLineTextField)

-(void)addLine{
    UIImageView *imageline =[[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                          self.frame.size.height-Macro_AutoWidth_7p(1),
                                                                          self.frame.size.width,
                                                                          0.5)];
    [imageline setBackgroundColor:[UIColor grayColor]];
    imageline.layer.cornerRadius =Macro_AutoWidth_7p(0.5);
    [self addSubview:imageline];
    self.tintColor= ThemeRedColor;
}
-(void)addVerificationCode{
    UIButton *verificationCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    verificationCodeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [verificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verificationCodeBtn setBackgroundColor:[UIColor clearColor]];
    [verificationCodeBtn setTitleColor:ThemeRedColor   forState:UIControlStateNormal];
    
    [verificationCodeBtn setFrame:CGRectMake(self.frame.size.width - Macro_AutoWidth_7p(100),
                                             Macro_AutoWidth_7p(5),
                                             Macro_AutoWidth_7p(100),
                                             self.frame.size.height - Macro_AutoWidth_7p(10))];
    verificationCodeBtn.titleLabel.font =[UIFont systemFontOfSize:Macro_AutoFont_7p(13)];
    verificationCodeBtn.layer.borderWidth = 1;
    
    verificationCodeBtn.layer.borderColor = ThemeRedColor.CGColor;
    verificationCodeBtn.layer.cornerRadius = Macro_AutoWidth_7p(10);
    [verificationCodeBtn addTarget:self action:@selector(sendAuth:) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = verificationCodeBtn;
    [self setRightViewMode:UITextFieldViewModeAlways];
    
    NSLog(@"self.tag: %ld",(long)self.tag);
}

-(void)verificationCodeBtnClick:(id)sender{
    UIButton *btn =(UIButton *)sender;
    if (self.text.length == 11 && [RegexKit validateMobile:self.text]) {
        btn.userInteractionEnabled = NO;
        __block int timeout=60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    btn.backgroundColor = MacroDV_ThemeColor_white;
                    [btn setTitle:@"重发验证码" forState:UIControlStateNormal];
                });
                btn.userInteractionEnabled = YES;
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    btn.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
                    [btn setTitle:[NSString stringWithFormat:@"重发(%ds)",timeout] forState:UIControlStateNormal];
                });
                timeout--;
                
            }
        });
        dispatch_resume(_timer);
    }else{
        [BaseMethod showToast:@"请正确输入手机号码" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
    }
    
}
-(void)sendAuth:(id)sender{
    if (self.tag == 1) {
        //注册发送验证码
        [[NetWorkingRequest share_MainViewRequest] SendMobileCaptcha_doRegister_Request:self.text step:@"1" password:nil validate:nil Success:^(BaseModel *info) {
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
            if (info.success) {
                [self verificationCodeBtnClick:sender];
            }
        } failure:^(NSError *error) {
            [BaseMethod showToast:[error description] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
        }];
    }else if(self.tag == 2){
        //密码找回发送验证码，需验证用户是否存在
        [[NetWorkingRequest share_MainViewRequest] SendMobileCaptcha_doForgetPwd_Request:self.text step:@"1" password:nil validate:nil Success:^(BaseModel *info) {
            if (info.success) {
                [self verificationCodeBtnClick:sender];
            }
        } failure:^(NSError *error) {
            [BaseMethod showToast:[error description] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
        }];
    }else if(self.tag == 3){//短信登录
        [[NetWorkingRequest share_MainViewRequest] SendLoginSendLoginValidate:self.text Success:^(BaseModel *info) {
            if (info.success) {
                [self verificationCodeBtnClick:sender];
            }
        } failure:^(NSError *error) {
            [BaseMethod showToast:[error description] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
        }];
    }
    
}

@end
