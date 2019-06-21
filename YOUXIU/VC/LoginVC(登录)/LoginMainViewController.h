//
//  LoginMainViewController.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/5.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseViewController.h"
@protocol LoginDelegate <NSObject>
-(void)LoginSuccess:(BOOL)suc;
@end
@interface LoginMainViewController : BaseViewController
@property(nonatomic, retain) id <LoginDelegate> delegate;
@end
