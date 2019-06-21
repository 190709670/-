//
//  PeopleInfoModel.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseModel.h"

@interface PeopleInfoModel : BaseModel
@end

@interface PeopleInfoDataModel : NSObject
@property (nonatomic) NSInteger status;
@property (nonatomic) NSInteger balance;
@property (nonatomic, retain) NSString *userName;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *logonDate;
@property (nonatomic, retain) NSString *account;
@property (nonatomic, retain) NSString *sex;
@property (nonatomic, retain) NSString *repassword;
@property (nonatomic, retain) NSString *icon;
@property (nonatomic, retain) NSString *lastConsumeDate;
@property (nonatomic, retain) NSString *lastRechargeDate;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *validate;
@end

