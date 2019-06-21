//
//  GuidePageViewController.h
//  QiXiuApp
//
//  Created by lihui on 2017/5/31.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GuidePageDelegate<NSObject>
-(void)guidePageDisapper;
@end

@interface GuidePageViewController : UIViewController

@property (nonatomic, retain) NSArray *GuideImageArray;
@property (nonatomic, retain) UIScrollView *GuideScrollView;
@property (nonatomic, retain) UIPageControl *pagecontrol;

@property (nonatomic, retain) id <GuidePageDelegate> delegate;
@end
