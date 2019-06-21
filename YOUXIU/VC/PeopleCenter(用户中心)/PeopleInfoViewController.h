//
//  PeopleInfoViewController.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseViewController.h"
#import "PeopleInfoModel.h"
typedef NS_ENUM(NSInteger, actiontype) {
    witchaction_headimage = 1,
    witchaction_sex = 2,
    witchalert_nickname =3,
    witchalert_Password=4
};

@interface PeopleInfoViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) UITableView *mainTableView;
@property (nonatomic, retain) NSMutableArray *peopleinfoArray;
@property (nonatomic, retain) UILabel *accountLabel;
@property (nonatomic, retain) UILabel *nickNameLabel;
@property (nonatomic, retain) UIImageView *headImageView;
@property (nonatomic, retain) UILabel *sexLabel;
@property (nonatomic, retain) UILabel *emailLabel;
@property (nonatomic, retain) UIButton *btn;
@property (nonatomic, retain) PeopleInfoModel *peopleinfo;
@property (nonatomic) BOOL haveAlert;

@end
