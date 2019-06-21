//
//  BaseModel.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject 
@property(nonatomic, retain) NSString *message;
@property(nonatomic) BOOL success;
@property (nonatomic, retain) id data;
-(void)setArrayModelDataWithModelName:(NSString *)ModelName value:(id)value key:(NSString *)key;
//-(void)setArrayModelDataWithModelName:(NSString *)ModelName KeyValue:(NSString *)KeyValue value:(id)value key:(NSString *)key;
@end
