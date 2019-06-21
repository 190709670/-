//
//  MacroDefine.h
//  YOUXIU
//
//  Created by lihui on 2018/4/10.
//  Copyright © 2018年 WondersGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#define ThemeRedColor [UIColor colorWithRed:246/255.0f green:65/255.0f blue:60/255.0f alpha:1]
#define PhoneIsPlus [UIScreen mainScreen].bounds.size.width == 414
#define Macro_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Macro_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Macro_ScreenBound [UIScreen mainScreen].bounds
#define Macro_AutoWidth_7p(X) (X/414.00)*[UIScreen mainScreen].bounds.size.width
#define Macro_AutoHeight_7p(X) (X/736.00)*[UIScreen mainScreen].bounds.size.height
#define Macro_AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// rgb颜色转换（16进制->10进制）
#define Macro_UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define Macro_AutoFont_7p(X) PhoneIsPlus?X:(X-2)
#define Macro_ViewBackColor [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1]

