//
//  UserFeedbackViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/22.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "UserFeedbackViewController.h"
#import "NetWorkingRequest.h"
@interface UserFeedbackViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, retain) UITextView *mainTextView;
@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) UIView *ImageBackView;
@property (nonatomic, retain) UIButton *AddImageBtn;
@property (nonatomic, retain) UIButton *submitBtn;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) UIImagePickerController *imagePickerVC;
@end

@implementation UserFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackButton];
    self.navigationItem.title = @"用户反馈";
    [self.view setBackgroundColor:Macro_ViewBackColor];
    [self add_Tap_TextFieldKeyBoardDismiss];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)setObject{
    
    self.mainTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, Macro_AutoWidth_7p(5), KWidth, Macro_AutoWidth_7p(200))];
    self.mainTextView.delegate = self;
    [self.view addSubview:self.mainTextView];
    
    self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(20))];
    [self.placeHolderLabel setText:@"请输入您的反馈，我们将尽快与您联系，不少于20字哦!"];
    [self.placeHolderLabel setTextColor:[UIColor colorWithWhite:0.8 alpha:0.8]];
    [self.placeHolderLabel setFont:[UIFont systemFontOfSize:14]];
    [self.mainTextView addSubview:self.placeHolderLabel];
    
    self.ImageBackView = [[UIView alloc] initWithFrame:CGRectMake(0 ,
                                                                  CGRectGetMaxY(self.mainTextView.frame) + Macro_AutoWidth_7p(10),
                                                                  KWidth,
                                                                  Macro_AutoWidth_7p(100))];
    [self.ImageBackView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.ImageBackView];
    
    self.AddImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.AddImageBtn setFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(80), Macro_AutoWidth_7p(80))];
    [self.AddImageBtn setBackgroundImage:[UIImage imageNamed:@"PlusImage"] forState:UIControlStateNormal];
    [self.AddImageBtn addTarget:self action:@selector(AddImageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.ImageBackView addSubview:self.AddImageBtn];
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitBtn setFrame:CGRectMake(Macro_AutoWidth_7p(20), CGRectGetMaxY(self.ImageBackView.frame) + Macro_AutoWidth_7p(100), KWidth - Macro_AutoWidth_7p(40), Macro_AutoWidth_7p(40))];
    [self.submitBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitBtn setBackgroundColor:ThemeRedColor];
    self.submitBtn.layer.cornerRadius = self.submitBtn.frame.size.height/2.0;
    [self.submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitBtn];
    
    self.imagePickerVC = [[UIImagePickerController alloc] init];
    self.imagePickerVC.delegate = self;
    self.imagePickerVC.allowsEditing = YES;
    
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.text.length > 0 || text.length > 0) {
        [self.placeHolderLabel setHidden:YES];
    }else{
        [self.placeHolderLabel setHidden:NO];
    }
    return YES;
}
-(void)AddImageBtnClick:(id)sender{
    if (self.imageArray.count >= 3) {
        [BaseMethod showToast:@"最多添加3张图片" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
    }else{
        self.imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self.navigationController presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
}
-(void)submitBtnClick:(id)sender{
  //  [BaseMethod showToast:@"暂不开放" hideAfterSecond:2 inView:self.view];
    NSString *account = [BaseMethod getUserAccount];
    NSMutableString *imagesurlarraystring = [[NSMutableString alloc] init];
    for (NSDictionary *dic in self.imageArray) {
        NSString *imageurl = dic[@"imageurl"];
        [imagesurlarraystring appendFormat:@",%@",imageurl];
    }
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendMessagePublishAccount:account images:imagesurlarraystring content:self.mainTextView.text Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToastOnWindowWithString:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime];
        if (info.success) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
    }];
}
-(void)ReloadImageView{
 // [self.AddImageBtn setFrame:CGRectMake(Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(10), Macro_AutoWidth_7p(80), Macro_AutoWidth_7p(80))];
    for (UIView *view in self.ImageBackView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    if (self.imageArray != nil && self.imageArray.count > 0) {
        for (int i = 0 ; i < self.imageArray.count; i++) {
            UIImage *image = [self.imageArray[i] valueForKey:@"imagedata"];
            UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
            NSInteger view_x = Macro_AutoWidth_7p(10) +  (Macro_AutoWidth_7p(80) + Macro_AutoWidth_7p(5)) *i;
            [imageview setFrame:CGRectMake(view_x,
                                           Macro_AutoWidth_7p(10),
                                           Macro_AutoWidth_7p(80),
                                           Macro_AutoWidth_7p(80))];
            [self.ImageBackView addSubview:imageview];
            
            if (i == self.imageArray.count-1) {
                  [self.AddImageBtn setFrame:CGRectMake(CGRectGetMaxX(imageview.frame) + Macro_AutoWidth_7p(5),
                                                        Macro_AutoWidth_7p(10),
                                                        Macro_AutoWidth_7p(80),
                                                        Macro_AutoWidth_7p(80))];
                
            }
        }
    }
}
#pragma mark imagepickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *getimage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (self.imageArray == nil) {
        self.imageArray = [[NSMutableArray alloc] init];
    }
   // [self.imageArray addObject:[info objectForKey:UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:^{
        [BaseMethod showLoading:self.view];
        [[NetWorkingRequest share_MainViewRequest] SentuploadImage_Request:getimage imageName:@"getimageImage" Progress:^(NSProgress *progress) {
            
        } Success:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            if(info.success){
                NSDictionary *imageDic = @{
                                           @"imagedata":getimage,
                                           @"imageurl":info.data
                                           };
                if (self.imageArray.count >= 3) {
                    [BaseMethod showToast:@"最多添加3张图片" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
                }else{
                    [self.imageArray addObject:imageDic];
                    [self ReloadImageView];
                }
            }else{
            }
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:[error localizedDescription] hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }];
    }];
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
