//
//  MessageReplyDetailViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/8/14.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "MessageReplyDetailViewController.h"

@interface MessageReplyDetailViewController ()
@property (nonatomic, strong) UITextView *replyTextView;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation MessageReplyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"回复详情";
    [self setNavgationBackButton];
    [self setUI];
}
- (void)setUI{
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                               Macro_AutoWidth_7p(10),
                                                               KWidth - Macro_AutoWidth_7p(20),
                                                               Macro_AutoWidth_7p(20))];
    [self.timeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.timeLabel setTextColor:[UIColor darkGrayColor]];
    self.replyTextView = [[UITextView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                      CGRectGetMaxY(self.timeLabel.frame) + Macro_AutoWidth_7p(2),
                                                                      KWidth - Macro_AutoWidth_7p(20),
                                                                      KHeight - CGRectGetMaxY(self.timeLabel.frame) - CGRectGetMaxY(self.navigationController.navigationBar.frame) - Macro_AutoWidth_7p(20))];
    [self.replyTextView setEditable:NO];
    [self.replyTextView setFont:[UIFont systemFontOfSize:16]];
    [self.replyTextView setScrollEnabled:YES];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.replyTextView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *replyTime = self.messageDic[@"replyDate"];
    NSString *replyContent = self.messageDic[@"replyContent"];
    [self.timeLabel setText:[NSString stringWithFormat:@"回复时间:%@", replyTime?replyTime:@"未获取"]];
    [self.replyTextView setText:replyContent];
//    [self.timeLabel setText:@"2018-07-02 09:57:49"];
////    [self.timeLabel setBackgroundColor:[UIColor cyanColor]];
//    [self.replyTextView setText:@"asdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdfasdfadfasdfasdf"];
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
