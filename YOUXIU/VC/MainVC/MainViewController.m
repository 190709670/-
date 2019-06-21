//
//  MainViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/3/20.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "MainViewController.h"
//#import "LoadMetchod.h"
#import "DownLoadPageViewController.h"
#import "VideoPlayView.h"
#import "FilePatchMetch.h"
#import "PlayViewController.h"
@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击下载" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    [self setObject];
}
-(void)setObject{
    [self.view setBackgroundColor:[UIColor cyanColor]];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    VideoPlayView *PlayerView = [[VideoPlayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)];
//   // [PlayerView setBackgroundColor:[UIColor redColor]];
//    NSString *unZipPatch = [FilePatchMetch getUserUnZipFilePatch];
//    // NSString *videoPatch = [NSString stringWithFormat:@"%@/%@",unZipPatch,@"绿岛小夜曲/JP/绿岛小夜曲简谱.mp4"];
//    NSString *videoPatch = [NSString stringWithFormat:@"%@/%@",unZipPatch,@"AAAA.mp4"];
//    [self.view addSubview:PlayerView];
//    [PlayerView SetPlayerIsLocal:YES withVideoURL:videoPatch];
}
-(void)btnClick:(id)sender{
    PlayViewController *vc = [[PlayViewController alloc] init];
    vc.showTuPu = YES;
//    DownLoadPageViewController *vc = [[DownLoadPageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
