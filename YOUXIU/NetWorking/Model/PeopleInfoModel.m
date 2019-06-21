//
//  PeopleInfoModel.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/6.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "PeopleInfoModel.h"

@implementation PeopleInfoModel
-(void)setValue:(id)value forKey:(NSString *)key{
    [self setArrayModelDataWithModelName:@"PeopleInfoDataModel" value:value key:key];
}
@end

@implementation PeopleInfoDataModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
}
-(void)setNilValueForKey:(NSString *)key{
}

@end
