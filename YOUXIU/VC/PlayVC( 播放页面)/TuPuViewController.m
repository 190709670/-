//
//  TuPuViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/30.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "TuPuViewController.h"
#import "CustomSegmentView.h"
#import "ZJImageMagnification.h"
#import "BigTuPuViewController.h"
@interface TuPuViewController ()<CustomSegmentViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) CustomSegmentView *segmentView;
@property (nonatomic, strong) UIScrollView *mainScrollView;
//@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pagenumberLabel;
@property (nonatomic, retain) UIButton *customPhotoBtn;
@end

@implementation TuPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSDictionary *dic = self.TuPuArray[self.selectedNumber];
    [self setScrollViewWithTitle:dic[@"name"] Images:dic[@"images"]];
    self.navigationItem.title  =[NSString stringWithFormat:@"%@-%@",self.title,dic[@"name"]];
    [self.segmentView selectSegmentBtn:self.selectedNumber];
}
-(void)setObject{
    self.segmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(40))];
    [self.segmentView setTitles:@[@"五线谱",@"简五谱",@"固定调简谱",@"首调式简谱"] withColor:ThemeRedColor font:[UIFont systemFontOfSize:14]];
    self.segmentView.delegate = self;
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                         CGRectGetMaxY(self.segmentView.frame),
                                                                         KWidth - Macro_AutoWidth_7p(20),
                                                                         KHeight - CGRectGetMaxY(self.segmentView.frame) -CGRectGetMaxY(self.navigationController.navigationBar.frame) - Macro_AutoWidth_7p(30))];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.delegate = self;
    
    self.pagenumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                     CGRectGetMaxY(self.mainScrollView.frame),
                                                                     KWidth,
                                                                     Macro_AutoWidth_7p(30))];
    [self.pagenumberLabel setTextAlignment:NSTextAlignmentCenter];
    [self.pagenumberLabel setFont:[UIFont systemFontOfSize:10]];
    
    self.customPhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customPhotoBtn setTitle:@"复制" forState:UIControlStateNormal];
    [self.customPhotoBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.customPhotoBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.customPhotoBtn.layer.cornerRadius = 5;
    self.customPhotoBtn.layer.masksToBounds = YES;
    self.customPhotoBtn.layer.borderWidth = 1;
    [self.customPhotoBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.customPhotoBtn addTarget:self action:@selector(customPhotoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.customPhotoBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(100),
                                           CGRectGetMaxY(self.segmentView.frame) + Macro_AutoWidth_7p(10),
                                           Macro_AutoWidth_7p(40),
                                           Macro_AutoWidth_7p(20))];
    [self.customPhotoBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.pagenumberLabel];
    [self.view addSubview:self.customPhotoBtn];
}
-(void)customSegmentClick:(int)witchbtn{
    self.selectedNumber = witchbtn;
    NSDictionary *dic = self.TuPuArray[self.selectedNumber];
    [self setScrollViewWithTitle:dic[@"name"] Images:dic[@"images"]];
    self.navigationItem.title  =[NSString stringWithFormat:@"%@-%@",self.title,dic[@"name"]];
    [self.mainScrollView scrollRectToVisible:CGRectMake(0, 0, CGRectGetWidth(self.mainScrollView.frame), CGRectGetHeight(self.mainScrollView.frame)) animated:YES];
}
-(void)setScrollViewWithTitle:(NSString *)title Images:(NSArray *)imagesarray{
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width*imagesarray.count, self.mainScrollView.frame.size.height);
    
    for (UIImageView *imageview in self.mainScrollView.subviews) {
        if ([imageview isKindOfClass:[UIImageView class]]) {
            [imageview removeFromSuperview];
        }
    }
    for (int i = 0 ; i < imagesarray.count; i++) {
        NSString *imageurl = imagesarray[i];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainScrollView.frame.size.width*i,
                                                                          0,
                                                                          self.mainScrollView.frame.size.width,
                                                                          self.mainScrollView.frame.size.height)];
        icon.tag = i+10;
        [self.mainScrollView addSubview:icon];
        if (self.isLocalType) {
            [icon setImage:[UIImage imageWithContentsOfFile:imageurl]];
        }else{
            [icon setImageWithURL:[NSURL URLWithString:imageurl]];
        }
        [icon setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick:)];
        tapGesture.numberOfTapsRequired = 1;
        [icon addGestureRecognizer:tapGesture];
    }
    [self.pagenumberLabel setText:[NSString stringWithFormat:@"1/%lu",(unsigned long)imagesarray.count]];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSDictionary *dic = self.TuPuArray[self.selectedNumber];
    NSInteger totalnumber = [dic[@"images"] count];
    NSInteger number = ceil(scrollView.contentOffset.x/self.mainScrollView.frame.size.width) + 1;
    [self.pagenumberLabel setText:[NSString stringWithFormat:@"%ld/%lu",(long)number,totalnumber]];
}
-(void)iconClick:(id)sender{
    NSDictionary *dic = self.TuPuArray[self.selectedNumber];
    NSArray *imagearray = dic[@"images"];
    if (imagearray.count > 0) {
        BigTuPuViewController *vc = [[BigTuPuViewController alloc] init];
        [vc setImageArray:imagearray isLocal:self.isLocalType];
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        [BaseMethod showToast:@"没有获取到该类下图谱" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
    }
}
-(void)customPhotoBtnClick:(id)sender{
   NSInteger pagenumber = [[[self.pagenumberLabel.text componentsSeparatedByString:@"/"] objectAtIndex:0] integerValue];
    UIImageView *imageview = [self.mainScrollView viewWithTag:pagenumber + 10 - 1];
    if (imageview == nil) {
        [BaseMethod showToast:@"未获取图片，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(imageview.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error == nil){
        [BaseMethod showToast:@"图谱保存成功" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];

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
