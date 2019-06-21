//
//  KnowledgePointListViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/6/6.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "KnowledgePointListViewController.h"
#import "NetWorkingRequest.h"
#import "CustomBtnAddObject.h"
#import "ShowWebStringViewController.h"
#import "PlayViewController.h"
#import "PlayKnowledgesViewController.h"

@interface KnowledgePointListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) NSDictionary *dataDic;
@end

@implementation KnowledgePointListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self netWorkRequest];
}
-(void)setObject{
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    [self.view addSubview:self.MainTableView];
}
-(void)netWorkRequest{
    [[NetWorkingRequest share_MainViewRequest] SendKnowledgeSchemaInfoWithSchemaID:self.schemaId Success:^(BaseModel *info) {
        NSLog(@"info:%@",info);
        if (info.success) {
             self.dataDic = info.data;
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
        }
       
        [self.MainTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                          Macro_AutoWidth_7p(10),
                                                                          Macro_AutoWidth_7p(60),
                                                                          Macro_AutoWidth_7p(60))];
        icon.layer.cornerRadius = 5;
        icon.layer.masksToBounds = YES;
        icon.tag = 5;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + Macro_AutoWidth_7p(10),
                                                                        CGRectGetMinY(icon.frame),
                                                                        Macro_AutoWidth_7p(200),
                                                                        Macro_AutoWidth_7p(20))];
        [titleLabel setFont:[UIFont systemFontOfSize:16]];
        titleLabel.tag = 1;
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + Macro_AutoWidth_7p(10),
                                                                          CGRectGetMaxY(titleLabel.frame) + Macro_AutoWidth_7p(5),
                                                                          CGRectGetWidth(titleLabel.frame),
                                                                          Macro_AutoWidth_7p(35))];
        [contentLabel setFont:[UIFont systemFontOfSize:14]];
        contentLabel.numberOfLines = 2;
        contentLabel.tag = 4;
        
        CustomBtnAddObject *paybtn = [CustomBtnAddObject buttonWithType:UIButtonTypeCustom];
        [paybtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(80),
                                    Macro_AutoWidth_7p(10),
                                    Macro_AutoWidth_7p(35),
                                    Macro_AutoWidth_7p(35))];
        [paybtn setBackgroundImage:[UIImage imageNamed:@"course_video"] forState:UIControlStateNormal];
        [paybtn addTarget:self action:@selector(paybtnClick:) forControlEvents:UIControlEventTouchUpInside];
        paybtn.tag = 3;
        
        UILabel *payBtnLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(100),
                                                                         Macro_AutoWidth_7p(50),
                                                                         Macro_AutoWidth_7p(80),
                                                                         Macro_AutoWidth_7p(20))];
        [payBtnLabel setText:@"视频讲解"];
        [payBtnLabel setTextAlignment:NSTextAlignmentCenter];
        [payBtnLabel setFont:[UIFont systemFontOfSize:14]];
        
        [cell.contentView addSubview:icon];
        [cell.contentView addSubview:titleLabel];
        [cell.contentView addSubview:contentLabel];
        [cell.contentView addSubview:paybtn];
        [cell.contentView addSubview:payBtnLabel];
    }
    
    NSArray *konwledges = self.dataDic[@"knowledges"];
    NSDictionary *dic = konwledges[indexPath.row];
    
    UIImageView *icon = (UIImageView *)[cell viewWithTag:5];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    CustomBtnAddObject *knowbtn = (CustomBtnAddObject *)[cell viewWithTag:2];
    CustomBtnAddObject *paybtn = (CustomBtnAddObject *)[cell viewWithTag:3];
    UILabel *contentLabel = (UILabel *)[cell viewWithTag:4];
    
    [icon setImageWithURL:[NSURL URLWithString:dic[@"cover"]]];
    [titleLabel setText:dic[@"title"]];
    [contentLabel setText:dic[@"content"]];

    knowbtn.object = indexPath;
    paybtn.object = indexPath;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *konwledges = self.dataDic[@"knowledges"];
    return konwledges.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(80);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self knowSelected:indexPath];
}
//知识介绍
-(void)knowSelected:(NSIndexPath *)indexPath{
    NSArray *konwledges = self.dataDic[@"knowledges"];
    NSDictionary *dic = konwledges[indexPath.row];
    NSString *webString = dic[@"content"];
    ShowWebStringViewController *vc = [[ShowWebStringViewController alloc] init];
    vc.navigationItem.title = dic[@"title"];
    vc.webString = webString;
    [self.navigationController pushViewController:vc animated:YES];
}
//视频讲解
-(void)paybtnClick:(id)sender{
    CustomBtnAddObject *btn = (CustomBtnAddObject *)sender;
    NSIndexPath *indexPath = btn.object;
    NSArray *konwledges = self.dataDic[@"knowledges"];
    NSDictionary *dic = konwledges[indexPath.row];
    
//    PlayViewController *playVC = [[PlayViewController alloc] init];
//    playVC.MusicID = dic[@"id"];
//    [playVC setHidesBottomBarWhenPushed:YES];
//    [playVC.navigationItem setTitle:dic[@"name"]];
//    playVC.hotsongDic = dic;
//    playVC.isSingleMusic = NO;
//    playVC.showTuPu = NO;
//    [self.navigationController pushViewController:playVC animated:YES];
    PlayKnowledgesViewController *playVC = [[PlayKnowledgesViewController alloc] init];
    playVC.musicUrl = dic[@"explainVideo"];
    [self.navigationController pushViewController:playVC animated:YES];
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
