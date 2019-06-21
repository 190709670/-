//
//  BigTuPuViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/7/12.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "BigTuPuViewController.h"

@interface BigTuPuViewController ()<UIScrollViewDelegate>
@property (nonatomic, retain) NSArray *TuPuimageArray;
@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, strong) UILabel *pagenumberLabel;
@property (nonatomic, assign) BOOL isLocalType;
@end

@implementation BigTuPuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setObject];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    [self setScrollViewWithTitle:nil Images:self.TuPuimageArray];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];

    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

-(void)setObject{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Macro_ScreenHeight, KWidth)];
    self.mainScrollView.delegate = self;
    self.mainScrollView.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.mainScrollView.pagingEnabled = YES;
    [self.mainScrollView setCenter:CGPointMake(KWidth/2.0,KHeight/2.0)];

    [self.view addSubview:self.mainScrollView];
}
-(void)setScrollViewWithTitle:(NSString *)title Images:(NSArray *)imagesarray{
    self.mainScrollView.contentSize = CGSizeMake(KHeight*imagesarray.count, KHeight*2550/1800);
    
    for (UIImageView *imageview in self.mainScrollView.subviews) {
        if ([imageview isKindOfClass:[UIImageView class]]) {
            [imageview removeFromSuperview];
        }
    }
    for (int i = 0 ; i < imagesarray.count; i++) {
        NSString *imageurl = imagesarray[i];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(KHeight*i,
                                                                          0,
                                                                          KHeight,
                                                                          KHeight*2550/1800)];
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
-(void)setImageArray:(NSArray *)imageArray isLocal:(BOOL)isLoal{
    self.TuPuimageArray = [NSArray arrayWithArray:imageArray];
    self.isLocalType = isLoal;
}
-(void)iconClick:(id)sender{
    [self.navigationController popViewControllerAnimated:NO];
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
