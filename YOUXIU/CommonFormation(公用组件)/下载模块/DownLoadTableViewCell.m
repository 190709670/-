//
//  DownLoadTableViewCell.m
//  YOUXIU
//
//  Created by lihui on 2018/3/22.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import "DownLoadTableViewCell.h"
#import <UAProgressView/UAProgressView.h>
#import "DownLoadMetch.h"
@interface DownLoadTableViewCell()<DownLoadDelegate>
@property (nonatomic, strong) UAProgressView *circleProgress;
@property (nonatomic, strong) UIButton *DownBtn;
@property (nonatomic, strong) NSString *DownLoadURL;
//@property (nonatomic, strong) LoadMetchod *DownLoadCell_DownLoadTask;
@property (nonatomic, strong) UILabel *DownLoadLabel;
@end

@implementation DownLoadTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.circleProgress = [[UAProgressView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [self.circleProgress setLineWidth:2];
        [self.circleProgress setBorderWidth:2];
        [self.circleProgress setTintColor:[UIColor redColor]];
        
        self.DownLoadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [self.DownLoadLabel setFont:[UIFont systemFontOfSize:10]];
        [self.DownLoadLabel setTextColor:[UIColor whiteColor]];
        [self.DownLoadLabel setBackgroundColor:[UIColor clearColor]];
        [self.DownLoadLabel setTextAlignment:NSTextAlignmentCenter];
        self.DownLoadLabel.numberOfLines = 0;
        self.circleProgress.centralView = self.DownLoadLabel;
        __weak DownLoadTableViewCell *this = self;
//        [self.circleProgress setDidSelectBlock:^(UAProgressView *progressView) {
//            switch (this.DownLoadCell_DownLoadTask.task.state) {
//                case NSURLSessionTaskStateRunning:{
//                    //正在下载，暂停下载
//                    [this.DownLoadCell_DownLoadTask.task suspend];
//                    [this.DownLoadLabel setText:@"暂停"];
//                } break;
//                case NSURLSessionTaskStateSuspended:{
//                    //推迟下载，开始下载
//                    [this.DownLoadCell_DownLoadTask.task resume];
//                }break;
//                case NSURLSessionTaskStateCanceling:{
//                    //取消下载，开始下载
//                    [this.DownLoadCell_DownLoadTask.task resume];
//                }break;
//                case NSURLSessionTaskStateCompleted:{
//                    //已经下载完成；
//
//                }break;
//                default:
//                    break;
//            }
//        }];
        [self.contentView addSubview:self.circleProgress];
    }
    return self;
}
-(void)setCellDownLoadTask:(NSString *)downloadurl{
    self.DownLoadURL = downloadurl;
//    self.DownLoadCell_DownLoadTask = [[LoadMetchod alloc]init];
//    [self.DownLoadCell_DownLoadTask GetTaskWithDownLoadURL:self.DownLoadURL];
//    self.DownLoadCell_DownLoadTask.delegate = self;
}

#pragma mark DownLoadMetchDelegate
-(void)DownLoadRateWith:(NSProgress *)progress{
    CGFloat rate = progress.fractionCompleted;
    [self.circleProgress setTintColor:[UIColor redColor]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setProgressValue:rate];
        NSLog(@"设置下载比例： %f",rate);
        [self.DownLoadLabel setText:[NSString stringWithFormat: @"下载\n %.2fM/%.2fM",progress.completedUnitCount/(1024.00*1024.00),progress.totalUnitCount/(1024.00*1024.00)]];
        NSLog(@"1:%@   2:%@",progress.localizedDescription,progress.localizedAdditionalDescription);
    });
}
-(void)DownLoadCompletionSuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.circleProgress setFillColor:[UIColor grayColor]];
    NSLog(@"下载成功");
    [self.DownLoadLabel setText: @"下载\n完成"];
    });
}
-(void)DownLoadCompletionFailure:(NSURLResponse *)response file:(NSURL *)filepath error:(NSError *)error{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.circleProgress setFillColor:[UIColor purpleColor]];
    NSLog(@"下载失败");
    [self.DownLoadLabel setText: @"下载\n失败"];
    });
}
-(void)UnZipRateWith:(CGFloat)Rate{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.circleProgress setTintColor:[UIColor purpleColor]];
    [self setProgressValue:Rate];
    NSLog(@"解压比例：%f",Rate);
    [self.DownLoadLabel setText:[NSString stringWithFormat: @"解压\n %f",Rate]];
    });
}
-(void)UnZipSuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.circleProgress setFillColor:[UIColor grayColor]];
    NSLog(@"解压成功");
    [self.DownLoadLabel setText: @"解压\n成功"];
    });
}
-(void)UnZipFailure{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.circleProgress setFillColor:[UIColor purpleColor]];
    NSLog(@"解压失败");
    [self.DownLoadLabel setText: @"解压\n失败"];
    });
}
#pragma mark privateMetch
-(void)setProgressValue:(CGFloat)progressvalue{
    [self.circleProgress setProgress:progressvalue animated:YES];
}
-(NSInteger)getCellHeight{
    return 70;
}
-(void)setDownLoadCell{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
