//
//  GuidePageViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/5/31.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "GuidePageViewController.h"
#import "RootTabBarViewController.h"
@interface GuidePageViewController ()<UIScrollViewDelegate>

@end

@implementation GuidePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setObject];
}
-(void)setObject{
    self.GuideImageArray = @[@"ggps_1_text",@"ggps_2_bg",@"ggps_3_text",@"ggps_4_bg"];
    
    self.GuideScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.GuideScrollView.pagingEnabled = YES;
    self.GuideScrollView.showsHorizontalScrollIndicator = NO;
    self.GuideScrollView.bounces = NO;
    self.GuideScrollView.delegate = self;
    self.GuideScrollView.contentSize = CGSizeMake(self.GuideImageArray.count*self.view.frame.size.width, self.view.frame.size.height);
    for (int i = 0; i < self.GuideImageArray.count ; i++) {
        NSString *imageName = [self.GuideImageArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(Macro_ScreenWidth*i, 0, Macro_ScreenWidth, Macro_ScreenHeight);
        [self.GuideScrollView addSubview:imageView];
        
    }
    [self.view addSubview:self.GuideScrollView];
    
    self.pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, Macro_ScreenHeight - Macro_AutoHeight_7p(100), Macro_ScreenWidth, Macro_AutoHeight_7p(50))];
    self.pagecontrol.numberOfPages = self.GuideImageArray.count;
   // [self.pagecontrol setBackgroundColor:[UIColor cyanColor]];
    
    [self.view addSubview:self.pagecontrol];
    
}
-(void)gestureLeft{
    if ([self.delegate respondsToSelector:@selector(guidePageDisapper)]) {
        [self.delegate guidePageDisapper];
    }
}
#pragma mark ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/Macro_ScreenWidth;
    if (self.pagecontrol.currentPage == page) {
        [self gestureLeft];
    }else{
        self.pagecontrol.currentPage = page;
    }
}
//-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
//    NSInteger page = scrollView.contentOffset.x/Macro_ScreenWidth;
//    self.pagecontrol.currentPage = page;
//}
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
