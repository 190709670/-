//
//  MainPageViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/5/25.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "MainPageViewController.h"
#import "CustomSegmentView.h"
#import "CustonBtnTitleView.h"
#import "MainPageSingleMusicTableViewCell.h"
#import "RequestURLDefine.h"
#import "NetWorkingRequest.h"
#import "AlbumTableViewCell.h"
#import "PoinoTableViewCell.h"
#import "PlayViewController.h"
#import "AlbumDetailListViewController.h"
#import "SearchPageViewController.h"
#import "KnowledgePointListViewController.h"
#import "BaseNavigationViewController.h"
#import "LoginMainViewController.h"

typedef enum{
    ShowType_SingleType = 0,
    ShowType_AlbumType,
    ShowType_Piano
}ShowType;
@interface MainPageViewController ()<UITableViewDelegate,UITableViewDataSource,CustomSegmentViewDelegate,CustonBtnTitleViewDelegate,UIWebViewDelegate,LoginDelegate>
@property (nonatomic, retain) CustomSegmentView *segmentView;
@property (nonatomic, retain) CustonBtnTitleView *btnTitleView;
@property (nonatomic, retain) CustonBtnTitleView *DifficultyBtnView;
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) UIWebView *WallTagView;
@property (nonatomic, retain) NSArray *stylecategoryArray;
@property (nonatomic, retain) NSArray *DifficultyArray;
@property (nonatomic, retain) __block NSMutableArray *MusicInfoArray;
@property (nonatomic, assign) ShowType MainTableViewType;
@property (nonatomic, retain) NSDictionary *selectedSubType;    //选择的字类型
@property (nonatomic, retain) NSDictionary *selectedHardLevelDic; //选择的难度
@property (nonatomic, assign) NSInteger pagenumber;
@property (nonatomic, strong) UIImageView *userHeaderImageView;
@property (nonatomic, retain) PeopleInfoModel *peopleInfo;
@property (nonatomic, retain) LoginMainViewController *loginVC;
@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationView];
    [self setObject];
    [self.view setBackgroundColor:Macro_ViewBackColor];
    [self RequestNetWorking]; //获取单曲曲库title信息
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [BaseMethod CartVCUpDateCartNumber];
    //更新用户信息
    [[NetWorkingRequest share_MainViewRequest] SendFindByOauth_RequestSuccess:^(PeopleInfoModel *peopleinfo) {
        [BaseMethod hideAllHudsInView:self.view];
        if (peopleinfo.success) {
            self.peopleInfo = peopleinfo;
            PeopleInfoDataModel *userinfo = self.peopleInfo.data;
            [self.userHeaderImageView setImageWithURL:[NSURL URLWithString:userinfo.icon] placeholderImage:[UIImage imageNamed:@"userHeaderImage"]];
        }else{
            [self.userHeaderImageView setImage:[UIImage imageNamed:@"userHeaderImage"]];
            self.peopleInfo = nil;
        }
    } failure:^(NSError *error) {
        [self.userHeaderImageView setImage:[UIImage imageNamed:@"userHeaderImage"]];
        self.peopleInfo = nil;
    }];
}
-(void)setNavigationView{
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_home_logo"] style:UIBarButtonItemStyleDone target:self action:nil];
     [leftBarButton setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 0,Macro_AutoWidth_7p(200), Macro_AutoWidth_7p(30))];
    [searchBtn setTitle:@"快速搜索教程、歌曲" forState:UIControlStateNormal];
    [searchBtn setBackgroundColor:[UIColor whiteColor]];
    searchBtn.layer.cornerRadius = Macro_AutoWidth_7p(15);
    [searchBtn setImage:[UIImage imageNamed:@"per_search"] forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = searchBtn;
    
    self.userHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             0,
                                                                             Macro_AutoWidth_7p(35),
                                                                             Macro_AutoWidth_7p(35))];
    self.userHeaderImageView.layer.cornerRadius = Macro_AutoWidth_7p(35)/2.0;
    self.userHeaderImageView.layer.masksToBounds = YES;
    [self.userHeaderImageView setImage:[UIImage imageNamed:@"userHeaderImage"]];
    [self.userHeaderImageView setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *userHeaderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [userHeaderButton setFrame:CGRectMake(0,
                                          0,
                                          Macro_AutoWidth_7p(35),
                                          Macro_AutoWidth_7p(35))];
    [userHeaderButton addTarget:self action:@selector(userHeaderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    userHeaderButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    userHeaderButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
    [userHeaderButton addSubview:self.userHeaderImageView];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userHeaderButton];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

-(void)setObject{
    self.segmentView = [[CustomSegmentView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           KWidth,
                                                                           Macro_AutoWidth_7p(40))];
//    [self.segmentView setTitles:@[@"单曲曲库",@"专辑教程",@"钢琴入门"] withColor:ThemeRedColor font:[UIFont systemFontOfSize:15]];
    [self.segmentView setTitles:@[@"单曲曲库"] withColor:ThemeRedColor font:[UIFont systemFontOfSize:15]];
    self.segmentView.delegate = self;
    [self.segmentView setBackgroundColor:[UIColor whiteColor]];
    UIImageView *segmentViewLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                 Macro_AutoWidth_7p(40) - 1,
                                                                                 KWidth,
                                                                                 1)];
    [segmentViewLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.segmentView addSubview:segmentViewLine];
    [self.view addSubview:self.segmentView];
    
    self.btnTitleView = [[CustonBtnTitleView alloc] initWithFrame:CGRectMake(0,
                                                                             CGRectGetMaxY(self.segmentView.frame),
//                                                                             0,
                                                                             KWidth,
                                                                             Macro_AutoWidth_7p(30))];
    UIImageView *btntitleLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, Macro_AutoWidth_7p(30) - 1, KWidth, 1)];
    [btntitleLine setBackgroundColor:[UIColor lightGrayColor]];
    [self.btnTitleView addSubview:btntitleLine];
    
    [self.btnTitleView setBackgroundColor:[UIColor whiteColor]];
    self.btnTitleView.delegate = self;
    [self.btnTitleView setImagePostionTop:NO];
    self.btnTitleView.tag = 1;
    [self.view addSubview:self.btnTitleView];
    
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       CGRectGetMaxY(self.btnTitleView.frame),
                                                                       KWidth,
                                                                       Macro_AutoWidth_7p(290)) style:UITableViewStyleGrouped];
    self.MainTableView.delegate = self;
    self.MainTableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    self.MainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pagenumber = 1;
        [weakSelf customSegmentClick:weakSelf.MainTableViewType];
    }];
    self.MainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         [weakSelf customSegmentClick:weakSelf.MainTableViewType];
    }];
    [self.view addSubview:self.MainTableView];
    
    self.DifficultyBtnView = [[CustonBtnTitleView alloc] initWithFrame:CGRectMake(0,
                                                                                 CGRectGetMaxY(self.MainTableView.frame),
                                                                                 Macro_ScreenWidth,
                                                                                 Macro_AutoWidth_7p(35))];
  //  [self.DifficultyBtnView setBackgroundColor:[UIColor cyanColor]];
    UIImageView *diffLineTop = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Macro_ScreenWidth, 1)];
    [diffLineTop setBackgroundColor:[UIColor lightGrayColor]];
    [self.DifficultyBtnView addSubview:diffLineTop];
    
    UIImageView *diffLineBottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, Macro_AutoWidth_7p(35)-1, Macro_ScreenWidth, 1)];
    [diffLineBottom setBackgroundColor:[UIColor lightGrayColor]];
    [self.DifficultyBtnView addSubview:diffLineBottom];
    
    [self.DifficultyBtnView setBackgroundColor:[UIColor whiteColor]];
    self.DifficultyBtnView.delegate = self;
    self.DifficultyBtnView.tag = 2;
    [self.DifficultyBtnView setImagePostionTop:YES];
    [self.view addSubview:self.DifficultyBtnView];
    
    self.WallTagView = [[UIWebView alloc] initWithFrame:CGRectMake(0,
                                                                   CGRectGetMaxY(self.DifficultyBtnView.frame),
                                                                   KWidth,
                                                                   KHeight - CGRectGetMaxY(self.DifficultyBtnView.frame))];
    self.WallTagView.delegate = self;
    [self.view addSubview:self.WallTagView];
    
    self.MainTableViewType = ShowType_SingleType;
    self.pagenumber = 1;
}
-(void)GetWallTag{
    [[NetWorkingRequest share_MainViewRequest] RequestWallTagSuccess:^(BaseModel *info) {
        if(info.success){
            [self.MainTableView setFrame:CGRectMake(0,
                                                    CGRectGetMaxY(self.btnTitleView.frame),
                                                    KWidth,
                                                    self.view.frame.size.height - CGRectGetMaxY(self.btnTitleView.frame) - Macro_AutoWidth_7p(270))];
            [self.DifficultyBtnView setFrame:CGRectMake(0,
                                                        CGRectGetMaxY(self.MainTableView.frame),
                                                        KWidth,
                                                        self.DifficultyBtnView.frame.size.height)];
            [self.WallTagView setFrame:CGRectMake(0,
                                                  CGRectGetMaxY(self.DifficultyBtnView.frame),
                                                  KWidth,
                                                  Macro_AutoWidth_7p(235))];
            [self.WallTagView loadHTMLString:info.message baseURL:nil];
        }else{
            [self.MainTableView setFrame:CGRectMake(0,
                                                    CGRectGetMaxY(self.btnTitleView.frame),
                                                    KWidth,
                                                    KHeight - CGRectGetMaxY(self.btnTitleView.frame))];
            [self.WallTagView setFrame:CGRectMake(0, CGRectGetMaxY(self.MainTableView.frame), KWidth,0)];
        }
    } failure:^(NSError *error) {
        NSLog(@"error: %@",error);
    }];
}
-(void)RequestNetWorking{
    dispatch_queue_t queue = dispatch_queue_create("RequestQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
        [[NetWorkingRequest share_MainViewRequest] SendStyleCategoryFindAllSuccess:^(BaseModel *info) {
            [BaseMethod hideAllHudsInView:self.view];
            if(info.success){
                self.stylecategoryArray = info.data;
                self.selectedSubType = self.stylecategoryArray[0];
                [self.btnTitleView setWithTitleArray:self.stylecategoryArray];
            }
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            [BaseMethod hideAllHudsInView:self.view];
            [BaseMethod showToast:error.description hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            dispatch_group_leave(group);
        }];
    
     dispatch_group_enter(group);
        //获取难度等级
        [[NetWorkingRequest share_MainViewRequest] SendRankFindAllSuccess:^(BaseModel *info) {
            self.DifficultyArray = [NSArray arrayWithArray:info.data];
            [self.DifficultyBtnView setWithTitleArray:self.DifficultyArray];
            self.selectedHardLevelDic = self.DifficultyArray[0];
            dispatch_group_leave(group);
        } failure:^(NSError *error) {
            dispatch_group_leave(group);

        }];
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hardLevelChoose:self.selectedHardLevelDic subtypeDic:self.selectedSubType witchBtn:self.MainTableViewType];
        });
    });

}

- (void)userHeaderButtonClick:(id)sender{
    if(self.peopleInfo == nil){
        if (self.loginVC == nil) {
            self.loginVC = [[LoginMainViewController alloc] init];
            self.loginVC.delegate = self;
        }
        BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:self.loginVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        [self.tabBarController setSelectedIndex:3];
    }
}
-(void)LoginSuccess:(BOOL)suc{
    [self.tabBarController setSelectedIndex:0];
}
#pragma mark 子类别选择Delegate
-(void)customSegmentClick:(int)witchbtn{ //父类别
    [self hardLevelChoose:self.selectedHardLevelDic subtypeDic:self.selectedSubType witchBtn:witchbtn];
}
-(void)CustonBtnTitleView_BtnClick:(id)clickinfo titleview:(CustonBtnTitleView *)CustonBtnTitleView{ //子类别
    self.pagenumber = 1;
    if (CustonBtnTitleView.tag == 1) {
         self.selectedSubType = clickinfo;
        [self.DifficultyBtnView SelectBtnPosition:0];
        return;
    }else{
        self.selectedHardLevelDic = clickinfo;
    }
   
     [self hardLevelChoose:self.selectedHardLevelDic subtypeDic:self.selectedSubType witchBtn:self.MainTableViewType];
}
-(void)ShowBtnInfo:(id)ShowBtnInfo{
    self.pagenumber = 1;
    self.selectedSubType = ShowBtnInfo;
    [self hardLevelChoose:self.selectedHardLevelDic subtypeDic:self.selectedSubType witchBtn:self.MainTableViewType];
    
    
    dispatch_source_t gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
}
//难度选择
-(void)hardLevelChoose:(NSDictionary *)hardLevelDic subtypeDic:(NSDictionary *)subTypeDic witchBtn:(NSInteger)witchBtn{
    NSString *account = [BaseMethod getUserAccount];
    
    if(self.MusicInfoArray == nil){
        self.MusicInfoArray = [[NSMutableArray alloc]init];
    };
    if (self.MainTableViewType != witchBtn) {
        self.MainTableViewType = witchBtn;
        self.pagenumber = 1;
        [self.MusicInfoArray removeAllObjects];
    }
    __weak typeof(self) weakSelf = self;
    switch (witchBtn) {
        case 0:{
            self.MainTableViewType = ShowType_SingleType;
            [self.btnTitleView setHidden:NO];
            [self.WallTagView setHidden:NO];
            [self.DifficultyBtnView setHidden:NO];
            [self.MainTableView setFrame:CGRectMake(0,
                                                    CGRectGetMaxY(self.btnTitleView.frame),
                                                    KWidth,
                                                    self.view.frame.size.height - CGRectGetMaxY(self.btnTitleView.frame) - Macro_AutoWidth_7p(270))];
            NSString *categorID =  subTypeDic[@"code"]?subTypeDic[@"code"]:@"";
            NSString *rankID = hardLevelDic[@"code"]?hardLevelDic[@"code"]:@"";
            [[NetWorkingRequest share_MainViewRequest] RequestHotsongListWithCategorId:categorID rank:rankID Account:account PageNo:self.pagenumber Success:^(BaseModel *info) {
                if (self.pagenumber == 1) {
                    [weakSelf.MusicInfoArray removeAllObjects];
                    if([info.data isKindOfClass:[NSArray class]]){
                    [weakSelf.MusicInfoArray addObjectsFromArray:info.data];
                    }else{
                        NSLog(@"%@ \n 返回数据错误",NSStringFromSelector(_cmd));
                    }
                }else{
                    [weakSelf.MusicInfoArray addObjectsFromArray:info.data];
                }
                self.pagenumber = self.pagenumber+1;
                [weakSelf.MainTableView.mj_header endRefreshing];
                [weakSelf.MainTableView.mj_footer endRefreshing];
                [weakSelf.MainTableView reloadData];
            } failure:^(NSError *error) {
            }];
            
            //只有在单曲中有标签墙
            [self GetWallTag];
            
        }break;
        case 1:{
            self.MainTableViewType = ShowType_AlbumType;
            [self.btnTitleView setHidden:YES];
            [self.WallTagView setHidden:YES];
            [self.DifficultyBtnView setHidden:YES];
            [self.MainTableView setFrame:CGRectMake(0,
                                                    CGRectGetMaxY(self.segmentView.frame) + Macro_AutoWidth_7p(10),
                                                    KWidth,
                                                    CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.segmentView.frame) - Macro_AutoWidth_7p(10))];
            [[NetWorkingRequest share_MainViewRequest] SendAlbumListPageNo:self.pagenumber Account:account Success:^(BaseModel *info) {
                if (self.pagenumber == 1) {
                    [weakSelf.MusicInfoArray removeAllObjects];
                    [weakSelf.MusicInfoArray addObjectsFromArray:info.data];
                }else{
                    [weakSelf.MusicInfoArray addObjectsFromArray:info.data];
                }
                self.pagenumber = self.pagenumber+1;
                //  weakSelf.MusicInfoArray = info.data;
                [weakSelf.MainTableView.mj_header endRefreshing];
                [weakSelf.MainTableView.mj_footer endRefreshing];
                
                [weakSelf.MainTableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }break;
        case 2:{
            self.MainTableViewType = ShowType_Piano;
            [self.btnTitleView setHidden:YES];
            [self.WallTagView setHidden:YES];
             [self.DifficultyBtnView setHidden:YES];
            [self.MainTableView setFrame:CGRectMake(0,
                                                    CGRectGetMaxY(self.segmentView.frame) + Macro_AutoWidth_7p(10),
                                                    KWidth,
                                                    CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.segmentView.frame) - Macro_AutoWidth_7p(10))];
            [[NetWorkingRequest share_MainViewRequest] SendKnowledgeSchemaListPageNo:self.pagenumber Success:^(BaseModel *info) {
                if (self.pagenumber == 1) {
                    [weakSelf.MusicInfoArray removeAllObjects];
                    [weakSelf.MusicInfoArray addObjectsFromArray:info.data];
                }else{
                    [weakSelf.MusicInfoArray addObjectsFromArray:info.data];
                }
                self.pagenumber = self.pagenumber+1;
                // weakSelf.MusicInfoArray = info.data;
                [weakSelf.MainTableView.mj_header endRefreshing];
                [weakSelf.MainTableView.mj_footer endRefreshing];
                
                [weakSelf.MainTableView reloadData];
            } failure:^(NSError *error) {
                
            }];
        }break;
        default:
            break;
    }
    
    [self.MainTableView reloadData];
}

-(void)searchBtnClick:(id)sender{
    SearchPageViewController *searchPageVC = [[SearchPageViewController alloc] init];
    [searchPageVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:searchPageVC animated:YES];
    
}
 

#pragma mark webviewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"request.url : %@",request.URL);
    NSString *requestString = request.URL.absoluteString;
    NSRange range = [requestString rangeOfString:@"YOUXIU_Search"];
    if (range.location > 0 && range.location < requestString.length) {
        NSString *schemeurl = [requestString substringFromIndex:range.location];
        NSString *keyword = [schemeurl substringFromIndex:([schemeurl rangeOfString:@"KeyWord="].location + [schemeurl rangeOfString:@"KeyWord="].length)];
        NSLog(@"keyword : %@",keyword);
        
        SearchPageViewController *searchPageVC = [[SearchPageViewController alloc] init];
        [searchPageVC setHidesBottomBarWhenPushed:YES];
        [searchPageVC.searchBar setText:[keyword stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        [self.navigationController pushViewController:searchPageVC animated:YES];
        
        
    }
    return YES;
}
#pragma mark TableVewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.MainTableViewType) {
        case ShowType_SingleType:
        {
            [self SingleMusicSelectWithIndex:indexPath isWXP:YES];
        }break;
        case ShowType_AlbumType:
        {
            [self AlbumSelectWithIndex:indexPath];
        }break;
        case ShowType_Piano:
        {
            [self PoinoSelectWithIndex:indexPath];
        }break;
        default:
            break;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.MainTableViewType) {
        case ShowType_SingleType:{
         return  [self SingleCellInitWithIndexPath:indexPath tableview:tableView];
        }break;
        case ShowType_AlbumType:{
          return  [self AlbumTableViewCellInitWithIndexPath:indexPath tableview:tableView];
        }break;
        case ShowType_Piano:{
          return  [self PoinoTableViewCellInitWithIndexPath:indexPath tableview:tableView];
        }
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(MainPageSingleMusicTableViewCell *)SingleCellInitWithIndexPath:(NSIndexPath *)indexPath tableview:(UITableView *)tableView{
    NSString *KCell = @"SingleMusicCell";
    MainPageSingleMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[MainPageSingleMusicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    __weak typeof(self) weakSelf = self;
    __block NSMutableDictionary *dic = self.MusicInfoArray[indexPath.row];
    [cell setSingleMusicWithInfo:dic];
    __weak MainPageSingleMusicTableViewCell *thisCell = cell;
    cell.addToCartsBlock = ^(MainPageSingleMusicTableViewCell *result) {
        NSString *account = [BaseMethod getUserAccount];
        NSString *songid = dic[@"id"];
        [[NetWorkingRequest share_MainViewRequest] SendCartDoAddAccount:account GoodsID:songid Type:0 Success:^(BaseModel *info) {
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
            if (info.success) {
                [thisCell setSingleAddCartStatus:1];
            }
        } failure:^(NSError *error) {
            [BaseMethod showToast:[error description] hideAfterSecond:2 inView:self.view];
        }];
    };
    cell.wxpBtnClickBlock = ^(MainPageSingleMusicTableViewCell *result) {
        [weakSelf SingleMusicSelectWithIndex:indexPath isWXP:YES];

    };
    cell.jpBtnClickBlock = ^(MainPageSingleMusicTableViewCell *result) {
        [weakSelf SingleMusicSelectWithIndex:indexPath isWXP:NO];
    };
    return cell;
}
-(AlbumTableViewCell *)AlbumTableViewCellInitWithIndexPath:(NSIndexPath *)indexPath tableview:(UITableView *)tableView{
    NSString *KCell = @"AlbumTableViewCell";
    AlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[AlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    }
    NSDictionary *dic = self.MusicInfoArray[indexPath.row];
    [cell setAlbumInfoWithData:dic];
    return cell;
}
-(PoinoTableViewCell *)PoinoTableViewCellInitWithIndexPath:(NSIndexPath *)indexPath tableview:(UITableView *)tableView{
    NSString *KCell = @"PoinoTableViewCell";
    PoinoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
    if (cell == nil) {
        cell = [[PoinoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    NSDictionary *dic = self.MusicInfoArray[indexPath.row];
    [cell setPoinoTableViewCellWithDicInfo:dic];
    return cell;
}
//单曲曲库，点击
-(void)SingleMusicSelectWithIndex:(NSIndexPath *)indxPath isWXP:(BOOL)isWXP{
   NSDictionary *dic = self.MusicInfoArray[indxPath.row];
    NSDictionary *MusicDic = dic[@"music"];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    playVC.MusicID = MusicDic[@"id"];
    [playVC setHidesBottomBarWhenPushed:YES];
    [playVC.navigationItem setTitle:dic[@"name"]];
    playVC.hotsongDic = dic;
    playVC.isWXP = isWXP;
    playVC.isSingleMusic = YES;
    playVC.showTuPu = YES;
    [self.navigationController pushViewController:playVC animated:YES];
}
//专辑教程，点击
-(void)AlbumSelectWithIndex:(NSIndexPath *)indxPath{
    NSDictionary *dic = self.MusicInfoArray[indxPath.row];
    AlbumDetailListViewController *AlbumVC = [[AlbumDetailListViewController alloc] init];
    AlbumVC.AlbumID = dic[@"id"];
    [AlbumVC setHidesBottomBarWhenPushed:YES];
    AlbumVC.AlbumInfo = dic;
    [self.navigationController pushViewController:AlbumVC animated:YES];
}
//钢琴入门，点击
-(void)PoinoSelectWithIndex:(NSIndexPath *)indxPath{
    NSDictionary *dic = self.MusicInfoArray[indxPath.row];
    NSString *schemaId = dic[@"id"];
    KnowledgePointListViewController *vc = [[KnowledgePointListViewController alloc] init];
    [vc.navigationItem setTitle:dic[@"title"]];
    vc.schemaId = schemaId;
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.MusicInfoArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.MainTableViewType) {
        case ShowType_SingleType:
            {
                 return [MainPageSingleMusicTableViewCell CellHeight];
            }
            break;
        case ShowType_AlbumType:
        {
            return [AlbumTableViewCell CellHeight];
        }
            break;
        case ShowType_Piano:
        {
            return [PoinoTableViewCell CellHeight];
        }
            break;
        default:
            break;
    }
   
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
