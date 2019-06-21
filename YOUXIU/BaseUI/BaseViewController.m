//
//  ViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/3/20.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, retain) UIButton *keyboardDisDoneBtn;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    if (self.navigationController != nil) {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
//    [self.navigationController.navigationBar setTitleTextAttributes:dict];
//    [self.navigationController.navigationBar setBarTintColor:ThemeRedColor];
}
//-(void)setLeftPopBtn{
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setFrame:CGRectMake(0, 0, 40, 40)];
//    [backButton addTarget:self action:@selector(BackItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
//    [backButton setImage:[UIImage imageNamed:@"Nav_Left_Back_Icon"] forState:UIControlStateNormal];
//    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem=backBarButton;
//
//}
//-(void)setLeftDismissBtn{
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backButton setFrame:CGRectMake(0, 0, 40, 40)];
//    [backButton addTarget:self action:@selector(BackDismissItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
//    [backButton setImage:[UIImage imageNamed:@"Nav_Left_Back_Icon"] forState:UIControlStateNormal];
//    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem=backBarButton;
//}

//-(void)BackItemBtnClick:(id)sender{
//    [self.navigationController popViewControllerAnimated:YES];
//}
/**
 键盘出现时添加done按钮，点击键盘消失
 */
-(void)addKeyBoradDismissWay{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
-(void)keyboardWillShow:(NSNotification *)notic{
    if(self.keyboardDisDoneBtn == nil){
        self.keyboardDisDoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.keyboardDisDoneBtn setFrame:CGRectMake(0, Macro_AutoWidth_7p(40), Macro_ScreenWidth, Macro_ScreenHeight)];
        [self.keyboardDisDoneBtn addTarget:self action:@selector(keyboardDisDoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:self.keyboardDisDoneBtn];
}
-(void)keyboardDisDoneBtnClick:(id)sender{
    [self.keyboardDisDoneBtn removeFromSuperview];
    [self dismissKeyboard];
}
#pragma mark  添加点击view键盘消失方法
-(void)add_Tap_TextFieldKeyBoardDismiss{
    UITapGestureRecognizer *outTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    outTap.numberOfTapsRequired = 1;
    self.view.userInteractionEnabled = YES;
    [self.view addGestureRecognizer:outTap];
}
-(void)dismissKeyboard{
    [self DismissViewKeyBoard:self.view];
    [self DismissViewKeyBoard:self.navigationController.navigationBar];
}
-(void)DismissViewKeyBoard:(UIView *)view{
    for (UIView *subview in view.subviews) {
        if ([subview isKindOfClass:[UITextField class]]||
            [subview isKindOfClass:[UITextView class]]||
            [subview isKindOfClass:[UISearchBar class]]) {
            [subview resignFirstResponder];
        }else{
            if (subview.subviews.count > 0) {
                [self DismissViewKeyBoard:subview];
            }
        }
    }
}
#pragma mark 修改返回按钮为自定义
-(void)setNavgationBackButton{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 40, 40)];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
    [backButton setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backBarButton;
}
-(void)setNavBackBtn_DisVC{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 40, 40)];
    [backButton addTarget:self action:@selector(VCDis) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
    [backButton setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backBarButton;
}
-(void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)VCDis{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//适配ios11 tableview section高度变化
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
