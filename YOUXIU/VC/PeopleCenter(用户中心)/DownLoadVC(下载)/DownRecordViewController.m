//
//  DownRecordViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/22.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownRecordViewController.h"
#import "CustomSegmentView.h"
#import "FilePatchMetch.h"
#import "UnZipMetchod.h"
#import "PlayViewController.h"
#import "DownLoadMetch.h"
#import "DownLoadPlistMetch.h"
#import "DownLoadedTableViewCell.h"
#import "DownLoadingTableViewCell.h"
@interface DownRecordViewController ()<UITableViewDelegate,UITableViewDataSource,CustomSegmentViewDelegate,DownLoadDelegate>
@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *downLoadRecodeArray;
@property (nonatomic, retain) CustomSegmentView *segmentView;
@property (nonatomic, strong)   NSLock *lock;
@end

@implementation DownRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"下载队列";
    [self setNavgationBackButton];
    self.downLoadRecodeArray = [[NSMutableArray alloc] init];
    self.lock = [NSLock new];
    [self setObject];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    // 更新数据源
    [self initData];
}
-(void)setObject{
    [DownLoadMetch shareInstance].delegate = self;
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame)) style:UITableViewStyleGrouped];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZFDownloadingCell" bundle:nil] forCellReuseIdentifier:@"downloadingCell"];
    [self.mainTableView registerNib:[UINib nibWithNibName:@"ZFDownloadedCell" bundle:nil] forCellReuseIdentifier:@"downloadedCell"];

    [self.mainTableView registerClass:[DownLoadedTableViewCell class] forCellReuseIdentifier:@"downloadedCell"];
    [self.mainTableView registerClass:[DownLoadingTableViewCell class] forCellReuseIdentifier:@"downloadingCell"];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.view addSubview:self.mainTableView];
    
}
-(void)customSegmentClick:(int)witchbtn{
    
}
/** 全部开始 */
- (void)startAll:(UIBarButtonItem *)sender {
    
}
-(void)DownLoadedfinished:(NSString *)FileURL DownloadTask:(NSURLSessionDownloadTask *)DownloadTask{
    [self initData];

}
-(void)DownLoadingProgress:(NSProgress *)progress FilePath:(NSString *)FileURL DownloadTask:(NSURLSessionDownloadTask *)DownloadTask{
    [self initData];
}
/** 全部暂停 */
- (void)pauseAll:(UIBarButtonItem *)sender {
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.downLoadRecodeArray.count < 1) {
        NSLog(@"结束 \n %@ \n",self.downLoadRecodeArray);
    }
    NSArray *downloadArray = self.downLoadRecodeArray[indexPath.section];
    if (downloadArray.count < indexPath.row) {
        NSLog(@"数组越界");
    }
    NSDictionary *downloadDic = downloadArray[indexPath.row];
    if (indexPath.section == 0) {
        DownLoadedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadedCell"];
        [cell setCellInfoWithFileInfo:downloadDic];
        return cell;
    } else if (indexPath.section == 1) {
        DownLoadingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downloadingCell"];
        [cell setCellInfoWithFileInfo:downloadDic];
        cell.DownLoadingTableViewCellBlock = ^(CustomBtnAddObject *Btn) {
            NSLog(@"%@  downloadDic: %@",[Btn.object boolValue]?@"下载":@"暂停",downloadDic);
            NSString *fileurl = downloadDic[@"filePath"];
            fileurl = [fileurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            if ([Btn.object boolValue]) { //yes 下载中
                [[DownLoadMetch shareInstance] ResumeLoadFileWithPath:fileurl Success:^(bool result) {
                    if (!result) {
                        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该任务丢失，请重新下载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertview show];
                        
                        NSMutableArray *array = self.downLoadRecodeArray[1];
                        NSDictionary *dic = array[indexPath.row];
                        NSString *filePath = dic[@"filePath"];
                        [[DownLoadMetch shareInstance] DeledateTaskAndFile:filePath];
                        [array removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                        [tableView reloadData];

                    }
                }];
            }else{
                [[DownLoadMetch shareInstance] StopLoadFileWithPath:fileurl Success:^(bool result) {
                    if (!result) {
                        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该任务丢失，请重新下载" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                        [alertview show];
                        
                        NSMutableArray *array = self.downLoadRecodeArray[1];
                        NSDictionary *dic = array[indexPath.row];
                        NSString *filePath = dic[@"filePath"];
                        [[DownLoadMetch shareInstance] DeledateTaskAndFile:filePath];
                        [array removeObjectAtIndex:indexPath.row];
                        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                        
                        [tableView reloadData];
                    }
                }];
            }
        };
        return cell;
    }else{
        UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"KCell"];
        return cell;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(UIView *)SetHeadviewInfo:(NSDictionary *)Dic{
    UIView *headview = [[UIView alloc] init];
    return headview;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.downLoadRecodeArray.count==0||self.downLoadRecodeArray == nil){
        return 0;
    }
    NSArray *sectionArray = self.downLoadRecodeArray[section];
    return sectionArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellheight;
    if (indexPath.section == 0) {
        cellheight = [DownLoadedTableViewCell CellHeight];
    }else{
        cellheight = [DownLoadingTableViewCell CellHeight];
    }
        return  cellheight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.downLoadRecodeArray == nil||self.downLoadRecodeArray.count < section||self.downLoadRecodeArray.count == 0){
        NSLog(@"height for header   array  nil");
        return 0;
    }

    NSArray *downedArray = self.downLoadRecodeArray[section];
    if (downedArray.count <= 0) {
        return 1;
    }else{
        return Macro_AutoWidth_7p(30);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        NSMutableArray *array = self.downLoadRecodeArray[0];
        NSDictionary *dic = array[indexPath.row];
        NSString *filePath = dic[@"filePath"];
        [[DownLoadMetch shareInstance] DeledateTaskAndFile:filePath];
        [array removeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 1) {
        NSMutableArray *array = self.downLoadRecodeArray[1];
        NSDictionary *dic = array[indexPath.row];
        NSString *filePath = dic[@"filePath"];
        [[DownLoadMetch shareInstance] DeledateTaskAndFile:filePath];
        [array removeObjectAtIndex:indexPath.row];
    }
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.downLoadRecodeArray == nil||self.downLoadRecodeArray.count == 0) {
        NSLog(@"titleforHeader   array   nil");
        return @"";
    }
    NSArray *sectionArray = self.downLoadRecodeArray[section];
    if (sectionArray.count > 0 ) {
        if (section == 0) {
            return @"下载完成";
        }else{
            return @"下载中";
        }
    }
    return @"";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)initData
{
    [self.lock lock];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *downloadingMutableArray = [[NSMutableArray alloc] init];
        [downloadingMutableArray addObjectsFromArray:[[DownLoadMetch shareInstance] GetDownLoadingFileIsSingleMusic:YES]];
        [downloadingMutableArray addObjectsFromArray:[[DownLoadMetch shareInstance] GetDownLoadingFileIsSingleMusic:NO]];
        
        NSMutableArray *downLoadedMutableArray = [[NSMutableArray alloc] init];
        [downLoadedMutableArray addObjectsFromArray:[[DownLoadMetch shareInstance] GetDownLoadedFileIsSingleMusic:YES]];
        [downLoadedMutableArray addObjectsFromArray:[[DownLoadMetch shareInstance] GetDownLoadedFileIsSingleMusic:NO]];
        
        self.downLoadRecodeArray = @[].mutableCopy;
        [self.downLoadRecodeArray addObject:downLoadedMutableArray];
        [self.downLoadRecodeArray addObject:downloadingMutableArray];
        
        if (self.downLoadRecodeArray == nil || self.downLoadRecodeArray.count == 0) {
            NSLog(@"initData  array == nil");
            return;
        }
            [self.mainTableView reloadData];
        });
    [self.lock unlock];
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
