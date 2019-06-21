//
//  SearchPageViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/6/5.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "SearchPageViewController.h"
#import "NetWorkingRequest.h"
#import "MainPageSingleMusicTableViewCell.h"
#import "PlayViewController.h"
@interface SearchPageViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) NSArray *SearchResultArray;
@end

@implementation SearchPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationBackButton];
    [self setObject];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.MainTableView setFrame:CGRectMake(0, 0, KWidth, KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    [self.searchBar becomeFirstResponder];
}
-(void)setObject{
  //  self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(20), 0, KWidth - Macro_AutoWidth_7p(40), Macro_AutoWidth_7p(40))];
    self.searchBar.delegate = self;
    //UIView *titleviwe
    self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                             0,
                                                                             KWidth - Macro_AutoWidth_7p(80),
                                                                             Macro_AutoWidth_7p(30))];
    [self.navigationItem.titleView setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.titleView.layer.cornerRadius = Macro_AutoWidth_7p(30)/2.0;
    self.navigationItem.titleView.layer.masksToBounds  = YES;

    [self.navigationItem.titleView addSubview:self.searchBar];
    
    self.MainTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    [self.view addSubview:self.MainTableView];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *account = [BaseMethod getUserAccount];
    [[NetWorkingRequest share_MainViewRequest] SendHotSongSearchWithCategoryId:@"" Rank:@"" Account:account PageNo:1 KeyWord:searchBar.text Success:^(BaseModel *info) {
        self.SearchResultArray = info.data;
        [self.MainTableView reloadData];
        if (info.success) {
            [self.searchBar resignFirstResponder];
        }
    } failure:^(NSError *error) {
        
    }];
}
//单曲曲库，点击
-(void)SingleMusicSelectWithIndex:(NSIndexPath *)indxPath{
    NSDictionary *dic = self.SearchResultArray[indxPath.row];
    NSDictionary *MusicDic = dic[@"music"];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.MusicID = MusicDic[@"id"];
    [playVC setHidesBottomBarWhenPushed:YES];
    [playVC.navigationItem setTitle:dic[@"name"]];
    playVC.hotsongDic = dic;
    playVC.isSingleMusic = YES;
    playVC.showTuPu = YES;
    [self.navigationController pushViewController:playVC animated:YES];
}
#pragma search

#pragma mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self SingleCellInitWithIndexPath:indexPath tableview:tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.SearchResultArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MainPageSingleMusicTableViewCell CellHeight];
}
-(MainPageSingleMusicTableViewCell *)SingleCellInitWithIndexPath:(NSIndexPath *)indexPath tableview:(UITableView *)tableView{
    NSString *KCell = @"SingleMusicCell";
    MainPageSingleMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[MainPageSingleMusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSDictionary *dic = self.SearchResultArray[indexPath.row];
    [cell setSingleMusicWithInfo:dic];
//    cell.addToCartsBlock = ^BOOL(MainPageSingleMusicTableViewCell *result) {
//        NSString *account = [BaseMethod getUserAccount];
//        NSString *songid = dic[@"id"];
//        [[NetWorkingRequest share_MainViewRequest] SendCartDoAddAccount:account GoodsID:songid Type:0 Success:^(BaseModel *info) {
//            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
//        } failure:^(NSError *error) {
//            [BaseMethod showToast:[error description] hideAfterSecond:2 inView:self.view];
//        }];
//    };
    cell.addToCartsBlock = ^(MainPageSingleMusicTableViewCell *result) {
        NSString *account = [BaseMethod getUserAccount];
        NSString *songid = dic[@"id"];
        [[NetWorkingRequest share_MainViewRequest] SendCartDoAddAccount:account GoodsID:songid Type:0 Success:^(BaseModel *info) {
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        } failure:^(NSError *error) {
            [BaseMethod showToast:[error description] hideAfterSecond:2 inView:self.view];
        }];
    };
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self SingleMusicSelectWithIndex:indexPath];
}
-(UISearchBar *)searchBar{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(5),
                                                                   0,
                                                                   KWidth - Macro_AutoWidth_7p(90),
                                                                   Macro_AutoWidth_7p(30))];
        _searchBar.layer.cornerRadius = Macro_AutoWidth_7p(15)/2.0;
        _searchBar.layer.masksToBounds = YES;
    }
    return _searchBar;
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

