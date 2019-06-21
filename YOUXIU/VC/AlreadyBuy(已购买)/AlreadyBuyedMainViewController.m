//
//  AlreadyBuyedMainViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/17.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "AlreadyBuyedMainViewController.h"
#import "CustomSegmentView.h"
#import "AlreadyPayTableViewCell.h"
#import "PlayViewController.h"
#import "NetWorkingRequest.h"
#import "DownLoadMetch.h"
#import "AlbumDetailListViewController.h"
#import "FilePatchMetch.h"
#import "FileManagerViewController.h"
#import "DownRecordViewController.h"

@interface AlreadyBuyedMainViewController ()<UITableViewDelegate,UITableViewDataSource,CustomSegmentViewDelegate>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *downLoadRecodeArray;
@property (nonatomic, retain) CustomSegmentView *segmentView;
@property (nonatomic, assign) NSInteger pageNo;
@end

@implementation AlreadyBuyedMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"已购买";
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  //  [self NetWorkingRequest];
}
-(void)setObject{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame) - self.tabBarController.tabBar.frame.size.height) style:UITableViewStyleGrouped];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
    __weak typeof(self) weakSelf = self;
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNo = 1;
        [weakSelf NetWorkingRequest];
    }];
    self.mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf NetWorkingRequest];
;
    }];
    
    self.pageNo = 1;
    [weakSelf NetWorkingRequest];
}
-(void)customSegmentClick:(int)witchbtn{
    
}
-(void)NetWorkingRequest{
    __weak typeof(self) WeakSelf = self;
    NSString *account = [BaseMethod getUserAccount];
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendOrderListWithAccount:account pageNo:self.pageNo Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        if (info.success) {
            if(self.downLoadRecodeArray == nil){
                self.downLoadRecodeArray = [[NSMutableArray alloc] init];
            }
            if (self.pageNo == 1) {
                [self.downLoadRecodeArray removeAllObjects];
                [WeakSelf.mainTableView.mj_header endRefreshing];
            }else{
                [WeakSelf.mainTableView.mj_footer endRefreshing];
            }
            [self.downLoadRecodeArray addObjectsFromArray:info.data];
            self.pageNo = self.pageNo + 1;
        }
        [self.mainTableView reloadData];
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [WeakSelf.mainTableView.mj_footer endRefreshing];
        [WeakSelf.mainTableView.mj_header endRefreshing];
    }];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [self.downLoadRecodeArray objectAtIndex:indexPath.row];
    //是否是单曲，0单曲，1专辑
    AlreadyPayTableViewCell *cell = [[AlreadyPayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
    [cell setPayRecodInfoWithSingleInfo:dic];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    __weak typeof(self) weakSelf = self;
    [cell setWxpBtnClickBlock:^(AlreadyPayTableViewCell *thisCell) {
        [weakSelf SingleMusicPlayIndexPath:indexPath isWXP:YES];
    }];
    
    [cell setJpBtnClickBlock:^(AlreadyPayTableViewCell *thisCell) {
        [weakSelf SingleMusicPlayIndexPath:indexPath isWXP:NO];
    }];
    
    //设置背景
    NSString *fileUrl = dic[@"zipPath"]; //文件下载的网络地址
    NSDictionary *fileInfoDic = [[DownLoadMetch shareInstance] GetFileDicWithFileURL:fileUrl];
    if (fileInfoDic == nil) {
        [cell setCellStatus:NO info:@"未下载"];
    }else{
        NSInteger LoadStatus = [fileInfoDic[@"DownLoad_isLoad"] integerValue];
        if (LoadStatus != 2) {
             [cell setCellStatus:NO info:@"未下载完成"];
        }else{
            [cell setCellStatus:YES info:@""];
        }
    }
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.downLoadRecodeArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AlreadyPayTableViewCell cellHeight];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Macro_AutoWidth_7p(10);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [self.downLoadRecodeArray objectAtIndex:indexPath.row];
    if ([dic[@"type"] boolValue]) {//专辑
        [self SingleMusicPlayIndexPath:indexPath isWXP:YES];
    }else{
         [self SingleMusicPlayIndexPath:indexPath isWXP:YES];
    }
}
-(void)SingleMusicPlayIndexPath:(NSIndexPath *)IndexPath isWXP:(BOOL)isWXP{
    NSDictionary *dic = [self.downLoadRecodeArray objectAtIndex:IndexPath.row];
    NSString *fileUrl = dic[@"zipPath"]; //文件下载的网络地址
    NSDictionary *fileInfoDic = [[DownLoadMetch shareInstance] GetFileDicWithFileURL:fileUrl];
    if (fileInfoDic == nil) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该文件未下载，请至文件管理中重新下载" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *trueAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    FileManagerViewController *fileVC = [[FileManagerViewController alloc] init];
                    [fileVC setHidesBottomBarWhenPushed:YES];
                    [self.navigationController pushViewController:fileVC animated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:trueAction];
        [self.navigationController presentViewController:alertController animated:YES completion:nil];
    }else{
        NSInteger LoadStatus = [fileInfoDic[@"DownLoad_isLoad"] integerValue];
        if (LoadStatus != 2) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该文件未下载完成，请至下载队列查看文件下载状态" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *trueAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                DownRecordViewController  *downLoadVC = [[DownRecordViewController alloc] init];
                [downLoadVC setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:downLoadVC animated:YES];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [alertController addAction:trueAction];
            [self.navigationController presentViewController:alertController animated:YES completion:nil];
        }else{
            NSInteger fileType = [fileInfoDic[@"type"] integerValue];
            if (fileType == 0) {
                //单曲
                [self SingleMusicWithFileDic:fileInfoDic isWXP:isWXP];
            }else{
                //专辑
                [self AlbumMusicWithFileDic:fileInfoDic];
            }
        }
    }
}

//单曲曲库，点击
-(void)SingleMusicWithFileDic:(NSDictionary *)FileDic isWXP:(BOOL)isWXP{
    NSString *MusicID = FileDic[@"musicId"];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.MusicID = MusicID;
    [playVC setHidesBottomBarWhenPushed:YES];
    [playVC.navigationItem setTitle:FileDic[@"musicName"]];
    playVC.hotsongDic = nil;
    playVC.isWXP = isWXP;
    playVC.fileName = FileDic[@"musicName"];
    playVC.isLocalType = YES;
    playVC.isSingleMusic = YES;
    playVC.showTuPu = YES;
    NSString *UnZipPath = [[FilePatchMetch getUserUnZipFilePatch] stringByAppendingPathComponent:@"FileType_SingleMusic"];
    playVC.UnZipPath = UnZipPath;
    [self.navigationController pushViewController:playVC animated:YES];
}
-(void)AlbumMusicWithFileDic:(NSDictionary *)FileDic{
    AlbumDetailListViewController *AlbumVC = [[AlbumDetailListViewController alloc] init];
    AlbumVC.isLocal = YES;
    AlbumVC.albumName = FileDic[@"songName"];
    [AlbumVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:AlbumVC animated:YES];
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
