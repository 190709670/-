//
//  PeopleInfoViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "PeopleInfoViewController.h"
#import "RegexKit.h"
#import "UIImageView+AFNetworking.h"
#import "NetWorkingRequest.h"
#import "AlertUserPassWordViewController.h"
@interface PeopleInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) NSString *headImageUrl;
@end

@implementation PeopleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人资料";
    [self setNavgationBackButton];

    [self setObject];
    [self setUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
-(void)setObject{
    self.haveAlert=NO;
    self.peopleinfo = [BaseMethod getUserInfo];

}
-(void)setUI{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       Macro_ScreenWidth,
                                                                       self.view.frame.size.height - 64 -Macro_AutoWidth_7p(50)) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    
    self.btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn setFrame:CGRectMake(0,
                                  self.view.frame.size.height - Macro_AutoWidth_7p(50) - 64,
                                  Macro_ScreenWidth,
                                  Macro_AutoWidth_7p(50))];
    [self.btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor lightGrayColor]];
    [self.btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
}
#pragma mark tableviewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Macro_AutoWidth_7p(10);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return Macro_AutoWidth_7p(100);
    }else{
        return Macro_DefaultRowHeiht;
    }
}
#pragma mark tableviewdelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell =@"KCell";
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
    CGFloat x=Macro_AutoWidth_7p(15);
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(x,
                                                              Macro_AutoWidth_7p(5),
                                                              Macro_AutoWidth_7p(140),
                                                              Macro_AutoWidth_7p(40))];
    [label setFont:[UIFont systemFontOfSize:Macro_AutoFont_7p(14)]];
    
    CGFloat height = [self tableView:self.mainTableView heightForRowAtIndexPath:indexPath];
    [label setCenter:CGPointMake(label.center.x, height/2.0)];
    cell.accessoryType = UITableViewCellAccessoryNone;
    switch (indexPath.row) {
        case 0:
        {
            
            [label setText:@"头像"];
            
            self.headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(Macro_AutoWidth_7p(300),
                                                                             Macro_AutoWidth_7p(5), Macro_AutoWidth_7p(90), Macro_AutoWidth_7p(90))];
            self.headImageView.layer.cornerRadius=self.headImageView.frame.size.height/2.0;
            self.headImageView.layer.masksToBounds=YES;
            self.headImageView.layer.borderColor=ThemeRedColor.CGColor;
            self.headImageView.layer.borderWidth=1;
            
        
            PeopleInfoDataModel *datainfo = self.peopleinfo.data;
            NSURL *url =[NSURL URLWithString:datainfo.icon];
            [self.headImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"head"]];
            
            [cell addSubview:label];
            [cell addSubview:self.headImageView];
        }
            break;
        case 1:
        {
            
            [label setText:@"会员账号"];
            
            self.accountLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame),
                                                                        0,
                                                                        Macro_ScreenWidth - CGRectGetMaxX(label.frame)-Macro_AutoWidth_7p(10),
                                                                        label.frame.size.height)];
            self.accountLabel.textAlignment =NSTextAlignmentRight;
            [self.accountLabel setFont:label.font];
            [self.accountLabel setCenter:CGPointMake(self.accountLabel.center.x, label.center.y)];
            
            PeopleInfoDataModel *datainfo = self.peopleinfo.data;
            [self.accountLabel setText:datainfo.mobile];
            [cell addSubview:label];
            [cell addSubview:self.accountLabel];
        }
            break;
        case 2:
        {
            
            [label setText:@"昵称修改"];
            
            self.nickNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame),
                                                                         0,
                                                                         Macro_ScreenWidth - CGRectGetMaxX(label.frame)-Macro_AutoWidth_7p(10),
                                                                         label.frame.size.height)];
            self.nickNameLabel.textAlignment =NSTextAlignmentRight;
            PeopleInfoDataModel *datainfo = self.peopleinfo.data;
            [self.nickNameLabel setText:datainfo.userName];
            [self.nickNameLabel setFont:label.font];
            [self.nickNameLabel setCenter:CGPointMake(self.nickNameLabel.center.x, label.center.y)];
            
            [cell addSubview:label];
            [cell addSubview:self.nickNameLabel];
        }
            break;
        case 3:
        {
            [label setText:@"性别"];
            
            self.sexLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(label.frame),
                                                                    0,
                                                                    Macro_ScreenWidth - CGRectGetMaxX(label.frame)-Macro_AutoWidth_7p(10),
                                                                    label.frame.size.height)];
            self.sexLabel.textAlignment =NSTextAlignmentRight;
            PeopleInfoDataModel *datainfo = self.peopleinfo.data;
            NSString *sexString = [datainfo.sex isEqualToString:@"1"]?@"男":@"女";
            [self.sexLabel setText:sexString];
            [self.sexLabel setFont:label.font];
            [self.sexLabel setCenter:CGPointMake(self.sexLabel.center.x, label.center.y)];
            [cell addSubview:label];
            [cell addSubview:self.sexLabel];
        }
            break;
            
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self action_pic];
        }
            break;
        case 1:
        {

        }
            break;
        case 2:
        {
            [self showAlertView:@"修改昵称" message:@"" tag:witchalert_nickname];
        }
            break;
        case 3:
        {
            UIActionSheet *actionSheet =[[UIActionSheet alloc]initWithTitle:@"性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            actionSheet.tag=witchaction_sex;
            [actionSheet showInView:self.view];
        }
            break;
  
        default:
            break;
    }
}

#pragma mark alertview 修改昵称，email
-(void)showAlertView:(NSString *)title message:(NSString *)message tag:(int)tag{
    UIAlertView *alertview =[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertview.alertViewStyle =UIAlertViewStylePlainTextInput;
    [alertview show];
    alertview.tag=tag;
    alertview =nil;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    UITextField *nicknameTextField =[alertView textFieldAtIndex:0];
    if (buttonIndex==1) {
        if (alertView.tag ==witchalert_nickname) {
            [self.nickNameLabel setText:nicknameTextField.text];
        }
        self.haveAlert=YES;
    }
    
}

#pragma mark 头像选择
-(void)action_pic{
    UIActionSheet *actionSheet =[[UIActionSheet alloc]initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];
    actionSheet.tag=witchaction_headimage;
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==witchaction_sex){
        //选择性别
        switch (buttonIndex) {
            case 0:
            {
                if (![self.sexLabel.text isEqualToString:@"男"]) {
                    [self.sexLabel setText:@"男"];
                    self.haveAlert=YES;
                }
                
            }
                break;
            case 1:
            {
                if (![self.sexLabel.text isEqualToString:@"女"]) {
                    [self.sexLabel setText:@"女"];
                    self.haveAlert=YES;
                }
            }
                break;
            default:
                break;
        }
        
        
    }else if(actionSheet.tag==witchaction_headimage){
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.allowsEditing=YES;
        switch (buttonIndex)
        {
            case 0:
            {
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
                {
                    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                    picker.allowsEditing =YES;
                    [self presentViewController:picker animated:YES completion:nil];
                }
                else
                {
                    return;
                }
            }
                break;
            case 1:
            {
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary])
                {
                    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:picker animated:YES completion:nil];
                }
            }
                break;
            default:
            {
                return;
            }
                break;
        }
    }
}

#pragma mark ImagePicker
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.headImageView.image=[info objectForKey:UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SentuploadImage_Request:self.headImageView.image imageName:@"headImage" Progress:^(NSProgress *progress) {
            
        } Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            if(info.success){
                self.headImageUrl = info.data;
                self.haveAlert = YES;
            }else{
                self.haveAlert = NO;
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }];
    }];
}
#pragma mark 确认修改
-(void)btnClick:(id)sender{
    NSString *nickname =self.nickNameLabel.text;
    NSInteger sex=[self.sexLabel.text isEqualToString:@"男"]?1:2;
    BOOL canRegist=YES;
    self.haveAlert =NO;
    if (canRegist) {
        [BaseMethod showLoading:self.view];
        PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
        PeopleInfoDataModel *datainfo = peopleinfo.data;
        [[NetWorkingRequest share_MainViewRequest] SendMemberDoEitAccount:datainfo.account Sex:sex Icon:self.headImageUrl UserName:nickname Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            if (info.success) {
                self.haveAlert = NO;
            }else{
            }
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }];
    }else{
        
    }

}
-(void)setHaveAlert:(BOOL)haveAlert{
    [self.btn setEnabled:haveAlert];
    if (haveAlert) {
        [self.btn setBackgroundColor:ThemeRedColor];
    }else{
        [self.btn setBackgroundColor:[UIColor lightGrayColor]];
        
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
