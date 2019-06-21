//
//  UserRegisterViewController.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/7.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseViewController.h"

@interface UserRegisterViewController : BaseViewController

@property (nonatomic) int FunctionStype;  //功能类型  1:注册  2，找回
@property (nonatomic, retain) UITextField *moblieTextField;
@property (nonatomic, retain) UITextField *CodetextField;
@property (nonatomic, retain) UITextField *passwordTextField;
@property (nonatomic, retain) UIButton *registerBtn;

@end
