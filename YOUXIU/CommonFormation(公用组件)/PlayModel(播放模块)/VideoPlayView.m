//
//  VideoPlayView.m
//  YOUXIU
//
//  Created by lihui on 2018/3/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "VideoPlayView.h"
#import <AVFoundation/AVFoundation.h>
#import "FilePatchMetch.h"
typedef NS_ENUM(NSInteger, ScreenShowType) {
    ScreenShowTypeLandscape = 0,
    ScreenShowTypePorTrait
};
typedef NS_ENUM(NSInteger, ABProcessStatus){
    ABProcessStatusNone = 0,
    ABProcessStatusA = 1,
    ABProcessStatusB = 2
};
typedef NS_ENUM(NSInteger, ZoomType){
    ZoomTypeFullScreen,
    ZoomTypeSmallScreen
};
#define ProgressViewHeight 30
#define FunctionViewHeight 110

@interface VideoPlayView()
@property (nonatomic, strong) AVPlayer *Player;
@property (nonatomic, strong) AVPlayerItem *PlayerItem;
@property (nonatomic, strong) AVPlayerLayer *Playerlayer;

@property (nonatomic, assign) BOOL isReadToPlay;//用来判断当前视频是否准备好播放
@property (nonatomic, strong) NSString *videoURL;
@property (nonatomic, strong) UISlider *avSlider; //进度条，控制视频的快进快退
@property (nonatomic, strong) UIProgressView *videoProgressView;  //缓冲进度条

@property (nonatomic, strong) UIButtonAddId *PlayerBtn;
@property (nonatomic, strong) UIButtonAddId *BigPlayerBtn;
@property (nonatomic, strong) UIButton *FastForwardBtn;//快进按钮
@property (nonatomic, strong) UIButton *FastBackBtn;//快退按钮
@property (nonatomic, strong) UIButtonAddId *ZoomTypeBtn;
@property (nonatomic, strong) UIButton *ABBtn;//AB循环键
@property (nonatomic, strong) UIButton *BlueToothBtn;//蓝牙开关
@property (nonatomic, strong) UIButton *wuxianpuBtn;//五线谱开关
@property (nonatomic, strong) UIButton *jianwupuBtn;//简五谱开关
@property (nonatomic, strong) UIButton *gudingpuBtn;//固定谱开关
@property (nonatomic, strong) UIButton *shoudiaoshiBtn;//首调式开关
@property (nonatomic, strong) UIImageView *arrowA;
@property (nonatomic, strong) UIImageView *arrowB;

@property (nonatomic, assign) CMTime Atime;
@property (nonatomic, assign) CMTime Btime;
@property (nonatomic, strong) NSTimer *PlayTime;
@property (nonatomic, assign) ABProcessStatus ABStatus;
@property (nonatomic, assign) ZoomType playerScreenType;
@property (nonatomic, assign) BOOL isShowProgressBaseView; //进度条是否展示
@property (nonatomic, strong) UIView *ProgressBaseView; //进度基础视图
@property (nonatomic, strong) UIView *FunctionBaseView; //功能按键视图
@property (nonatomic, strong) UILabel *playtimeLabel;
@property (nonatomic, strong) UILabel *playtotaltimeLabel;
@property (nonatomic, strong) UILabel *statusLabel; //显示快进快退状态
@property (nonatomic, strong) UIImageView *middleStatusBackgroupImageView;

@property (nonatomic, strong) UIImageView *StaffImageView;
@property (nonatomic, strong) UILabel *StaffLabel;

@property (nonatomic, assign) ScreenShowType screenType;
@property (nonatomic, assign) CGRect OriginalFrame;//view原始坐标

@property (nonatomic, retain) UIView *SuperView;

@property (nonatomic, retain) UIImageView *bottomLine;
@property (nonatomic, assign) CGFloat payRate;
@end

@implementation VideoPlayView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)SetPlayerIsLocal:(BOOL)Local withVideoURL:(NSString *)VideoURL{
    self.ABStatus = ABProcessStatusNone;
    self.Atime = kCMTimeZero;
    self.Btime = kCMTimeZero;
    self.PlayTime = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(PlayStatusTime) userInfo:nil repeats:YES];
    self.payRate = 1;
    if(Local){
        self.PlayerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:VideoURL]];
        self.Player = [AVPlayer playerWithPlayerItem:self.PlayerItem];
        [self.Playerlayer setPlayer:self.Player];
        self.Playerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.Playerlayer.contentsScale = [UIScreen mainScreen].scale;
    }else{
        self.PlayerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:VideoURL]];
        self.Player = [AVPlayer playerWithPlayerItem:self.PlayerItem];
        [self.Playerlayer setPlayer:self.Player];
        self.Playerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.Playerlayer.contentsScale = [UIScreen mainScreen].scale;
        
        //监听播放状态
        [self.PlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        //监听 缓冲状态
        [self.PlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    }
}
-(void)dealloc{
    [self.PlayTime invalidate];
    self.PlayerItem = nil;
    self.Playerlayer = nil;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.OriginalFrame = frame;
        //加载播放view
        self.screenType = ScreenShowTypePorTrait;
        [self.Playerlayer setFrame:CGRectMake(0,
                                              0,
                                              self.frame.size.width,
                                              self.frame.size.height - FunctionViewHeight + ProgressViewHeight)];
        [self.Playerlayer setBackgroundColor:[UIColor whiteColor].CGColor];
        [self.layer addSublayer:self.Playerlayer];
        
        [self.BigPlayerBtn setFrame:CGRectMake(0,
                                               0,
                                               Macro_AutoWidth_7p(100),
                                               Macro_AutoWidth_7p(100))];
        [self.BigPlayerBtn setCenter:CGPointMake(CGRectGetMidX(self.Playerlayer.frame),
                                                 CGRectGetMidY(self.Playerlayer.frame) - Macro_AutoWidth_7p(30))];
        [self addSubview:self.BigPlayerBtn];
        
        //加载进度条功能view
        [self.ProgressBaseView setFrame:CGRectMake(0, self.Playerlayer.frame.size.height, self.frame.size.width, ProgressViewHeight)];
        [self.ProgressBaseView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
        [self addSubview:self.ProgressBaseView];
        
        //加载功能view
        [self.FunctionBaseView setFrame:CGRectMake(0,CGRectGetMaxY(self.Playerlayer.frame), self.frame.size.width, FunctionViewHeight)];
        [self addSubview:self.FunctionBaseView];
        [self.FunctionBaseView setBackgroundColor:[UIColor whiteColor]];
        [self setContentViewFrame];
        
        self.isShowProgressBaseView = YES;
        
        self.bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                        frame.size.height-1,
                                                                        KWidth,
                                                                        1)];
        [self.bottomLine setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
        [self addSubview:self.bottomLine];
    }
    return self;
}
-(void)setInitValue{
    self.ABStatus = ABProcessStatusNone;
    self.playerScreenType = ZoomTypeSmallScreen;
}
/**
 设置初始页面
 */
-(void)setContentViewFrame{
    [self setInitValue];
    [self.ProgressBaseView addSubview:self.PlayerBtn];
    [self.ProgressBaseView addSubview:self.playtimeLabel];
    [self.ProgressBaseView addSubview:self.videoProgressView];
    [self.ProgressBaseView addSubview:self.avSlider];
    [self.ProgressBaseView addSubview:self.playtotaltimeLabel];
    [self.ProgressBaseView addSubview:self.ZoomTypeBtn];
    
    [self.FunctionBaseView addSubview:self.StaffImageView];
    [self.FunctionBaseView addSubview:self.StaffLabel];
    [self.FunctionBaseView addSubview:self.middleStatusBackgroupImageView];
    [self.FunctionBaseView addSubview:self.BlueToothBtn];
    [self.FunctionBaseView addSubview:self.FastBackBtn];
    [self.FunctionBaseView addSubview:self.statusLabel];
    [self.FunctionBaseView addSubview:self.FastForwardBtn];
    [self.FunctionBaseView addSubview:self.ABBtn];
        [self.FunctionBaseView addSubview:self.jianwupuBtn];
        [self.FunctionBaseView addSubview:self.wuxianpuBtn];
        [self.FunctionBaseView addSubview:self.gudingpuBtn];
        [self.FunctionBaseView addSubview:self.shoudiaoshiBtn];
    //进度条视图
    self.PlayerBtn.CustonProperty = [NSNumber numberWithBool: NO];// 是否在播放
    [self.PlayerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.ProgressBaseView.mas_left).offset(5);
        make.top.mas_equalTo(self.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(self.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(self.PlayerBtn.mas_height);
    }];
    [self.playtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.PlayerBtn.mas_right).offset(10);
        make.top.mas_equalTo(self.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(self.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(60);
    }];
    [self.ZoomTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.ProgressBaseView.mas_right).offset(-5);
        make.top.mas_equalTo(self.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(self.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(self.ZoomTypeBtn.mas_height);
    }];
    [self.playtotaltimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.ZoomTypeBtn.mas_left).offset(-5);
        make.top.mas_equalTo(self.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(self.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(60);
    }];
    [self.videoProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playtimeLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.playtotaltimeLabel.mas_left).offset(-3);
        make.top.mas_equalTo(self.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(self.ProgressBaseView.mas_bottom).offset(-3);
    }];
    [self.avSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playtimeLabel.mas_right).offset(10);
        make.right.mas_equalTo(self.playtotaltimeLabel.mas_left).offset(-3);
        make.top.mas_equalTo(self.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(self.ProgressBaseView.mas_bottom).offset(-3);
    }];
    
    //下方功能视图
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.FunctionBaseView.mas_centerX).offset(0);
        make.top.mas_equalTo(self.FunctionBaseView.mas_top).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    [self.FastBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.statusLabel.mas_left).offset(0);
        make.top.mas_equalTo(self.FunctionBaseView.mas_top).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(40);
    }];
    [self.FastForwardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.statusLabel.mas_right).offset(0);
        make.top.mas_equalTo(self.FunctionBaseView.mas_top).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(40);
    }];
    [self.BlueToothBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.FunctionBaseView.mas_left).offset(50);
        make.top.mas_equalTo(self.FunctionBaseView.mas_top).offset(5);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    [self.ABBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.FunctionBaseView.mas_right).offset(-50);
        make.top.mas_equalTo(self.FunctionBaseView.mas_top).offset(5);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(40);
    }];
    [self.middleStatusBackgroupImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.FunctionBaseView.mas_centerX).offset(0);
        make.left.mas_equalTo(self.FastBackBtn.mas_left).offset(0);
        make.right.mas_equalTo(self.FastForwardBtn.mas_right).offset(0);
        make.bottom.mas_equalTo(self.FastForwardBtn.mas_bottom).offset(0);
    }];
    [self.StaffImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BlueToothBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(self.FunctionBaseView.mas_left).offset(10);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(30);
    }];
    [self.StaffLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.BlueToothBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(self.StaffImageView.mas_right).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    NSInteger btnwidth = 70;
    NSInteger btnheight = 30;
    NSInteger leftspace = 10;
    [self.wuxianpuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(self.StaffLabel.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
    [self.jianwupuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(self.wuxianpuBtn.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
    [self.gudingpuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(self.jianwupuBtn.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
    [self.shoudiaoshiBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(self.gudingpuBtn.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
}
-(void)updateContent{
    if (self.screenType == ScreenShowTypePorTrait){//竖屏
        CGFloat height = self.OriginalFrame.size.height == 0?self.frame.size.height: self.OriginalFrame.size.height;
        CGFloat width = self.OriginalFrame.size.width == 0?self.frame.size.width: self.OriginalFrame.size.width;
        [self.Playerlayer setFrame:CGRectMake(0,
                                              0,
                                              Macro_ScreenWidth,
                                              height- FunctionViewHeight )];
        
        [self.ProgressBaseView setFrame:CGRectMake(0,
                                                   self.Playerlayer.frame.size.height - ProgressViewHeight,
                                                   width,
                                                   ProgressViewHeight)];
        
    }else{
        [self.Playerlayer setFrame:CGRectMake(0,
                                              0,
                                              Macro_ScreenHeight,
                                              Macro_ScreenWidth)];
        [self.ProgressBaseView setFrame:CGRectMake(0,
                                                   self.Playerlayer.frame.size.height - ProgressViewHeight,
                                                   Macro_ScreenHeight,
                                                   ProgressViewHeight)];
    }
    __block typeof(self) WeakSelf = self;
    [self.FunctionBaseView setFrame:CGRectMake(0,
                                               CGRectGetMaxY(self.Playerlayer.frame),
                                               self.frame.size.width,
                                               FunctionViewHeight)];
    //进度条视图
    [self.PlayerBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.ProgressBaseView.mas_left).offset(5);
        make.top.mas_equalTo(WeakSelf.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(WeakSelf.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(WeakSelf.PlayerBtn.mas_height);
    }];
    [self.playtimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.PlayerBtn.mas_right).offset(10);
        make.top.mas_equalTo(WeakSelf.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(WeakSelf.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(60);
    }];
    [self.ZoomTypeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WeakSelf.ProgressBaseView.mas_right).offset(-5);
        make.top.mas_equalTo(WeakSelf.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(WeakSelf.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(WeakSelf.ZoomTypeBtn.mas_height);
    }];
    [self.playtotaltimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WeakSelf.ZoomTypeBtn.mas_left).offset(-5);
        make.top.mas_equalTo(WeakSelf.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(WeakSelf.ProgressBaseView.mas_bottom).offset(-3);
        make.width.mas_equalTo(60);
    }];
    [self.videoProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.playtimeLabel.mas_right).offset(10);
        make.right.mas_equalTo(WeakSelf.playtotaltimeLabel.mas_left).offset(-3);
        make.top.mas_equalTo(WeakSelf.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(WeakSelf.ProgressBaseView.mas_bottom).offset(-3);
    }];
    [self.avSlider mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.playtimeLabel.mas_right).offset(10);
        make.right.mas_equalTo(WeakSelf.playtotaltimeLabel.mas_left).offset(-3);
        make.top.mas_equalTo(WeakSelf.ProgressBaseView.mas_top).offset(3);
        make.bottom.mas_equalTo(WeakSelf.ProgressBaseView.mas_bottom).offset(-3);
        
        if(self.arrowA.superview !=nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                CMTime totalTime = WeakSelf.Player.currentItem.duration;
                CGFloat rate = CMTimeGetSeconds(WeakSelf.Atime)/CMTimeGetSeconds(totalTime);
                [WeakSelf.arrowA setCenter:CGPointMake(CGRectGetWidth(WeakSelf.avSlider.frame)*rate,
                                                       WeakSelf.arrowA.center.y)];
            });
        }
        if(self.arrowB.superview != nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                CMTime totalTime = WeakSelf.Player.currentItem.duration;
                CGFloat rate = CMTimeGetSeconds(WeakSelf.Btime)/CMTimeGetSeconds(totalTime);
                [WeakSelf.arrowB setCenter:CGPointMake(CGRectGetWidth(WeakSelf.avSlider.frame)*rate,
                                                       WeakSelf.arrowB.center.y)];
            });
        }
    }];
    [self.ProgressBaseView needsUpdateConstraints];
    //功能视图
    [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WeakSelf.FunctionBaseView.mas_centerX).offset(0);
        make.top.mas_equalTo(WeakSelf.FunctionBaseView.mas_top).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    [self.FastBackBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WeakSelf.statusLabel.mas_left).offset(0);
        make.top.mas_equalTo(WeakSelf.FunctionBaseView.mas_top).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    [self.FastForwardBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.statusLabel.mas_right).offset(0);
        make.top.mas_equalTo(WeakSelf.FunctionBaseView.mas_top).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    [self.BlueToothBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WeakSelf.FunctionBaseView.mas_left).offset(50);
        make.top.mas_equalTo(WeakSelf.FunctionBaseView.mas_top).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.ABBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WeakSelf.FunctionBaseView.mas_right).offset(-50);
        make.top.mas_equalTo(WeakSelf.FunctionBaseView.mas_top).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.middleStatusBackgroupImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WeakSelf.FunctionBaseView.mas_centerX).offset(0);
        make.left.mas_equalTo(WeakSelf.FastBackBtn.mas_left).offset(0);
        make.right.mas_equalTo(WeakSelf.FastForwardBtn.mas_right).offset(0);
        make.bottom.mas_equalTo(WeakSelf.FastForwardBtn.mas_bottom).offset(0);
        make.top.mas_equalTo(WeakSelf.FastForwardBtn.mas_top).offset(0);
    }];
    
    [self.StaffImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeakSelf.BlueToothBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(WeakSelf.FunctionBaseView.mas_left).offset(10);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(20);
    }];
    [self.StaffLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeakSelf.BlueToothBtn.mas_bottom).offset(20);
        make.left.mas_equalTo(WeakSelf.StaffImageView.mas_right).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
    }];
    
    
    NSInteger btnwidth = 70;
    NSInteger btnheight = 30;
    NSInteger leftspace = 10;
    
    [self.wuxianpuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeakSelf.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(WeakSelf.StaffLabel.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
    [self.jianwupuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeakSelf.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(WeakSelf.wuxianpuBtn.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
    [self.gudingpuBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeakSelf.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(WeakSelf.jianwupuBtn.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
    [self.shoudiaoshiBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WeakSelf.StaffImageView.mas_top).offset(-5);
        make.left.mas_equalTo(WeakSelf.shoudiaoshiBtn.mas_right).offset(leftspace);
        make.width.mas_equalTo(btnwidth);
        make.height.mas_equalTo(btnheight);
    }];
}


#pragma mark 该frame改变时
-(void)layoutSublayersOfLayer:(CALayer *)layer{
    [super layoutSublayersOfLayer:layer];
    [self updateContent];
}
#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([object isKindOfClass:[AVPlayerItem class]]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        BOOL isplay = [self.PlayerBtn.CustonProperty boolValue];
        
        [self.avSlider setValue:CMTimeGetSeconds(self.Player.currentItem.currentTime)/CMTimeGetSeconds(self.Player.currentItem.duration) animated:YES];
        if ([keyPath isEqualToString:@"status"]) {
            switch (playerItem.status) {
                case AVPlayerItemStatusReadyToPlay:{
                    [BaseMethod hideAllHudsInView:self];
                    if (isplay){
                        [self.Player play];
                    }
                }break;
                case AVPlayerItemStatusUnknown:{
                    if(isplay){
                        [BaseMethod showToast:@"未知错误，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
                    }else{
                        [BaseMethod hideAllHudsInView:self];
                    }
                }break;
                case AVPlayerItemStatusFailed:{
                    if(isplay){
                        [BaseMethod showToast:@"视频加载失败，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self.superview];
                    }else{
                        [BaseMethod hideAllHudsInView:self];
                    }
                }break;
                default:
                    break;
            }
        }else if([keyPath isEqualToString:@"loadedTimeRanges"]){//缓冲
            [self calculateDownloadProgress:playerItem];
        }
    }
}
- (void)calculateDownloadProgress:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
    CMTime duration = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    [self.videoProgressView setProgress:timeInterval/totalDuration animated:YES];
}
- (NSTimeInterval)availableDurationWithplayerItem:(AVPlayerItem *)playerItem
{
    NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    NSTimeInterval startSeconds = CMTimeGetSeconds(timeRange.start);
    NSTimeInterval durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark BtnClick
-(void)StartPlay{
    if (self.Player != nil) {
        [self.Player play];
        [self.PlayerBtn setImage:[UIImage imageNamed:@"VideoSuspendIcon"] forState:UIControlStateNormal];
        self.PlayerBtn.CustonProperty = [NSNumber numberWithBool:YES];
        [self.BigPlayerBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    [self.PlayTime fire];
}

-(void)StopPlay{
    [self.Player pause];
    [self.PlayerBtn setImage:[UIImage imageNamed:@"VideoPlayIcon"] forState:UIControlStateNormal];
    self.PlayerBtn.CustonProperty = [NSNumber numberWithBool:NO];
    [self.BigPlayerBtn setImage:[UIImage imageNamed:@"BigPay"] forState:UIControlStateNormal];
    [self.PlayTime isValid];
}

-(void)PlayerBtnClick:(id)sender{
    if (self.PlayerItem == nil){
        [BaseMethod showSpecialToastOnWindow:@"对不起，没有视频文件可播放" hideAfterSecond:Macro_ShowLoadingDefaultTime];
        return;
    }
    if([self.PlayerBtn.CustonProperty boolValue] == NO){
        if(self.avSlider.value == 1)
        {
             [self.Player seekToTime:kCMTimeZero];
        }

        [self.Player play];
        [self.PlayerBtn setImage:[UIImage imageNamed:@"VideoSuspendIcon"] forState:UIControlStateNormal];
        self.PlayerBtn.CustonProperty = [NSNumber numberWithBool:YES];
        
        [self.BigPlayerBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
       
    }else{
        [self.Player pause];
        [self.PlayerBtn setImage:[UIImage imageNamed:@"VideoPlayIcon"] forState:UIControlStateNormal];
        self.PlayerBtn.CustonProperty = [NSNumber numberWithBool:NO];
        
        [self.BigPlayerBtn setImage:[UIImage imageNamed:@"BigPay"] forState:UIControlStateNormal];
    }
}
-(void)FastForwardBtnClick:(id)sender{
    if(self.payRate < 2.0){
        self.payRate = self.payRate + 0.1;
        self.Player.rate = self.payRate;
        [self.statusLabel setText:[NSString stringWithFormat:@"%.1fX",self.payRate]];
    }
}
-(void)FastBackBtnClick:(id)sender{
    if(self.payRate >= 0.2){
        self.payRate = self.payRate - 0.1;
        self.Player.rate = self.payRate;
        [self.statusLabel setText:[NSString stringWithFormat:@"%.1fX",self.payRate]];
    }
}
-(void)ABBtnClick:(id)sender{
    switch (self.ABStatus) {
        case ABProcessStatusA:
        {
            self.ABStatus = ABProcessStatusB;
            self.Btime = self.Player.currentTime;
            
            CGFloat b = self.avSlider.value;
            [self.arrowB setCenter:CGPointMake(CGRectGetWidth(self.videoProgressView.frame)*b ,
                                               CGRectGetMidY(self.videoProgressView.frame) - Macro_AutoWidth_7p(10))];
            if([self.arrowB superview] == nil){
                [self.avSlider addSubview:self.arrowB];
            }
            CGFloat aa = CMTimeGetSeconds(self.Atime);
            CGFloat bb = CMTimeGetSeconds(self.Btime);
            if(aa > bb){
                CMTime Temporary = self.Atime;
                self.Atime = self.Btime;
                self.Btime = Temporary;
                
                CGPoint tempoPoint = self.arrowA.center;
                self.arrowA.center = self.arrowB.center;
                self.arrowB.center = tempoPoint;
            }
            //进入ab循环
            [self playABParagraph];
        }
            break;
        case ABProcessStatusB:{
            self.ABStatus = ABProcessStatusNone;
            self.Atime = kCMTimeZero;
            self.Btime = kCMTimeZero;
            [self.arrowA removeFromSuperview];
            [self.arrowB removeFromSuperview];
        }
            break;
        case ABProcessStatusNone:{
            self.ABStatus = ABProcessStatusA;
            self.Atime = self.Player.currentTime;
            CGFloat a = self.avSlider.value;
            [self.arrowA setCenter:CGPointMake(CGRectGetWidth(self.videoProgressView.frame)*a,
                                               CGRectGetMidY(self.videoProgressView.frame) - Macro_AutoWidth_7p(10))];
            if([self.arrowA superview] == nil){
                [self.avSlider addSubview:self.arrowA];
            }
        }
        default:
            break;
    }
    //改变按钮显示状态
    [self changeABText:self.ABStatus];
}
-(void)changeABText:(ABProcessStatus)status{
    if (status == ABProcessStatusB) {//状态为B的显示状态
        [self.ABBtn setImage:[UIImage imageNamed:@"ab循环"] forState:UIControlStateNormal];
    }else if(status == ABProcessStatusA){//状态为A的显示状态
        [self.ABBtn setImage:[UIImage imageNamed:@"video_a"] forState:UIControlStateNormal];
    }else{//状态为为使用AB功能的显示状态
        [self.ABBtn setImage:[UIImage imageNamed:@"video_abopen"] forState:UIControlStateNormal];
    }
}
//ab循环播放
-(void)playABParagraph{
    //ab有值的情况才循环
    if (self.ABStatus == ABProcessStatusNone||
        self.ABStatus == ABProcessStatusA) {
        return;
    }
    if( CMTimeGetSeconds(self.Player.currentItem.currentTime) >= CMTimeGetSeconds(self.Btime)){
        [self.Player seekToTime:self.Atime];
    }
}
-(void)AVSliderValueChange:(id)sender{
    CMTime time = self.Player.currentItem.duration;//视频总时间
    Float64 seconds = CMTimeGetSeconds(time);
    Float64 wantseconds = seconds*self.avSlider.value;
    [self.Player seekToTime:CMTimeMake(wantseconds, 1) completionHandler:^(BOOL finished) {
    }];
}
-(void)PlayStatusTime{
    //ab循环
    [self playABParagraph];
    NSString *currentitme =  [self getTimeWithSecond:CMTimeGetSeconds(self.Player.currentItem.currentTime)];
    NSString *totaltime = [self getTimeWithSecond:CMTimeGetSeconds(self.Player.currentItem.duration)];
    [self.playtimeLabel setText:currentitme];
    [self.playtotaltimeLabel setText:totaltime];
    [self.avSlider setValue:CMTimeGetSeconds(self.Player.currentItem.currentTime)/CMTimeGetSeconds(self.Player.currentItem.duration) animated:YES];
    if(self.avSlider.value == 1)
    {
        [self StopPlay];
    }
    
    if (self.Player.status == AVPlayerStatusUnknown) {
        [BaseMethod showLoading:self];
    }else if(self.Player.status == AVPlayerStatusFailed){
        [BaseMethod hideAllHudsInView:self];
        [BaseMethod showToast:@"视频加载失败，请稍后再试" hideAfterSecond:Macro_ShowLoadingDefaultTime inView:self];
    }else if (self.Player.status == AVPlayerStatusReadyToPlay){
        [BaseMethod hideAllHudsInView:self];
    }else{
        [BaseMethod hideAllHudsInView:self];
    }
}
//界面点击事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    CGPoint playerpoints = [self.Playerlayer convertPoint:point fromLayer:self.layer];
    if ([self.Playerlayer containsPoint:playerpoints]) {
        self.isShowProgressBaseView = !self.isShowProgressBaseView;
        [self ChangeProgressViewShowStatus:self.isShowProgressBaseView];
    }
}
-(void)ChangeProgressViewShowStatus:(BOOL)ShowProgress{
    if(ShowProgress){//展示进度条
        [UIView animateWithDuration:0.3 animations:^{
            [self.ProgressBaseView setCenter:CGPointMake(self.ProgressBaseView.center.x, self.ProgressBaseView.center.y - self.ProgressBaseView.frame.size.height)];
        }];
    }else{//隐藏进度条
        [UIView animateWithDuration:0.3 animations:^{
            [self.ProgressBaseView setCenter:CGPointMake(self.ProgressBaseView.center.x, self.ProgressBaseView.center.y + self.ProgressBaseView.frame.size.height)];
        }];
    }
}
-(NSString *)getTimeWithSecond:(NSInteger)second{
    if (second < 0){
        second = 0;
    }
    NSInteger hour = second/(60*60);
    NSInteger min = (second%(60*60))/60;
    NSInteger sec = (second%(60*60))%60;
    NSString *timeString =[NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,min,sec];
    return timeString;
}
-(void)TuPuBtnClick:(id)sender{
    if ([self.delegate respondsToSelector:@selector(VideoTuPuClick:)]) {
        UIButton *btn = (UIButton *)sender;
        [self.delegate VideoTuPuClick:btn.titleLabel.text];
    }
}
-(void)BlueToothBtnClick:(id)sender{
    [BaseMethod showToast:@"暂不开放" hideAfterSecond:2 inView:self.superview];
}
-(void)ZoomTypeBtnClick:(id)sender{
    if(self.screenType == ScreenShowTypePorTrait){
        self.screenType = ScreenShowTypeLandscape;
        //把自己选择90度，添加到window上
        [self setFrame:CGRectMake(0, 0, Macro_ScreenHeight, Macro_ScreenWidth)];
        [self.BigPlayerBtn setCenter:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
        self.center = CGPointMake(CGRectGetMidX(self.window.frame),CGRectGetMidY(self.window.frame));
        self.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.SuperView = self.superview;
        [self.window addSubview:self];
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
        [self.bottomLine setHidden:YES];
    }else{
        //把自己重window上挪回来
        self.screenType = ScreenShowTypePorTrait;
        [self.SuperView addSubview:self];
        self.transform = CGAffineTransformMakeRotation(0);
        [self setFrame:CGRectMake(self.OriginalFrame.origin.x,
                                  self.OriginalFrame.origin.y,
                                  self.OriginalFrame.size.width,
                                  self.OriginalFrame.size.height)];
        [self.BigPlayerBtn setCenter:CGPointMake(CGRectGetMidX(self.OriginalFrame),
                                                 CGRectGetMidY(self.OriginalFrame) - Macro_AutoWidth_7p(115))];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
        [self.bottomLine setHidden:NO];
    }
    [self updateContent];
}

#pragma mark initVar
-(void)setShowTuPu:(BOOL)showTuPu{
    _showTuPu = showTuPu;
    [self.wuxianpuBtn setHidden:!showTuPu];
     [self.jianwupuBtn setHidden:!showTuPu];
     [self.gudingpuBtn setHidden:!showTuPu];
     [self.shoudiaoshiBtn setHidden:!showTuPu];
    [self.StaffLabel setHidden:!showTuPu];
    [self.StaffImageView setHidden:!showTuPu];
}
-(UIButtonAddId *)PlayerBtn{
    if (_PlayerBtn == nil) {
        _PlayerBtn = [UIButtonAddId buttonWithType:UIButtonTypeCustom];
        [_PlayerBtn addTarget:self action:@selector(PlayerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_PlayerBtn setImage:[UIImage imageNamed:@"VideoPlayIcon"] forState:UIControlStateNormal];
        _PlayerBtn.CustonProperty = [NSNumber numberWithBool:NO];
        [_PlayerBtn setBackgroundColor:[UIColor clearColor]];
        _PlayerBtn.tag = 1;
    }
    return _PlayerBtn;
}
-(UIButtonAddId *)BigPlayerBtn{
    if(_BigPlayerBtn == nil){
        _BigPlayerBtn = [UIButtonAddId buttonWithType:UIButtonTypeCustom];
        [_BigPlayerBtn addTarget:self action:@selector(PlayerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_BigPlayerBtn setImage:[UIImage imageNamed:@"BigPay"] forState:UIControlStateNormal];
        _BigPlayerBtn.CustonProperty = [NSNumber numberWithBool:NO];
        [_BigPlayerBtn setBackgroundColor:[UIColor clearColor]];
        _BigPlayerBtn.tag = 2;
    }
    return _BigPlayerBtn;
}
-(UISlider *)avSlider{
    if (_avSlider == nil) {
        _avSlider = [[UISlider alloc]init];
        _avSlider.maximumValue = 1;
        _avSlider.minimumValue = 0;
        [_avSlider addTarget:self action:@selector(AVSliderValueChange:) forControlEvents:UIControlEventValueChanged];
        _avSlider.tintColor = [UIColor redColor];
        [_avSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
        [_avSlider setMaximumTrackImage:[BaseMethod imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
        [_avSlider setMinimumTrackImage:[BaseMethod imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    }
    return _avSlider;
}
-(UIProgressView *)videoProgressView{
    if(_videoProgressView == nil){
        _videoProgressView = [[UIProgressView alloc] init];
        _videoProgressView.progressTintColor =[UIColor grayColor];   //填充部分颜色
        _videoProgressView.trackTintColor =  [UIColor whiteColor];   // 未填充部分颜色
        _videoProgressView.layer.cornerRadius = 1.5;
        _videoProgressView.layer.masksToBounds = YES;
        CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 0.1);
        _videoProgressView.transform = transform;
    }
    return _videoProgressView;
}
-(UIButton *)FastForwardBtn{
    if (_FastForwardBtn == nil) {
        _FastForwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_FastForwardBtn addTarget:self action:@selector(FastForwardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_FastForwardBtn setImage:[UIImage imageNamed:@"video_adjustspeed_decelerationDeceleration"] forState:UIControlStateNormal];
        [_FastForwardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _FastForwardBtn;
}
-(UIButton *)FastBackBtn{
    if (_FastBackBtn == nil) {
        _FastBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_FastBackBtn addTarget:self action:@selector(FastBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_FastBackBtn setImage:[UIImage imageNamed:@"video_adjustspeed_accelerate"] forState:UIControlStateNormal];
    }
    return _FastBackBtn;
}
-(UILabel *)statusLabel{
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc]init];
        [_statusLabel setText:@"1.0X"];
        [_statusLabel setTextAlignment:NSTextAlignmentCenter];
        [_statusLabel setTextColor:[UIColor redColor]];
        [_statusLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _statusLabel;
}
-(UIButton *)ABBtn{
    if (_ABBtn == nil) {
        _ABBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ABBtn setImage:[UIImage imageNamed:@"video_abopen"] forState:UIControlStateNormal];
        [_ABBtn addTarget:self action:@selector(ABBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ABBtn;
}
-(UIImageView *)arrowA{
    if (_arrowA == nil) {
        _arrowA = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArrowA"]];
        [_arrowA setFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(20), Macro_AutoWidth_7p(20))];
    }
    return _arrowA;
}
-(UIImageView *)arrowB{
    if (_arrowB == nil) {
        _arrowB = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArrowB"]];
        [_arrowB setFrame:CGRectMake(0, 0, Macro_AutoWidth_7p(20), Macro_AutoWidth_7p(20))];
    }
    return _arrowB;
}
-(UIView *)FunctionBaseView{
    if(_FunctionBaseView == nil){
        _FunctionBaseView = [[UIView alloc] init];
    }
    return _FunctionBaseView;
}
-(UIView *)ProgressBaseView{
    if(_ProgressBaseView == nil){
        _ProgressBaseView = [[UIView alloc] init];
    }
    return _ProgressBaseView;
}
-(AVPlayer *)Player{
    if(_Player == nil){
        _Player = [[AVPlayer alloc] init];
    }
    return _Player;
}
-(AVPlayerLayer *)Playerlayer{
    if (_Playerlayer == nil) {
        _Playerlayer = [[AVPlayerLayer alloc]init];
        _Playerlayer.masksToBounds = YES;
    }
    return _Playerlayer;
}
-(UILabel *)playtimeLabel{
    if (_playtimeLabel == nil) {
        _playtimeLabel = [[UILabel alloc] init];
        [_playtimeLabel setFont:[UIFont systemFontOfSize:9]];
        [_playtimeLabel setTextColor:[UIColor whiteColor]];
        [_playtimeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _playtimeLabel;
}
-(UILabel *)playtotaltimeLabel{
    if (_playtotaltimeLabel == nil) {
        _playtotaltimeLabel = [[UILabel alloc] init];
        [_playtotaltimeLabel setFont:[UIFont systemFontOfSize:9]];
        [_playtotaltimeLabel setTextColor:[UIColor whiteColor]];
        [_playtotaltimeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _playtotaltimeLabel;
}
-(UIButton *)wuxianpuBtn{
    if(_wuxianpuBtn == nil){
        _wuxianpuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wuxianpuBtn setTitle:@"五线谱" forState:UIControlStateNormal];
        [_wuxianpuBtn setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.5]];
        [_wuxianpuBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_wuxianpuBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        _wuxianpuBtn.layer.cornerRadius = 15;
        [_wuxianpuBtn addTarget:self action:@selector(TuPuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wuxianpuBtn;
}
-(UIButton *)jianwupuBtn{
    if(_jianwupuBtn == nil){
        _jianwupuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jianwupuBtn setTitle:@"简五谱" forState:UIControlStateNormal];
        [_jianwupuBtn setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
        [_jianwupuBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_jianwupuBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        _jianwupuBtn.layer.cornerRadius = 15;
        [_jianwupuBtn addTarget:self action:@selector(TuPuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _jianwupuBtn;
}
-(UIButton *)gudingpuBtn{
    if (_gudingpuBtn == nil) {
        _gudingpuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gudingpuBtn setTitle:@"固定谱" forState:UIControlStateNormal];
        [_gudingpuBtn setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
        [_gudingpuBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_gudingpuBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        _gudingpuBtn.layer.cornerRadius = 15;
        [_gudingpuBtn addTarget:self action:@selector(TuPuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _gudingpuBtn;
}
-(UIButton *)shoudiaoshiBtn{
    if (_shoudiaoshiBtn == nil){
        _shoudiaoshiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shoudiaoshiBtn setTitle:@"首调式" forState:UIControlStateNormal];
        [_shoudiaoshiBtn setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
        [_shoudiaoshiBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_shoudiaoshiBtn setTitleColor:[UIColor colorWithWhite:0.4 alpha:1] forState:UIControlStateNormal];
        _shoudiaoshiBtn.layer.cornerRadius = 15;
        [_shoudiaoshiBtn addTarget:self action:@selector(TuPuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoudiaoshiBtn;
}
-(UIButton *)BlueToothBtn{
    if (_BlueToothBtn == nil) {
        _BlueToothBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BlueToothBtn setImage:[UIImage imageNamed:@"video_bluetooth_open"] forState:UIControlStateNormal];
        [_BlueToothBtn addTarget:self action:@selector(BlueToothBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _BlueToothBtn;
}
-(UIButtonAddId *)ZoomTypeBtn{
    if (_ZoomTypeBtn == nil){
        _ZoomTypeBtn = [UIButtonAddId buttonWithType:UIButtonTypeCustom];
        [_ZoomTypeBtn setImage:[UIImage imageNamed:@"ZoomInIcon"] forState:UIControlStateNormal];
        [_ZoomTypeBtn setBackgroundColor:[UIColor clearColor]];
        [_ZoomTypeBtn addTarget:self action:@selector(ZoomTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ZoomTypeBtn;
}
-(UIImageView *)middleStatusBackgroupImageView{
    if (_middleStatusBackgroupImageView == nil) {
        _middleStatusBackgroupImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_adjustspeed1"]];
    }
    return _middleStatusBackgroupImageView;
}
-(UIImageView *)StaffImageView{
    if (_StaffImageView== nil) {
        _StaffImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"video_icon"]];
    }
    return _StaffImageView;
}
-(UILabel *)StaffLabel{
    if (_StaffLabel == nil) {
        _StaffLabel = [[UILabel alloc]init];
        [_StaffLabel setText:@"曲谱"];
        [_StaffLabel setFont:[UIFont systemFontOfSize:14]];
        [_StaffLabel setTextColor:[UIColor darkTextColor]];
    }
    return _StaffLabel;
}
@end

