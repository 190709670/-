//
//  AlbumDetailListViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/6/4.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "AlbumDetailListViewController.h"
#import "CustomBtnAddObject.h"
#import "NetWorkingRequest.h"
#import "PlayViewController.h"
#import "OrderPayViewController.h"
#import "FilePatchMetch.h"
#import "ScoreView.h"
@interface AlbumDetailListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, retain) UITableView *MainTableView;
@property (nonatomic, retain) NSArray *ListArray;
@property (nonatomic, retain) UIButton *BuyBtn;
@property (nonatomic, retain) UIButton *AddToCartBtn;
@end

@implementation AlbumDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"专辑";
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isLocal){
        NSFileManager *fileManger = [NSFileManager defaultManager];
        NSString *UnZipPath = [[FilePatchMetch getUserUnZipFilePatch] stringByAppendingPathComponent:@"FileType_AlbumMusic"];
        NSString *filefolderPath = [UnZipPath stringByAppendingString:[NSString stringWithFormat:@"/%@",self.albumName]];
        NSArray *MusicNameArray = [fileManger contentsOfDirectoryAtPath:filefolderPath error:nil];
        
        self.ListArray = MusicNameArray;
    }else{
        [[NetWorkingRequest share_MainViewRequest] SendAlbumInfoMusicID:self.AlbumID Success:^(BaseModel *info) {
            NSLog(@"info : %@",info);
            if (info.success) {
                self.ListArray = info.data[@"lines"];
                [self.MainTableView reloadData];
            }else{
                [BaseMethod showToast:info.message hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.view];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)setObject{
    self.MainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                       0,
                                                                       KWidth,
                                                                       KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame) -50) style:UITableViewStyleGrouped];
    self.MainTableView.dataSource = self;
    self.MainTableView.delegate = self;
    [self.view addSubview:self.MainTableView];
    
    [self.BuyBtn setFrame:CGRectMake(0,
                                     KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 50,
                                     KWidth/2.0,
                                     50)];
    
    [self.AddToCartBtn setFrame:CGRectMake(KWidth/2.0,
                                           KHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 50,
                                           KWidth/2.0,
                                           50)];
    [self.view addSubview:self.AddToCartBtn];
    [self.view addSubview:self.BuyBtn];
    
    BOOL cartHas = [self.AlbumInfo[@"cartHas"] boolValue];
    BOOL orderHas = [self.AlbumInfo[@"orderHas"] boolValue];
    if (self.isLocal) {
        [self.BuyBtn setEnabled:NO];
        [self.AddToCartBtn setEnabled:NO];
        [self.BuyBtn setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [self.BuyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.AddToCartBtn setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
    }else{
        if (orderHas) {
            [self.BuyBtn setEnabled:NO];
            [self.AddToCartBtn setEnabled:NO];
            [self.BuyBtn setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
            [self.BuyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.AddToCartBtn setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
        }else if (cartHas){
            [self.BuyBtn setEnabled:YES];
            [self.AddToCartBtn setEnabled:NO];
            [self.BuyBtn setBackgroundColor:[UIColor whiteColor]];
            [self.BuyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.AddToCartBtn setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
        }else{
            [self.BuyBtn setEnabled:YES];
            [self.AddToCartBtn setEnabled:YES];
            [self.BuyBtn setBackgroundColor:[UIColor whiteColor]];
            [self.BuyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.AddToCartBtn setBackgroundColor:[UIColor whiteColor]];
        }
    }
}

#pragma mark TableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && !self.isLocal) {
        UITableViewCell *tableviewcell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeaderCell"];
        [tableviewcell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10),
                                                                          Macro_AutoWidth_7p(10),
                                                                          Macro_AutoWidth_7p(105),
                                                                          Macro_AutoWidth_7p(105))];
        icon.layer.cornerRadius = 5;
        icon.layer.masksToBounds = YES;
        
        UILabel *titlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(icon.frame) + Macro_AutoWidth_7p(5),
                                                                      CGRectGetMinY(icon.frame),
                                                                      Macro_AutoWidth_7p(280),
                                                                      Macro_AutoWidth_7p(20))];
        [titlabel setFont:[UIFont systemFontOfSize:14]];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titlabel.frame),
                                                                          CGRectGetMaxY(titlabel.frame),
                                                                          Macro_AutoWidth_7p(280),
                                                                          Macro_AutoWidth_7p(35))];
        contentLabel.numberOfLines = 2;
        [contentLabel setFont:[UIFont systemFontOfSize:14]];
        
        ScoreView *hardLevelView = [[ScoreView alloc] initWithFrame:CGRectMake(CGRectGetMinX(titlabel.frame),
                                                                               CGRectGetMaxY(contentLabel.frame) + Macro_AutoWidth_7p(5),
                                                                               Macro_AutoWidth_7p(130),
                                                                               Macro_AutoWidth_7p(20))];
        
        ScoreView *recommendView = [[ScoreView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hardLevelView.frame) + Macro_AutoWidth_7p(10),
                                                                               CGRectGetMaxY(contentLabel.frame) + Macro_AutoWidth_7p(5),
                                                                               Macro_AutoWidth_7p(130),
                                                                               Macro_AutoWidth_7p(20))];
        
        UILabel *marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titlabel.frame),
                                                                              CGRectGetMaxY(hardLevelView.frame) + Macro_AutoWidth_7p(10),
                                                                              Macro_AutoWidth_7p(100),
                                                                              Macro_AutoWidth_7p(20))];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hardLevelView.frame) + Macro_AutoWidth_7p(10),
                                                                        CGRectGetMaxY(hardLevelView.frame) + Macro_AutoWidth_7p(10),
                                                                        Macro_AutoWidth_7p(100),
                                                                        Macro_AutoWidth_7p(20))];
        
        [tableviewcell.contentView addSubview:icon];
        [tableviewcell.contentView addSubview:titlabel];
        [tableviewcell.contentView addSubview:contentLabel];
        [tableviewcell.contentView addSubview:hardLevelView];
        [tableviewcell.contentView addSubview:recommendView];
        [tableviewcell.contentView addSubview:marketPriceLabel];
        [tableviewcell.contentView addSubview:priceLabel];
        
        NSString *marketPriceString = [NSString stringWithFormat:@"原价:%.1f",[self.AlbumInfo[@"marketprice"] floatValue]];
        NSMutableAttributedString *marketAttriString = [[NSMutableAttributedString alloc] initWithString:marketPriceString];
        [marketAttriString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlinePatternSolid | NSUnderlineStyleSingle] range:NSMakeRange(0, marketPriceString.length)];
        [marketAttriString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, marketPriceString.length)];
        [marketAttriString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, marketPriceString.length)];
        
        NSString *priceString = [NSString stringWithFormat:@"价格:%.1f",[self.AlbumInfo[@"price"] floatValue]];
        NSMutableAttributedString *attributeStirng = [[NSMutableAttributedString alloc] initWithString:priceString];
        [attributeStirng addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
        [attributeStirng addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 3)];
        
        [attributeStirng addAttribute:NSForegroundColorAttributeName value:ThemeRedColor range:NSMakeRange(3, priceString.length - 3)];
        [attributeStirng addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(3, priceString.length - 3)];
        
        [icon setImageWithURL:[NSURL URLWithString:self.AlbumInfo[@"cover"]]];
        [titlabel setText:self.AlbumInfo[@"name"]];
        [contentLabel setText:self.AlbumInfo[@"content"]];
        [hardLevelView setScroreWithTitle:@"难度:" Scroe:[self.AlbumInfo[@"difficult"] integerValue]];
        [recommendView setScroreWithTitle:@"推荐度:" Scroe:[self.AlbumInfo[@"referral"] integerValue]];
        [marketPriceLabel setAttributedText:marketAttriString];
        [priceLabel setAttributedText:attributeStirng];
        
        return tableviewcell;
    }else{
        static NSString *KCell = @"KCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCell];
            UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(Macro_AutoWidth_7p(10), 0, Macro_AutoWidth_7p(200), Macro_AutoWidth_7p(50))];
            [titleLabel1 setFont:[UIFont systemFontOfSize:14]];
            titleLabel1.tag = 1;
            
            CustomBtnAddObject *wxpplayBtn = [CustomBtnAddObject buttonWithType:UIButtonTypeCustom];
            [wxpplayBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(140),
                                            Macro_AutoWidth_7p(5),
                                            Macro_AutoWidth_7p(20),
                                            Macro_AutoWidth_7p(20))];
            [wxpplayBtn addTarget:self action:@selector(WxpPlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            wxpplayBtn.tag = 2;
            [wxpplayBtn setBackgroundImage:[UIImage imageNamed:@"course_video"] forState:UIControlStateNormal];
            
            UILabel *wxpLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(wxpplayBtn.frame) - Macro_AutoWidth_7p(30),
                                                                          CGRectGetMaxY(wxpplayBtn.frame),
                                                                          CGRectGetWidth(wxpplayBtn.frame) + Macro_AutoWidth_7p(60),
                                                                          Macro_AutoWidth_7p(20))];
            [wxpLabel setText:@"五线谱视频"];
            [wxpLabel setTextAlignment:NSTextAlignmentCenter];
            [wxpLabel setFont:[UIFont systemFontOfSize:12]];
            
            CustomBtnAddObject *jpplayBtn = [CustomBtnAddObject buttonWithType:UIButtonTypeCustom];
            [jpplayBtn setFrame:CGRectMake(KWidth - Macro_AutoWidth_7p(60),
                                           Macro_AutoWidth_7p(5),
                                           Macro_AutoWidth_7p(20),
                                           Macro_AutoWidth_7p(20))];
            [jpplayBtn addTarget:self action:@selector(JPPlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            jpplayBtn.tag = 3;
            [jpplayBtn setBackgroundImage:[UIImage imageNamed:@"course_video"] forState:UIControlStateNormal];
            UILabel *jpLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(jpplayBtn.frame) - Macro_AutoWidth_7p(20),
                                                                         CGRectGetMaxY(jpplayBtn.frame),
                                                                         CGRectGetWidth(jpplayBtn.frame) + Macro_AutoWidth_7p(40),
                                                                         Macro_AutoWidth_7p(20))];
            [jpLabel setText:@"简谱视频"];
            [jpLabel setTextAlignment:NSTextAlignmentCenter];
            [jpLabel setFont:[UIFont systemFontOfSize:12]];
            
            [cell.contentView addSubview:titleLabel1];
            [cell.contentView addSubview:wxpplayBtn];
            [cell.contentView addSubview:jpplayBtn];
            [cell.contentView addSubview:wxpLabel];
            [cell.contentView addSubview:jpLabel];
        }
        UILabel *label1 = (UILabel *)[cell viewWithTag:1];
        CustomBtnAddObject *WxpplayBtn = (CustomBtnAddObject *)[cell viewWithTag:2];
        CustomBtnAddObject *JpplayBtn = (CustomBtnAddObject *)[cell viewWithTag:3];
        
        NSString *titleString;
        if (self.isLocal) {
            titleString = [self.ListArray objectAtIndex:indexPath.row];
            WxpplayBtn.object = titleString;
            JpplayBtn.object = titleString;
        }else{
            NSDictionary *dic = [self.ListArray objectAtIndex:indexPath.row - 1];
            titleString = dic[@"musicName"];
            WxpplayBtn.object = dic;
            JpplayBtn.object = dic;
        }
        [label1 setText:titleString.length > 0?titleString:@"未获取到歌曲名"];
        return cell;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isLocal) {
        return self.ListArray.count;
    }else{
        return self.ListArray.count + 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0 && !self.isLocal){
        return Macro_AutoWidth_7p(125);
    }else{
        return Macro_AutoWidth_7p(50);
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)WxpPlayBtnClick:(id)sender{
    CustomBtnAddObject *btn = (CustomBtnAddObject *)sender;
    PlayViewController *playVC = [[PlayViewController alloc] init];
    if(self.isLocal){//本地
        NSString *fileName = btn.object;
        playVC.fileName = fileName;
        [playVC.navigationItem setTitle:fileName];
    }else{
        NSDictionary *dic = btn.object;
        playVC.MusicID = dic[@"musicId"];
        playVC.fileName = dic[@"musicName"];
        [playVC.navigationItem setTitle:dic[@"musicName"]];
    }
    playVC.hotsongDic = nil;
    [playVC setHidesBottomBarWhenPushed:YES];
    playVC.isWXP = YES;
    playVC.isLocalType = self.isLocal;
    playVC.isSingleMusic = NO;
    playVC.showTuPu = YES;
    NSString *UnZipPath = [[FilePatchMetch getUserUnZipFilePatch] stringByAppendingPathComponent:[NSString stringWithFormat:@"FileType_AlbumMusic/%@",self.albumName]];
    
    playVC.UnZipPath =UnZipPath;
    [self.navigationController pushViewController:playVC animated:YES];
}
-(void)JPPlayBtnClick:(id)sender{
    CustomBtnAddObject *btn = (CustomBtnAddObject *)sender;
    PlayViewController *playVC = [[PlayViewController alloc] init];
    if(self.isLocal){//本地
        NSString *fileName = btn.object;
        playVC.fileName = fileName;
        [playVC.navigationItem setTitle:fileName];
    }else{
        NSDictionary *dic = btn.object;
        playVC.MusicID = dic[@"musicId"];
        playVC.fileName = dic[@"musicName"];
        [playVC.navigationItem setTitle:dic[@"musicName"]];
    }
    [playVC setHidesBottomBarWhenPushed:YES];
    playVC.hotsongDic = nil;
    playVC.isWXP = NO;
    playVC.isLocalType = self.isLocal;
    playVC.isSingleMusic = NO;
    playVC.showTuPu = YES;
    NSString *UnZipPath = [[FilePatchMetch getUserUnZipFilePatch] stringByAppendingPathComponent:[NSString stringWithFormat:@"FileType_AlbumMusic/%@",self.albumName]];
    playVC.UnZipPath = UnZipPath;
    [self.navigationController pushViewController:playVC animated:YES];
}
-(void)PlayBtnClick:(id)sender{
    
}
-(void)payBtnClick:(id)sender{
    NSString *account = [BaseMethod getUserAccount];
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendOrderQuickBuyWithAccount:account  songId:self.AlbumID type:@"1" Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
        if(info.success){
            OrderPayViewController *orderpayVC = [[OrderPayViewController alloc] init];
            orderpayVC.sn = info.data[@"sn"];
            [orderpayVC setHidesBottomBarWhenPushed:YES];
            orderpayVC.MusicDic = info.data;
            orderpayVC.isPay = NO;
            [self.navigationController pushViewController:orderpayVC animated:YES];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:self.view];
    }];
}
-(void)AddToCartBtnClick:(id)sender{
    NSString  *account = [BaseMethod getUserAccount];
    if(account.length <= 0 ){
        [BaseMethod showToast:@"请先登录" hideAfterSecond:2 inView:self.view];
        return;
    }
    NSString *songid = self.AlbumID;
    [[NetWorkingRequest share_MainViewRequest] SendCartDoAddAccount:account GoodsID:songid Type:1 Success:^(BaseModel *info) {
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
    } failure:^(NSError *error) {
        [BaseMethod showToast:[error description] hideAfterSecond:2 inView:self.view];
    }];
}
-(UIButton *)BuyBtn{
    if (_BuyBtn == nil) {
        _BuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_BuyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_BuyBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _BuyBtn.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
        _BuyBtn.layer.borderWidth = 1;
    }
    return _BuyBtn;
}
-(UIButton *)AddToCartBtn{
    if (_AddToCartBtn == nil) {
        _AddToCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_AddToCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_AddToCartBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_AddToCartBtn addTarget:self action:@selector(AddToCartBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _AddToCartBtn.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
        _AddToCartBtn.layer.borderWidth = 1;
    }
    return _AddToCartBtn;
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

