////
////  AddAreaChoosePickerView.m
////  QiXiuApp
////
////  Created by lihui on 2017/6/28.
////  Copyright © 2017年 HongJunTechnology. All rights reserved.
////
//
//#import "AddAreaChoosePickerView.h"
////#import "findAreaRootModel.h"
//#import "NetWorkingRequest.h"
//
//#define PS_CITY_PICKER_COMPONENTS 3
//#define PROVINCE_COMPONENT        0
//#define CITY_COMPONENT            1
//#define DISCTRCT_COMPONENT        2
//#define FIRST_INDEX               0
//
//#define COMPONENT_WIDTH 100 //每一列的宽度
//@interface AddAreaChoosePickerView()<UIPickerViewDelegate, UIPickerViewDataSource>
//@property (nonatomic, retain) findAreaRootDataModel *province;
//@property (nonatomic, retain) findAreaRootDataModel *city;
//@property (nonatomic, retain) findAreaRootDataModel *district;
//
//@property (nonatomic, retain) findAreaRootModel *proviceModel;
//@property (nonatomic, retain) findAreaRootModel *cityModel;
//@property (nonatomic, retain) findAreaRootModel *districtModel;
//
//@end
//@implementation AddAreaChoosePickerView
//
//- (instancetype)init{
//    self = [super init];
//    if (self)
//    {
//        self.delegate = self;
//        self.dataSource = self;
//    }
//    [[NetWorkingRequest share_MainViewRequest] FindAreaRoots_RequestSuccess:^(findAreaRootModel *info) {
//        //
//        self.proviceModel = info;
//    } failure:^(NSError *error) {
//        
//    }];
//    return self;
//}
//
//#pragma mark -UIPickerViewDelegate
//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    //3列
//    return PS_CITY_PICKER_COMPONENTS;
//}
////该方法返回值决定该控件指定列包含多少个列表项
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    switch (component)
//    {
//        case PROVINCE_COMPONENT: return self.proviceModel?[self.proviceModel.data count]:0;
//        case CITY_COMPONENT:     return self.cityModel?[self.cityModel.data count]:0;
//        case DISCTRCT_COMPONENT: return self.districtModel?[self.districtModel.data count]:0;
//    }
//    return 0;
//}
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//    UILabel *titleLabel = (UILabel *)view;
//    if (!titleLabel)
//    {
//        titleLabel = [self labelForPickerView];
//    }
//    titleLabel.text = [self titleForComponent:component row:row];
//    return titleLabel;
//}
//
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    if (component == 0) {//选择第一列
//        [BaseMethod showLoading:self.superview];
//        self.province = [self.proviceModel.data objectAtIndex:row];
//        [[NetWorkingRequest share_MainViewRequest] FindChildren_RequestareaId:[NSString stringWithFormat:@"%ld",self.province.thisid] Success:^(findAreaRootModel *info) {
//            [BaseMethod hideAllHudsInView:self.superview];
//            self.cityModel = info;
//            self.districtModel = nil;
//            [self reloadComponent:CITY_COMPONENT];
//            [self reloadComponent:DISCTRCT_COMPONENT];
//            
//            [pickerView selectRow:FIRST_INDEX inComponent:CITY_COMPONENT animated:YES];
//             [self.cityPickerDelegate cityPickerView:self finishPickProvince:self.province city:nil district:nil];
//        } failure:^(NSError *error) {
//            //
//        }];
//    }else if(component == 1){
//        [BaseMethod showLoading:self.superview];
//        
//        self.city = [self.cityModel.data objectAtIndex:row];
//        [[NetWorkingRequest share_MainViewRequest] FindChildren_RequestareaId:[NSString stringWithFormat:@"%ld",self.city.thisid] Success:^(findAreaRootModel *info) {
//            //
//            [BaseMethod hideAllHudsInView:self.superview];
//            self.districtModel = info;
//            [self reloadComponent:DISCTRCT_COMPONENT];
//            [pickerView selectRow:FIRST_INDEX inComponent:DISCTRCT_COMPONENT animated:YES];
//
//             [self.cityPickerDelegate cityPickerView:self finishPickProvince:self.province city:self.city district:nil];
//        } failure:^(NSError *error) {
//            //
//        }];
//    }else if(component == 2){
//        findAreaRootDataModel *district = [self.districtModel.data objectAtIndex:row];
//        self.district = district;
//        if([self.cityPickerDelegate respondsToSelector:@selector(cityPickerView:finishPickProvince:city:district:)]){
//            [self.cityPickerDelegate cityPickerView:self finishPickProvince:self.province city:self.city district:self.district];
//        }
//    }
// 
//}
////指定列的宽度
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    // 宽度
//    return COMPONENT_WIDTH;
//}
//#pragma mark - Private
//- (UILabel *)labelForPickerView
//{
//    UILabel *label = [[UILabel alloc] init];
//    label.textColor = [UIColor colorWithRed:85/255 green:85/255 blue:85/255 alpha:1];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.adjustsFontSizeToFitWidth = YES;
//    return label;
//}
//
//- (NSString *)titleForComponent:(NSInteger)component row:(NSInteger)row;
//{
//    
//    switch (component)
//    {
//        case PROVINCE_COMPONENT:{
//            NSString *provicename =  ((findAreaRootDataModel *)[self.proviceModel.data objectAtIndex:row]).name;
//            return provicename;
//        }break;
//        case CITY_COMPONENT:{
//            NSString *cityname = ((findAreaRootDataModel *)[self.cityModel.data objectAtIndex:row]).name;
//            return cityname;
//        }break;
//        case DISCTRCT_COMPONENT:{
//            NSString *districtname = ((findAreaRootDataModel *)[self.districtModel.data objectAtIndex:row]).name;
//            
//            return districtname;
//        }break;
//    }
//    return @"";
//}
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/
//
//@end
