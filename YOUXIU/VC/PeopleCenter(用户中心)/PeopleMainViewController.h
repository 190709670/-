//
//  PeopleMainViewController.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseViewController.h"
#import "PeopleInfoModel.h"

@interface PeopleMainViewController : BaseViewController
@property (nonatomic, retain) NSArray *rowinfoArray;
@property (nonatomic, retain) PeopleInfoModel *peopleInfo;
@property (nonatomic, retain) UITableView *tableview;
@property (nonatomic, retain) UIImageView *headimage;
@property (nonatomic, retain) UILabel *nicknameLabel;
@property (nonatomic, retain) UILabel *myscore;
@property (nonatomic, retain) UIView *headView;
@property (nonatomic, retain) UIButton *infoBtn;
@property (nonatomic, retain) UILabel *infoCountLabel;
@property (nonatomic, retain) UIButton *RechargeBtn;
@property (nonatomic, retain) UISearchBar *searchBar;
@end
