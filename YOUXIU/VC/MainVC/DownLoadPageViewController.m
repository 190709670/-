//
//  DownLoadPageViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/3/22.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownLoadPageViewController.h"
#import "DownLoadTableViewCell.h"
//#import "LoadMetchod.h"
@interface DownLoadPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *downLoadTaskArray;
@end

@implementation DownLoadPageViewController
#define 属性懒加载
-(NSMutableArray *)downLoadTaskArray{
    if (_downLoadTaskArray == nil) {
        _downLoadTaskArray = [[NSMutableArray alloc] init];
    }
    return _downLoadTaskArray;
}
#define mark 实现方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setObject];
    [self addDownLoadTask];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"下载" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonClick:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}
-(void)setObject{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView setBackgroundColor:[UIColor cyanColor]];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];
}
-(void)addDownLoadTask{
    NSString *urlSring = @"http://www.yesazz.com/music.rar";
    [self.downLoadTaskArray addObject:urlSring];
    [self.mainTableView reloadData];
}
#define TableviewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *KCell = @"KCell";
    DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[DownLoadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        [cell setBackgroundColor:[UIColor cyanColor]];
    }
    NSString *urlString = [self.downLoadTaskArray objectAtIndex:indexPath.row];
    [cell setCellDownLoadTask:urlString];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.downLoadTaskArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)rightBarButtonClick:(id)sender{
   // [self startLoadDownTask];
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
