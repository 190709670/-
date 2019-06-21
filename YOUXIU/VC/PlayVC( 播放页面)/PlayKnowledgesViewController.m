//
//  PlayKnowledgesViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/8/9.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "PlayKnowledgesViewController.h"
#import "VideoPlayView.h"

@interface PlayKnowledgesViewController ()<VideoPlayDelegate>
@property (nonatomic, strong) VideoPlayView *videoPlayerView;
@end

@implementation PlayKnowledgesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"知识点讲解";
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.videoPlayerView SetPlayerIsLocal:NO withVideoURL:self.musicUrl];
    [self.videoPlayerView StartPlay];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.videoPlayerView StopPlay];
}
-(void)setObject{
    self.videoPlayerView = [[VideoPlayView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           KWidth,
                                                                           KWidth*9.00/16 + 110)];
    self.videoPlayerView.delegate = self;
    self.videoPlayerView.showTuPu = NO;
    [self.view addSubview:self.videoPlayerView];
}
-(void)VideoTuPuClick:(NSString *)BtnName{
    NSLog(@"");
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
