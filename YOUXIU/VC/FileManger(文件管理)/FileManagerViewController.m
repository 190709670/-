//
//  FileManagerViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/24.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "FileManagerViewController.h"
#import "CustomSegmentView.h"
#import "FileManagerTableViewCell.h"
#import "NetWorkingRequest.h"
#import <MZDownloadManager/MZDownloadManager-Swift.h>
#import "PlayViewController.h"
#import "DownLoadMetch.h"
#import "DownLoadPlistMetch.h"
#import "FilePatchMetch.h"
@interface FileManagerViewController ()<UITableViewDelegate,UITableViewDataSource,CustomSegmentViewDelegate>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) CustomSegmentView *segmentView;
@property (nonatomic, retain) NSMutableArray *NetPayedMusicInfoArray;
@property (nonatomic) NSInteger FileType; //0： 热门单曲1：专辑
@property (nonatomic) NSInteger pageNo;
@end

@implementation FileManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"文件管理";
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)setObject{
    self.segmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(50))];
    [self.segmentView setTitles:@[@"单曲",@"专辑"] withColor:ThemeRedColor font:[UIFont systemFontOfSize:15]];
    self.segmentView.delegate = self;
    [self.view addSubview:self.segmentView];
    self.FileType = 0;
    
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       CGRectGetMaxY(self.segmentView.frame),
                                                                       KWidth,
                                                                       self.view.frame.size.height - CGRectGetMaxY(self.segmentView.frame) - 64)
                                                      style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    [self.view addSubview:self.MainTableView];
    
    __weak typeof(self) weakSelf = self;
    self.MainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [weakSelf customSegmentClick:weakSelf.FileType];
    }];
    self.MainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf LoadMoreData];
    }];
    
    [self customSegmentClick:self.FileType];
}
-(void)customSegmentClick:(int)witchbtn{
    self.FileType = witchbtn;
    self.pageNo = 1;
    [self requestNetWorkData];
}
-(void)LoadMoreData{
    [self requestNetWorkData];
}
-(void)requestNetWorkData{
    __weak typeof(self) weakSelf = self;

    //0:热门单曲，1，专辑
    [[NetWorkingRequest share_MainViewRequest] SendClientfileType:self.FileType Account:[BaseMethod getUserAccount] PageNo:self.pageNo Success:^(BaseModel *info) {
        if (weakSelf.NetPayedMusicInfoArray == nil) {
            weakSelf.NetPayedMusicInfoArray = [[NSMutableArray alloc] init];
        }
        if (self.pageNo == 1) {
            [weakSelf.NetPayedMusicInfoArray  removeAllObjects];
            [weakSelf.NetPayedMusicInfoArray addObjectsFromArray:info.data];
        }else{
            [weakSelf.NetPayedMusicInfoArray addObjectsFromArray:info.data];
        }
        self.pageNo = self.pageNo+1;
        [weakSelf.MainTableView.mj_header endRefreshing];
        [weakSelf.MainTableView.mj_footer endRefreshing];
        [weakSelf.MainTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}
-(void)rightBarButtonClick:(id)sender{
    NSString *zipPath = @"http://app.ushowpiano.com/upload/music.rar";
  //  [[ZFDownloadManager sharedDownloadManager] downFileUrl:zipPath filename:nil fileimage:nil];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FileManagerTableViewCell *cell = [[FileManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
    NSDictionary *dic = [self.NetPayedMusicInfoArray objectAtIndex:indexPath.row];
    NSString *downloadFileUrl = dic[@"filePath"];
    BOOL isSingleMusic ;
    if (self.FileType == 0) {
        isSingleMusic = YES;
    }else{
        isSingleMusic = NO;
    }
    BOOL isExit = [[DownLoadMetch shareInstance] TaskIsExist:downloadFileUrl];
    
    [cell setFileInfoWith:dic isLocal:isExit];
    cell.rightbtnclickBlock = ^(FileManagerTableViewCell *thiscell) {
        if (isExit) {
            //删除
            [[DownLoadMetch shareInstance] DeledateTaskAndFile:downloadFileUrl];
            [self.MainTableView reloadData];
        }else{
            if (downloadFileUrl.length <= 0){
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未获取该文件下载链接\n请稍后再试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
                alertview = nil;
                return;
            }
            
            if([[DownLoadMetch shareInstance] TaskIsExist:downloadFileUrl]){//该url存在
                UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该任务已存在，请到下载页面查看" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertview show];
                alertview = nil;
            }else{
                NSLog(@"该任务不存在,开始下载");
                [self.MainTableView reloadData];
                [[DownLoadMetch shareInstance] StartLoadFileWithPath:downloadFileUrl fileName:@"" fileDic:dic isSingleMusic:isSingleMusic complete:^(id result) {
                    [self.MainTableView reloadData];
                }];
            }
        }
    };
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.NetPayedMusicInfoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Macro_AutoWidth_7p(60);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Macro_AutoWidth_7p(40);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(40))];
    [headview setBackgroundColor:[UIColor colorWithRed:255/255.0 green:247/255.0 blue:247/255.0 alpha:247/255.0]];
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), 0, KWidth, Macro_AutoWidth_7p(40))];
    [headLabel setBackgroundColor:[UIColor colorWithRed:255/255.0 green:247/255.0 blue:247/255.0 alpha:247/255.0]];
    [headLabel setText:@"已购买的歌曲自购买之日起一年内可免费恢复"];
    [headLabel setFont:[UIFont systemFontOfSize:12]];
    [headview addSubview:headLabel];
    return headview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Macro_AutoWidth_7p(10);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//单曲曲库，点击
-(void)SingleMusicSelectWithIndex:(NSIndexPath *)indxPath isWXP:(BOOL)isWXP{
    NSDictionary *dic = self.self.NetPayedMusicInfoArray[indxPath.row];
    NSString *MusicID = dic[@"musicId"];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.MusicID = MusicID;
    [playVC setHidesBottomBarWhenPushed:YES];
    [playVC.navigationItem setTitle:dic[@"musicName"]];
    playVC.hotsongDic = nil;
    playVC.isWXP = YES;
    playVC.fileName = dic[@"musicName"];
    playVC.isLocalType = YES;
    playVC.showTuPu = YES;
    NSString *UnZipPath = [[FilePatchMetch getUserUnZipFilePatch] stringByAppendingPathComponent:[NSString stringWithFormat:@"FileType_SingleMusic/%@",dic[@"musicName"]]];
    
    playVC.UnZipPath = UnZipPath;
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
