//
//  RootTabBarViewController.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "MainViewController.h"
#import "PeopleMainViewController.h"
#import "BaseNavigationViewController.h"
#import "GuidePageViewController.h"
#import "LoginMainViewController.h"
#import "PlayRecodeMainViewController.h"
#import "ShoppingCartMainViewController.h"
#import "AlreadyBuyedMainViewController.h"
#import "NetWorkingRequest.h"
@interface RootTabBarViewController ()<UITabBarControllerDelegate,LoginDelegate>
@property(nonatomic, retain) LoginMainViewController *loginVC;
@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setObject];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)setObject{
    [self.tabBar setTintColor:ThemeRedColor];
    [self.tabBar setTranslucent:NO];
    self.delegate = self;
    NSArray *itemParams =@[
                           @{
                               @"itemImageName":@"prec",
                               @"itemSelected_ImageName":@"prec_dis",
                               @"itemTitle":@"首页",
                               @"ClassName":@"MainPageViewController"
                               },
                           @{
                               @"itemImageName":@"shopping",
                               @"itemSelected_ImageName":@"shopping_dis",
                               @"itemTitle":@"购物车",
                               @"ClassName":@"ShoppingCartMainViewController"
                               },
                           @{
                               @"itemImageName":@"apur",
                               @"itemSelected_ImageName":@"apur_dis",
                               @"itemTitle":@"已购买",
                               @"ClassName":@"AlreadyBuyedMainViewController"
                               },
                           @{
                               @"itemImageName":@"per",
                               @"itemSelected_ImageName":@"per_dis",
                               @"itemTitle":@"个人中心",
                               @"ClassName":@"PeopleMainViewController"
                               },
                           ];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < itemParams.count; i++) {
        NSDictionary *itmeParam = [itemParams objectAtIndex:i];
        NSString *title = itmeParam[@"itemTitle"];
        NSString *imagename = itmeParam[@"itemImageName"];
        NSString *selectedImageName = itmeParam[@"itemSelected_ImageName"];
        NSString *className = itmeParam[@"ClassName"];
        
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imagename] selectedImage:[UIImage imageNamed:selectedImageName]];
        UIViewController *VC = [[NSClassFromString(className) alloc] init];
        VC.tabBarItem = item;
        
        BaseNavigationViewController *navVC = [[BaseNavigationViewController alloc] initWithRootViewController:VC];
        if ([className isEqualToString:@"MainPageViewController"]||
            [className isEqualToString:@"ShoppingCartMainViewController"]||
            [className isEqualToString:@"AlreadyBuyedMainViewController"]) {
            [VC.navigationController.navigationBar setHidden:NO];
        }else{
            [VC.navigationController.navigationBar setHidden:NO];
        }
        
        [mutableArray addObject:navVC];
    }
    self.viewControllers = mutableArray;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UINavigationController *navVC = (UINavigationController *)viewController;
    NSLog(@"VC :%@",[navVC.viewControllers objectAtIndex:0]);

    if ([[navVC.viewControllers objectAtIndex:0] isKindOfClass:[PeopleMainViewController class]] ||
        [[navVC.viewControllers objectAtIndex:0] isKindOfClass:[ShoppingCartMainViewController class]] ||
        [[navVC.viewControllers objectAtIndex:0] isKindOfClass:[AlreadyBuyedMainViewController class]]) {
        if ([BaseMethod UserIsLogin]) {
            return YES;
        }else{
            if (self.loginVC == nil) {
                self.loginVC = [[LoginMainViewController alloc] init];
                self.loginVC.delegate = self;
            }
            BaseNavigationViewController *nav = [[BaseNavigationViewController alloc] initWithRootViewController:self.loginVC];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}

// LoginMainViewController delegate
-(void)LoginSuccess:(BOOL)suc{
    if(suc){
        [self setSelectedIndex:3];
    }else{
        
    }
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
