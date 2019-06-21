//
//  VideoPlayView.h
//  YOUXIU
//
//  Created by lihui on 2018/3/28.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VideoPlayDelegate<NSObject>
-(void)VideoTuPuClick:(NSString *)BtnName;
@end
@interface VideoPlayView : UIView
@property (nonatomic, strong) id <VideoPlayDelegate> delegate;
@property (nonatomic, assign) BOOL showTuPu;
-(void)SetPlayerIsLocal:(BOOL)Local withVideoURL:(NSString *)VideoURL;
-(void)StopPlay;
-(void)StartPlay;
@end
