//
//  BaseModel.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
-(void)setNilValueForKey:(NSString *)key{

}
-(void)setValue:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass:[NSString class]]) {
        if (value == nil) {
            value = @"";
        }else{
            [super setValue:value forKey:key];
        }
    }else{
        [super setValue:value forKey:key];
    }
}
-(void)setArrayModelDataWithModelName:(NSString *)ModelName value:(id)value key:(NSString *)key{
    if([key isEqualToString:@"data"]){
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray *dataArray = value;
            for (NSDictionary *dic in dataArray) {
                id modelClass = [[NSClassFromString(ModelName) alloc] init];
                [modelClass setValuesForKeysWithDictionary:dic];
                if (self.data == nil) {
                    self.data = [[NSMutableArray alloc] init];
                }
                [self.data addObject:modelClass];
            }
        }else if([value isKindOfClass:[NSDictionary class]]){
            id modelClass = [[NSClassFromString(ModelName) alloc] init];
            [modelClass setValuesForKeysWithDictionary:value];
            self.data = modelClass;
        }else {
            [super setValue:value forKey:key];
        }
    }else{
        [super setValue:value forKey:key];
    }
}


@end
