//
//  PlayViewController.m
//  YOUXIU
//
//  Created by lihui on 2018/4/10.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "PlayViewController.h"
#import "CustomSegmentView.h"
#import "VideoPlayView.h"
#import "FilePatchMetch.h"
#import "NetWorkingRequest.h"
#import "OrderPayViewController.h"
#import "TuPuViewController.h"
@interface PlayViewController ()<VideoPlayDelegate,CustomSegmentViewDelegate>
@property (nonatomic, strong) CustomSegmentView *segmentView;
@property (nonatomic, strong) VideoPlayView *Videoplayview;
@property (nonatomic, strong) UIWebView *DescriptionWebView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *BuyBtn;
@property (nonatomic, strong) UIButton *AddToCartBtn;
@property (nonatomic, strong) NSDictionary *MusicDic;

@property (nonatomic, strong) UIImageView *iconImageView1;
@property (nonatomic, strong) UIImageView *iconImageView2;
@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) UILabelAddId *descriptionLabel1;
@property (nonatomic, strong) UILabelAddId *descriptionLabel2;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setNavgationBackButton];
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self RequestNetWorkData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.Videoplayview StopPlay];
}
-(void)setObject{
    [self.segmentView setFrame:CGRectMake(0, 0, KWidth, Macro_AutoWidth_7p(45))];
    [self.segmentView setTitles:@[@"五线谱视频",@"简谱视频"] withColor:[UIColor redColor] font:[UIFont systemFontOfSize:14]];
    self.segmentView.delegate = self;
    
    UIImageView *bottomLine1 = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                             CGRectGetMaxY(self.segmentView.frame),
                                                                             KWidth,
                                                                             1)];
    [bottomLine1 setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [self.view addSubview:bottomLine1];
    
    self.Videoplayview = [[VideoPlayView alloc] initWithFrame:CGRectMake(0,
                                                                         CGRectGetMaxY(self.segmentView.frame)+1,
                                                                         KWidth,
                                                                         KWidth*9.00/16 + 110)];
    self.Videoplayview.delegate = self;
    self.Videoplayview.showTuPu = self.showTuPu;
    [self.view addSubview:self.segmentView];
    [self.view addSubview:self.Videoplayview];
    [self.view addSubview:self.DescriptionWebView];
    [self.view addSubview:self.BuyBtn];
    [self.view addSubview:self.AddToCartBtn];
    
    if (self.isLocalType) { //本地播放模式
        [self.DescriptionWebView setFrame:CGRectMake(0,
                                                     CGRectGetMaxY(self.Videoplayview.frame),
                                                     Macro_ScreenWidth,
                                                     Macro_ScreenHeight - CGRectGetMaxY(self.Videoplayview.frame) - 64)];
        [self.BuyBtn setHidden:YES];
        [self.AddToCartBtn setHidden:YES];
        //专辑再隐藏web容器
        if (self.isSingleMusic) {//单曲
            
        }else{//专辑
            [self.DescriptionWebView setHidden:YES];
        }
    }else{
        [self.DescriptionWebView setFrame:CGRectMake(0,
                                                     CGRectGetMaxY(self.Videoplayview.frame),
                                                     Macro_ScreenWidth,
                                                     Macro_ScreenHeight - CGRectGetMaxY(self.Videoplayview.frame) - 50 - 64)];
        [self.BuyBtn setHidden:NO];
        [self.AddToCartBtn setHidden:NO];
        if(self.isSingleMusic){//单曲
            BOOL cartHas = [self.hotsongDic[@"cartHas"] boolValue];
            BOOL orderHas = [self.hotsongDic[@"orderHas"] boolValue];
            
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
        }else{//专辑
            [self.DescriptionWebView setHidden:YES];
            [self.BuyBtn setHidden:YES];
            [self.AddToCartBtn setHidden:YES];
        }
        [self.BuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.equalTo(self.view.mas_left).offset(-1);
            make.right.equalTo(self.view.mas_centerX).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(1);
        }];
        [self.AddToCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.equalTo(self.view.mas_centerX).offset(-1);
            make.right.equalTo(self.view.mas_right).offset(-1);
            make.bottom.equalTo(self.view.mas_bottom).offset(1);
        }];
    }
}
-(void)RequestNetWorkData{
    __weak typeof(self) WeakSelf = self;
    if(self.MusicID == nil){
        if (self.isWXP) {
            [self.segmentView selectSegmentBtn:0];
        }else{
            [self.segmentView selectSegmentBtn:1];
        }
        [WeakSelf customSegmentClick:WeakSelf.segmentView.SelectedBtn];
        return ;
    }
    [BaseMethod showLoading:self.view];
    [[NetWorkingRequest share_MainViewRequest] SendMusicInfoWithMusicID:self.MusicID type:self.isSingleMusic?@"0":@"1" Account:[BaseMethod getUserAccount]  Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:self.view];
        if (info.success) {
            WeakSelf.MusicDic = info.data;
            if (self.isWXP) {
                [self.segmentView selectSegmentBtn:0];
            }else{
                [self.segmentView selectSegmentBtn:1];
            }
            NSString *webviewString = self.MusicDic[@"content"];
            [WeakSelf.DescriptionWebView loadHTMLString:webviewString baseURL:nil];
        }else{
            [BaseMethod showToast:info.message hideAfterSecond:2 inView:WeakSelf.view];
        }
    } failure:^(NSError *error) {
        [BaseMethod hideAllHudsInView:self.view];
        [BaseMethod showToast:error.description hideAfterSecond:2 inView:WeakSelf.view];
    }];
}

-(void)customSegmentClick:(int)witchbtn{
    NSString *videourl ;
    if (self.isLocalType ) {
        NSString *filefolderPath = [self.UnZipPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",self.fileName]];
        NSLog(@"filefolderPath : %@",filefolderPath);
        //久石让 天空之城（原版）-五线谱.mp4
        //久石让 天空之城（原版）五线谱.mp4
        if (witchbtn == 0) {
            //五线谱
            videourl = [filefolderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/video/WXP/%@.mp4",self.fileName]];
        }else{
            videourl = [filefolderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/video/JWP/%@.mp4",self.fileName]];
        }
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        if([fileManager fileExistsAtPath:videourl]){
            [self.Videoplayview SetPlayerIsLocal:YES withVideoURL:videourl];
        }else{
            [BaseMethod showSpecialToastOnWindow:@"对不起，没有视频文件可播放" hideAfterSecond:Macro_ShowLoadingDefaultTime];
            return;
        }
    }else{
        if(self.showTuPu){
            if (witchbtn == 0) {
                videourl = [self.MusicDic valueForKey:@"wxpFreeVideo"];
            }else{
                videourl = [self.MusicDic valueForKey:@"jpFreeVideo"];
            }
        }else{
            videourl = [self.hotsongDic valueForKey:@"explainVideo"];
        }
       
        if (videourl == nil|| videourl.length <= 0) {
            [BaseMethod showSpecialToastOnWindow:@"对不起，没有视频文件可播放" hideAfterSecond:Macro_ShowLoadingDefaultTime];
            return;
        }
        [self.Videoplayview SetPlayerIsLocal:NO withVideoURL:videourl];
    }
    [self.Videoplayview StartPlay];
}

//购买按钮点击
-(void)BuyBtnClick:(id)sender{
     NSString  *account = [BaseMethod getUserAccount];
    if(account.length <= 0 ){
        [BaseMethod showToast:@"请先登录" hideAfterSecond:2 inView:self.view];
        return;
    }
    [BaseMethod showLoading:self.view];
    NSString *songID = self.hotsongDic[@"id"];
    __weak typeof(self) WeakSelf = self;
    [[NetWorkingRequest share_MainViewRequest] SendOrderQuickBuyWithAccount:account  songId:songID type:@"0" Success:^(BaseModel *info) {
        [BaseMethod hideAllHudsInView:WeakSelf.view];
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:WeakSelf.view];
        if(info.success){
            OrderPayViewController *orderpayVC = [[OrderPayViewController alloc] init];
            orderpayVC.sn = info.data[@"sn"];
            orderpayVC.MusicDic = WeakSelf.MusicDic;
            [orderpayVC setHidesBottomBarWhenPushed:YES];
            orderpayVC.isPay = NO;
            [WeakSelf.navigationController pushViewController:orderpayVC animated:YES];
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
    NSString *songid = self.hotsongDic[@"id"];
    [[NetWorkingRequest share_MainViewRequest] SendCartDoAddAccount:account GoodsID:songid Type:0 Success:^(BaseModel *info) {
        [BaseMethod showToast:info.message hideAfterSecond:2 inView:self.view];
    } failure:^(NSError *error) {
        [BaseMethod showToast:[error description] hideAfterSecond:2 inView:self.view];
    }];
}
#pragma makr 隐藏进度条
//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}
#pragma mark videoDelegate
- (void)VideoTuPuClick:(NSString *)BtnName{
   BOOL orderHas =  [self.MusicDic[@"orderHas"] boolValue];
    if (!orderHas&&!self.isLocalType) {
        [BaseMethod showSpecialToastOnWindow:@"对不起，只有购买后才能查看曲谱" hideAfterSecond:Macro_ShowLoadingDefaultTime];
        return;
    }
    NSLog(@"btnname: %@",BtnName);
    NSInteger selectedNumber  = 0;
    if ([BtnName isEqualToString:@"五线谱"]) {
        selectedNumber = 0;
    }else if ([BtnName isEqualToString:@"简五谱"]){
        selectedNumber = 1;
    }else if ([BtnName isEqualToString:@"固定谱"]){
        selectedNumber = 2;
    }else if ([BtnName isEqualToString:@"首调式"]){
        selectedNumber = 3;
    }
    
    NSArray *wxpOfficicalImagesArray;
    NSArray *jpOfficialImagesArray;
    NSArray *gdpOfficicalImagesArray;
    NSArray *sdsOfficicalImagesArray;
    
    if (self.isLocalType) {//本地模式
        NSString *filefolderPath = [self.UnZipPath stringByAppendingString:[NSString stringWithFormat:@"/%@",self.fileName]];
        NSFileManager *fileManger = [NSFileManager defaultManager];
        NSString *wxpPatch = [filefolderPath stringByAppendingPathComponent:@"image/WXP"];//五线谱目录
        NSString *gdpPatch = [filefolderPath stringByAppendingPathComponent:@"image/GDJP"];//五线谱目录
        NSString *jpPatch = [filefolderPath stringByAppendingPathComponent:@"image/JWP"];//五线谱目录
        NSString *sdsPatch = [filefolderPath stringByAppendingPathComponent:@"image/SDJP"];//五线谱目录
        
        NSArray *wxpNameArray = [fileManger contentsOfDirectoryAtPath:wxpPatch error:nil];
        NSArray *gdpNameArray = [fileManger contentsOfDirectoryAtPath:gdpPatch error:nil];
        NSArray *jpNameArray = [fileManger contentsOfDirectoryAtPath:jpPatch error:nil];
        NSArray *sdsNameArray = [fileManger contentsOfDirectoryAtPath:sdsPatch error:nil];

        wxpNameArray = [wxpNameArray sortedArrayUsingSelector:@selector(compare:)];
        gdpNameArray = [gdpNameArray sortedArrayUsingSelector:@selector(compare:)];
        jpNameArray = [jpNameArray sortedArrayUsingSelector:@selector(compare:)];
        sdsNameArray = [sdsNameArray sortedArrayUsingSelector:@selector(compare:)];
        
        wxpOfficicalImagesArray = [self GetPathWithPath:wxpPatch FileNameArray:wxpNameArray];
        jpOfficialImagesArray = [self GetPathWithPath:jpPatch FileNameArray:jpNameArray];
        gdpOfficicalImagesArray = [self GetPathWithPath:gdpPatch  FileNameArray:gdpNameArray];
        sdsOfficicalImagesArray = [self GetPathWithPath:sdsPatch FileNameArray:sdsNameArray];
    }else{//在线模式
        wxpOfficicalImagesArray = [self.MusicDic[@"wxpOfficialImages"] componentsSeparatedByString:@","];
        jpOfficialImagesArray = [self.MusicDic[@"jpOfficialImages"] componentsSeparatedByString:@","];
        gdpOfficicalImagesArray = [self.MusicDic[@"gdpOfficicalImages"] componentsSeparatedByString:@","];
        sdsOfficicalImagesArray = [self.MusicDic[@"sdsOfficialImages"] componentsSeparatedByString:@","];
    }
    
    TuPuViewController *tupuVC = [[TuPuViewController alloc] init];
    
    tupuVC.TuPuArray = @[
                         @{
                             @"name":@"五线谱",
                             @"images":wxpOfficicalImagesArray != nil?wxpOfficicalImagesArray:@[]
                             },
                         @{
                             @"name":@"简五谱",
                             @"images":jpOfficialImagesArray != nil?jpOfficialImagesArray:@[]
                             },
                         @{
                             @"name":@"固定谱",
                             @"images":gdpOfficicalImagesArray != nil?gdpOfficicalImagesArray:@[]
                             },
                         @{
                             @"name":@"首调式",
                             @"images":sdsOfficicalImagesArray != nil?sdsOfficicalImagesArray:@[]
                             }];
    switch (selectedNumber) {
        case 0:
        {
            if(![self TuPuIsNull:wxpOfficicalImagesArray]){
                [BaseMethod showSpecialToastOnWindow:@"对不起，没有对应曲谱文件" hideAfterSecond:Macro_ShowLoadingDefaultTime];
                return;
            }
               
        }
            break;
        case 1:
        {
            if(![self TuPuIsNull:jpOfficialImagesArray]){
                [BaseMethod showSpecialToastOnWindow:@"对不起，没有对应曲谱文件" hideAfterSecond:Macro_ShowLoadingDefaultTime];
                return;
            }
        }
            break;
        case 2:
        {
            if(![self TuPuIsNull:gdpOfficicalImagesArray]){
                [BaseMethod showSpecialToastOnWindow:@"对不起，没有对应曲谱文件" hideAfterSecond:Macro_ShowLoadingDefaultTime];
                return;
            }
        }
            break;
        case 3:
        {
            if(![self TuPuIsNull:sdsOfficicalImagesArray]){
                [BaseMethod showSpecialToastOnWindow:@"对不起，没有对应曲谱文件" hideAfterSecond:Macro_ShowLoadingDefaultTime];
                return;
            }
        }
            break;
        default:
            break;
    }
    tupuVC.selectedNumber = selectedNumber;
    tupuVC.title = self.navigationItem.title;
    tupuVC.isLocalType = self.isLocalType;
    [self.navigationController pushViewController:tupuVC animated:YES];
}
-(BOOL)TuPuIsNull:(NSArray *)array{
    if (array.count > 0) {
        NSString *imageurl = array[0];
        if (imageurl.length <= 0) {
            return NO;
        }
        return YES;
    }else{
        return NO;
    }
}
-(NSArray *)GetPathWithPath:(NSString *)floderName FileNameArray:(NSArray *)filenames{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < filenames.count; i++) {
        NSString *path = [floderName stringByAppendingString:[NSString stringWithFormat:@"/%@",filenames[i]]];
        [mutableArray addObject:path];
    }
    return mutableArray;
}


#pragma mark -privateInitMetch
-(CustomSegmentView *)segmentView{
    if (_segmentView == nil) {
        _segmentView = [[CustomSegmentView alloc] init];
        [_segmentView.imageLine setHidden:YES];
    }
    return _segmentView;
}
-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        _priceLabel.numberOfLines = 0;
    }
    return _priceLabel;
}
-(UIButton *)BuyBtn{
    if (_BuyBtn == nil) {
        _BuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BuyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_BuyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_BuyBtn addTarget:self action:@selector(BuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

-(UILabel *)titleLabel1{
    if (_titleLabel1 == nil) {
        _titleLabel1 = [[UILabel alloc] init];
    }
    return _titleLabel1;
}
-(UILabel *)titleLabel2{
    if (_titleLabel2 == nil) {
        _titleLabel2 = [[UILabel alloc] init];
    }
    return _titleLabel2;
}

-(UILabelAddId *)descriptionLabel2{
    if (_descriptionLabel2 == nil) {
        _descriptionLabel2 = [[UILabelAddId alloc] init];
    }
    return _descriptionLabel2;
}
-(UIImageView *)iconImageView1{
    if (_iconImageView1 == nil) {
        _iconImageView1 = [[UIImageView alloc] init];
    }
    return _iconImageView1;
}
-(UIImageView *)iconImageView2{
    if (_iconImageView2 == nil) {
        _iconImageView2 = [[UIImageView alloc] init];
    }
    return _iconImageView2;
}
-(UIWebView *)DescriptionWebView{
    if (_DescriptionWebView == nil) {
        _DescriptionWebView = [[UIWebView alloc] init];
    }
    return _DescriptionWebView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
