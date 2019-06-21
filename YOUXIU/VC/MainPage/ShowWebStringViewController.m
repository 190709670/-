//
//  ShowWebStringViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/6/6.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "ShowWebStringViewController.h"

@interface ShowWebStringViewController ()
@property (nonatomic, retain) UIWebView *mainWebView;
@end

@implementation ShowWebStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackButton];
    [self setObject];
}
-(void)setObject{
    self.mainWebView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mainWebView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mainWebView loadHTMLString:self.webString baseURL:nil];
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
