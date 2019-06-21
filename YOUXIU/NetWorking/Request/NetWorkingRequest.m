//
//  NetWorkingRequest.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "NetWorkingRequest.h"
#import "RequestURLDefine.h"
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>
//#import "TopicListModel.h"

@implementation NetWorkingRequest
//-(void)FindCarBrandAll_Request_Success:(void(^)(findCarBrandAllModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarBrandAll_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findCarBrandAllModel *model = [[findCarBrandAllModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarBrandWithCarID_Request:(NSString *)CarID Success:(void(^)(findCarBrandAllModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarBrand_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":CarID
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findCarBrandAllModel *model = [[findCarBrandAllModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindCarBrandByFast_Request:(NSString *)fast Success:(void(^)(findCarBrandAllModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarBrand_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":fast
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findCarBrandAllModel *model = [[findCarBrandAllModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarSeriesByBrand_Request:(NSString *)brandId Success:(void(^)(CarSeriesModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarSeriesByBrand_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"brandId":brandId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarSeriesModel *model = [[CarSeriesModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarSeriesAll_RequestSuccess:(void(^)(CarSeriesModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarSeriesAll_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarSeriesModel *model = [[CarSeriesModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarSeries_Request:(NSString *)carid Success:(void(^)(CarSeriesModel *info))success failure:(void(^)(NSError *error))failure
//{
//    NSString *url = [RequestURLDefine getFindCarSeries_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":carid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarSeriesModel *model = [[CarSeriesModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarModelBySeries_Request:(NSString *)seriesId Success:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarModelBySeries_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"seriesId":seriesId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarModelModel *model = [[CarModelModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindCarModelByBrand_Request:(NSString *)brandId Success:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarModelByBrand_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"brandId":brandId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarModelModel *model = [[CarModelModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarModelAll_RequestSuccess:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarModelAll_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarModelModel *model = [[CarModelModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)FindCarModel_Request:(NSString *)carid Success:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCarModel_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":carid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CarModelModel *model = [[CarModelModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindCategoryAll_RequestSuccess:(void(^)(findCategoryAllModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCAtegoryAll_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findCategoryAllModel *model = [[findCategoryAllModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindCategory_Request:(NSString *)thisid Success:(void(^)(findCategoryAllModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCategory_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":thisid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findCategoryAllModel *model = [[findCategoryAllModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindCategoryChildren_Request:(NSString *)thisid Success:(void(^)(findCategoryAllModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindCategoryChildren_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":thisid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findCategoryAllModel *model = [[findCategoryAllModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindAreaRoot_RequestSuccess:(void(^)(findAreaRootModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindAreaRoot_URL];
//    NSDictionary *params = @{
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findAreaRootModel *model = [[findAreaRootModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindAreaRoots_RequestSuccess:(void(^)(findAreaRootModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindAreaRoots_URL];
//    NSDictionary *params = @{
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findAreaRootModel *model = [[findAreaRootModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)FindChildren_RequestareaId:(NSString *)areaId Success:(void(^)(findAreaRootModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getFindChildren_URL];
//    NSDictionary *params = @{
//                             @"areaId":areaId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        findAreaRootModel *model = [[findAreaRootModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
-(void)SendMobileCaptcha_doRegister_Request:(NSString *)mobile step:(NSString *)step password:(NSString *)password validate:(NSString *)validate Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine getDoRegister_URL];
    NSDictionary *params;

    if ([step intValue] == 1) {
        params = @{
                   @"mobile":mobile,
                   @"step":step,
                   @"keyid":[BaseMethod getEncryAes128KeyID]
                   };
    }else if ([step intValue] == 2){
        params = @{
                   @"mobile":mobile,
                   @"step":step,
                   @"password":password,
                   @"validate":validate,
                   @"keyid":[BaseMethod getEncryAes128KeyID]
                   };
    }

    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}




//
//-(void)SendUserLogin_loginout_Request:(NSString *)mobile Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getLogout_URL];
//    NSDictionary *params;
//
//    params = @{
//               @"mobile":mobile,
//               @"keyid":[BaseMethod getEncryAes128KeyID]
//               };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//
//        if (model.success) {
//            [BaseMethod SetUserLogin:NO];
//            [BaseMethod DelegateUserInfo];
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

//-(void)SentDoEdit_RequestNickName:(NSString *)nickname icon:(NSString *)icon gender:(NSString *)gender Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetMemberDoEdit_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"moauth":modelinfo.moauth,
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"nickname":nickname?nickname:@"",
//                             @"name":modelinfo.name?modelinfo.name:@"",
//                             @"icon":icon?icon:@"",
//                             @"gender":gender
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//
//}
//

//
//-(void)SendGetReceiverList_RequestSuccess:(void(^)(ReceiverListModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getReceiverList_URL];
//    NSDictionary *params;
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    params = @{
//               @"moauth":modelinfo.moauth,
//               @"keyid":[BaseMethod getEncryAes128KeyID]
//               };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        ReceiverListModel *model = [[ReceiverListModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)SendReceiverDoAdd_Request:(NSString *)consignee address:(NSString *)address phone:(NSString *)phone isDefault:(NSString *)isDefault provinceId:(NSString *)provinceId cityId:(NSString *)cityId districtId:(NSString *)districtId success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getReceiverDoAdd_URL];
//    NSDictionary *params;
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    params = @{
//               @"moauth":modelinfo.moauth,
//               @"keyid":[BaseMethod getEncryAes128KeyID],
//               @"consignee":consignee,
//               @"address":address,
//               @"phone":phone,
//               @"isDefault":isDefault,
//               @"provinceId":provinceId,
//               @"cityId":cityId,
//               @"districtId":districtId
//               };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendReceiverDoEdit_Request:(NSString *)consignee peopleID:(NSString *)peopleID address:(NSString *)address phone:(NSString *)phone isDefault:(NSString *)isDefault provinceId:(NSString *)provinceId cityId:(NSString *)cityId districtId:(NSString *)districtId success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getReceiverDoEdit_URL];
//    NSDictionary *params;
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    params = @{
//               @"moauth":modelinfo.moauth,
//               @"keyid":[BaseMethod getEncryAes128KeyID],
//               @"consignee":consignee,
//               @"address":address,
//               @"phone":phone,
//               @"isDefault":isDefault,
//               @"provinceId":provinceId,
//               @"cityId":cityId,
//               @"districtId":districtId,
//               @"id":peopleID
//               };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendGetReceiverFind_RequestPeopleId:(NSString *)PeopleId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getReceiverFind_URL];
//    NSDictionary *params;
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    params = @{
//               @"moauth":modelinfo.moauth,
//               @"keyid":[BaseMethod getEncryAes128KeyID],
//               @"id":PeopleId
//               };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)SendReceiverDoDefault:(NSString *)peopleID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getReceiverDoDefault_URL];
//    NSDictionary *params;
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    params = @{
//               @"moauth":modelinfo.moauth,
//               @"keyid":[BaseMethod getEncryAes128KeyID],
//               @"id":peopleID
//               };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendMemberDoShopInfoWithProvinceId:(NSString *)provinceId cityId:(NSString *)cityId districtId:(NSString *)districId address:(NSString *)address bizNo:(NSString *)bizNo shopName:(NSString *)shopName shpImageName:(NSString *)shopImageName Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetMemberDoShopInfo_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"provinceId":provinceId,
//                             @"cityId":cityId,
//                             @"districtId":districId,
//                             @"address":address,
//                             @"bizNo":bizNo,
//                             @"shopName":shopName,
//                             @"shopImage":shopImageName?shopImageName:@""
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)SendProductSearchKeyword:(NSString *)keyword brandID:(NSString *)brandID seriesID:(NSString *)seriesId modelId:(NSString *)modelId categoryId:(NSString *)categoryId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize order:(NSString *)order sort:(NSString *)sort Success:(void(^)(ProductSearchModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetProductSearch_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"keyword":keyword,
//                             @"brandId":brandID,
//                             @"seriesId":seriesId,
//                             @"modelId":modelId,
//                             @"categoryId":categoryId,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize,
//                             @"order":order,
//                             @"sort":sort
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        ProductSearchModel *model = [[ProductSearchModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendProductListbrandID:(NSString *)brandID seriesID:(NSString *)seriesId modelId:(NSString *)modelId categoryId:(NSString *)categoryId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize order:(NSString *)order sort:(NSString *)sort Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetProduct_list_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"brandId":brandID,
//                             @"seriesId":seriesId,
//                             @"modelId":modelId,
//                             @"categoryId":categoryId,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize,
//                             @"order":order,
//                             @"sort":sort
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)SendProductInfoID:(NSString *)goodID Success:(void(^)(GoodsDetailModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetProduct_Info_URL];
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"id":goodID,
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        GoodsDetailModel *model = [[GoodsDetailModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCartQuantitySuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_Quantity_ULR];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    if(peopleinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCartDoAddProductId:(NSString *)productId quanitity:(NSString *)quantity Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_DoAdd_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    if(peopleinfo.data == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"productId":productId,
//                             @"quantity":quantity
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCartDoEditId:(NSString *)CartitemId quanitity:(NSString *)quantity Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_DoEdit_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":CartitemId,
//                             @"quantity":quantity
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCartDoDeleteId:(NSString *)CartitemId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_Delete_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":CartitemId
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCartListSuccess:(void(^)(CollectionGoodsModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_List_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CollectionGoodsModel *model = [[CollectionGoodsModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCartDoClearSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_DoClear_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
////收藏
//-(void)SendFavoriteAddproductId:(NSString *)productId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetFavorite_Add_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"productId":productId
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendFavoriteCancelproductId:(NSString *)productId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetFavorite_Cancel_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"productId":productId
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(id)SendSynFavoriteCancelproductId:(NSString *)productId {
//    NSString *url = [RequestURLDefine GetFavorite_Cancel_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return nil;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"productId":productId
//                             };
//
//  return [self RequestSynWithGet:url parameters:params];
//}
//
//-(void)SendfavoriteListSuccess:(void(^)(ProductSearchModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetFavorite_List_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        ProductSearchModel *model = [[ProductSearchModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
////返回提示：购物车为空，预生成订单失败
//-(void)SendOrderCheckoutSuccess:(void(^)(OrderCheckoutModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_Checkout_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        OrderCheckoutModel *model = [[OrderCheckoutModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendOrderCalculateReceiverId:(NSString *)receiverid shippingMethodid:(NSString *)shippingMethodId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_Calculate_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"receiverId":receiverid,
//                             @"shippingMethodId":shippingMethodId
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendOrderCreateReceiverId:(NSString *)receiverid shippingMethodid:(NSString *)shippingMethodId cartToken:(NSString *)cartToken memo:(NSString *)memo Success:(void(^)(OrderCreateModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_Create_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"receiverId":receiverid,
//                             @"shippingMethodId":shippingMethodId,
//                             @"cartToken":cartToken,
//                             @"memo":memo
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        OrderCreateModel *model = [[OrderCreateModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendOrderViewSn:(NSString *)sn Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_View_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"sn":sn
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendOrderCancelSn:(NSString *)sn Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_Cancel_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"sn":sn
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendOrderReceiveSn:(NSString *)sn Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_Receive_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"sn":sn
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendOrderListType:(NSString *)type Success:(void(^)(OrderListModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetOrder_List_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"type":type
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        OrderListModel *model = [[OrderListModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
//-(void)SendCartDoBatchDelete:(NSArray *)ids Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCart_DoBatchDelete_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    NSMutableString *idsString = [[NSMutableString alloc] init];
//    for (NSString *string in ids) {
//        [idsString appendFormat:@"%@-",string];
//    }
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"ids":idsString
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCommonFindHotSearchSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCommon_FindHotSearchs_URL];
//
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendCommonFindBannersSuccess:(void(^)(BannerModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetCommon_FindBanners_URL];
//
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BannerModel *model = [[BannerModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendProductGoodsTopSuccess:(void(^)(GoodsDetailModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetProduct_GoodsTop_URL];
//
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        GoodsDetailModel *model = [[GoodsDetailModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendVinQuery:(NSString *)VinCode Success:(void(^)(VinQueryModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetVinQuery_URL];
//
//    NSDictionary *params = @{
//                             @"code":VinCode,
//                             @"keyid":[BaseMethod getEncryAes128KeyID]
//
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        VinQueryModel *model = [[VinQueryModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendVinQueryParts:(NSString *)VinCode pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize order:(NSString *)order sort:(NSString *)sort Success:(void(^)(ProductSearchModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetVinQueryParts_URL];
//
//    NSDictionary *params = @{
//                              @"code":VinCode,
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                              @"pageNo":[NSNumber numberWithInteger:pageNo],
//                              @"pageSize":[NSNumber numberWithInteger:pageSize],
//                              @"order":order,
//                              @"sort":sort
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        ProductSearchModel *model = [[ProductSearchModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//
////社区论坛
///**
// 发布话题
// */
//-(void)SendTopic_PublishRequestWithType:(NSString *)Type Kind:(NSString *)Kind Title:(NSString *)Title Content:(NSString *)Content images:(NSArray *)images Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_Publish_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//
//    NSMutableString *imagesString = [[NSMutableString alloc] init];
//    for (int i = 0; i < [images count]; i++) {
//        if (i == 0) {
//            [imagesString appendFormat:@"[\"%@",[images objectAtIndex:i]];
//        }else if(i == [images count]-1){
//            [imagesString appendFormat:@"\",\"%@\"]",[images objectAtIndex:i]];
//        }else{
//            [imagesString appendFormat:@"\",\"%@",[images objectAtIndex:i]];
//        }
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"type":Type,
//                             @"kind":Kind,
//                             @"title":Title,
//                             @"content":Content,
//                             @"images":imagesString
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
////
////    for (NSInteger i  = 0; i < [images count]; i++) {
////        PHAsset *imageAsset = [images objectAtIndex:i];
////
////        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
////        // 同步获得图片, 只会返回1张图片
////        options.synchronous = YES;
////        // 是否要原图
////        CGSize size = CGSizeMake(imageAsset.pixelWidth, imageAsset.pixelHeight);
////        // 从asset中获得图片
////        [[PHImageManager defaultManager] requestImageForAsset:imageAsset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
////            UIImage *imageview = result;
////            //  上传图片
////            NSString *Imageurl = [RequestURLDefine getUpLoadImage_URL];
////
////            NSData *imagedata =UIImageJPEGRepresentation(imageview, 0.1);
////
////            NSDictionary *ImageParams;
////            ImageParams = @{
////                       @"keyid":[BaseMethod getEncryAes128KeyID]
////                       };
////            [[self getManager] POST:Imageurl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
////                [formData appendPartWithFileData:imagedata name:[imageAsset.creationDate description] fileName:[imageAsset.creationDate description] mimeType:@"image/png"];
////            } progress:^(NSProgress * _Nonnull uploadProgress) {
////
////            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////                BaseModel *model = [[BaseModel alloc] init];
////                [model setValuesForKeysWithDictionary:responseObject];
////                success(model);
////            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
////                failure(error);
////            }];
////        }];
////    }
//
//
//}
///**
// 3.62编辑话题
//
// */
//-(void)SendTopic_EditRequestWithID:(NSString *)thisid title:(NSString *)title content:(NSString *)content images:(NSArray *)images Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_Edit_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":thisid,
//                             @"title":title,
//                             @"content":content,
//                             @"images":images
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 删除话题
// */
//-(void)SendTopic_CancelRequestWithID:(NSString *)Thisid Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_Cancel_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":Thisid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.64话题点赞
// */
//-(void)SendTopic_GiveThumbRequestWithID:(NSString *)ThisID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_GiveThumb_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":ThisID
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.65取消话题点赞
// */
//-(void)SendTopic_CancelThumbRequestWithID:(NSString *)Thisid Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_CancelThumb_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":Thisid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.66话题列表
// */
//-(void)SendTopic_ListRequestWithPageSize:(NSString *)pageSize pageNo:(NSString *)pageNo type:(NSString *)type kind:(NSString *)kind Success:(void(^)(TopicListModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_List_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize,
//                             @"type":type,
//                             @"kind":kind
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        TopicListModel *model = [[TopicListModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.67话题详情
// */
//-(void)SendTopic_InfoRequestWithID:(NSString *)Thisid Success:(void(^)(TopicDetailModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_Info_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":Thisid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        TopicDetailModel *model = [[TopicDetailModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.68我的帖子
// */
//-(void)SendTopic_myTopicsRequestWithpageNo:(NSString *)pageNo pageSize:(NSString *)pageSize type:(NSString *)type kind:(NSString *)kind Success:(void(^)(TopicListModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_myTopics_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize,
//                             @"type":type,
//                             @"kind":kind
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        TopicListModel *model = [[TopicListModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.69我点赞的帖子
// */
//-(void)SendTopic_myThumbTopicsRequestWithpageNo:(NSString *)pageNo pageSize:(NSString *)pageSize type:(NSString *)type kind:(NSString *)kind Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetTopic_myThumbTopics_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize,
//                             @"type":type,
//                             @"kind":kind
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
///**
// 3.70发表评论
// */
//-(void)SendComment_PublishRequestWithTopicId:(NSString *)topicId content:(NSString *)content Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_Publish_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"topicId":topicId,
//                             @"content":content
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_ReplyRequestWithTopicId:(NSString *)topicId commentId:(NSString *)commentId content:(NSString *)content Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_Reply_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"topicId":topicId,
//                             @"commentId":commentId,
//                             @"content":content
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_EditRequestWithID:(NSString *)thisId content:(NSString *)content Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_Edit_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":thisId,
//                             @"content":content
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_CancelRequestWithID:(NSString *)thisId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_Cancel_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":thisId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_GiveThumpRequestWithID:(NSString *)thisId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_GiveThump_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":thisId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_CancelThumpRequestWithID:(NSString *)thisId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_CancelThump_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":thisId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_myCommentsRequestWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize Success:(void(^)(CommentModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_myComments_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CommentModel *model = [[CommentModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_myThumbCommentsRequestWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_myThumbComments_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
//-(void)SendComment_TopicCommentsWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize TopicId:(NSString *)topicId Success:(void(^)(CommentModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_TopicComments_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"pageNo":pageNo,
//                             @"pageSize":pageSize,
//                             @"topicId":topicId
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CommentModel *model = [[CommentModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
////3.79 commentid 评论id
//-(void)SendComment_InfoWithCommentId:(NSString *)commentid Success:(void(^)(CommentDetailModel  *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_CommentInfo_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":commentid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        CommentDetailModel *model = [[CommentDetailModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
////3.80
//-(void)SendComment_getReplysWithCommentId:(NSString *)commentid Success:(void(^)(DiscussReplayModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine GetComment_GetReplysInfo_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":commentid
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        DiscussReplayModel *model = [[DiscussReplayModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}

//-(void)SendReceiverDoRemoveReceiverPeopleID:(NSString *)peopleID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
//    NSString *url = [RequestURLDefine getReceiverDoRemove_URL];
//    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
//    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
//
//    if(modelinfo == nil){
//        [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
//        return;
//    }
//    NSDictionary *params = @{
//                             @"keyid":[BaseMethod getEncryAes128KeyID],
//                             @"moauth":modelinfo.moauth,
//                             @"id":peopleID,
//                             };
//    [self RequestWithGet:url parameters:params success:^(id result) {
//        BaseModel *model = [[BaseModel alloc] init];
//        [model setValuesForKeysWithDictionary:result];
//        if (model.success) {
//
//        }
//        success(model);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//}
#pragma mark 优秀钢琴

//3.1 查看短信接口
-(void)RequestCommonLookMobile:(NSString *)mobile Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetApiCommonLook_URL];
    NSDictionary *params = @{
                             @"mobile":mobile
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 3.6 3.7
 申请忘记发送验证码/提交忘记密码
 @param mobile 手机号
 @param step 步骤，1，2
 @param success 1
 @param failure 1
 */
-(void)SendMobileCaptcha_doForgetPwd_Request:(NSString *)mobile step:(NSString *)step password:(NSString *)password validate:(NSString *)validate Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine getDoForgetPwd_URL];
    NSDictionary *params;
    
    if ([step intValue] == 1) {
        params = @{
                   @"mobile":mobile,
                   @"step":step,
                   @"keyid":[BaseMethod getEncryAes128KeyID]
                   };
    }else if ([step intValue] == 2){
        params = @{
                   @"mobile":mobile,
                   @"step":step,
                   @"password":password,
                   @"validate":validate,
                   @"keyid":[BaseMethod getEncryAes128KeyID]
                   };
    }
    
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
///** 3.4
// 登录验证
//
// @param mobile 1
// @param password 1
// @param success 1
// @param failure 1
// */
-(void)SendUserLogin_login_Request:(NSString *)mobile password:(NSString *)password Success:(void(^)(PeopleInfoModel  *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine getLogin_URL];
    NSDictionary *params;
    
    params = @{
               @"mobile":mobile,
               @"password":password,
               @"keyid":[BaseMethod getEncryAes128KeyID]
               };
    
    [self RequestWithGet:url parameters:params success:^(id result) {
        PeopleInfoModel *model = [[PeopleInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            //保存用户登录信息和状态
            [BaseMethod SetUserInfo:result];
            [BaseMethod SetUserLogin:YES];
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.26根据会员手机号查询会员资料
 
 @param success 1
 @param failure 1
 */
-(void)SendFindByOauth_RequestSuccess:(void(^)(PeopleInfoModel *peopleinfo))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMemberFindByOauth_URL];
    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
    if(modelinfo == nil){
      //  [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
        NSError *error;
        error = [NSError errorWithDomain:@"请先登录" code:400 userInfo:nil];
         failure(error);
        return;
    }
    NSDictionary *params = @{
                             @"account":modelinfo.account,
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        PeopleInfoModel *model = [[PeopleInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            //保存用户登录信息和状态
            [BaseMethod SetUserInfo:result];
            [BaseMethod SetUserLogin:YES];
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.5 退出登录
 @param mobile 手机号
 */
-(void)SendLogoutMobile:(NSString *)mobile Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine getLogout_URL];
    NSDictionary *params;
    params = @{
               @"mobile":mobile,
               @"keyid":[BaseMethod getEncryAes128KeyID]
               };
    
    [self RequestWithGet:url parameters:params success:^(id result) {
        PeopleInfoModel *model = [[PeopleInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            //保存用户登录信息和状态
            [BaseMethod SetUserInfo:result];
            [BaseMethod SetUserLogin:YES];
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
////3.10 修改密码
-(void)SendMemberDoEditPwd:(NSString *)CurrentPassWord password:(NSString *)password Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine getDoEditPwd_URL];
    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;

    if(modelinfo == nil){
       // [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
       NSError *error = [NSError errorWithDomain:@"请先登录" code:400 userInfo:nil];
        failure(error);
        return;
    }
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"acount":modelinfo.account,
                             @"currentPassword":CurrentPassWord,
                             @"password":password
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if (model.success) {

        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/** 3.11
 上传图片
 
 @param image 1
 @param success 1
 @param failure 1
 */
-(void)SentuploadImage_Request:(UIImage *)image imageName:(NSString *)ImageName Progress:(void (^)(NSProgress *progress))Progress Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine getUpLoadImage_URL];
    NSData *imagedata =UIImageJPEGRepresentation(image, 0.1);
    NSDictionary *params;
    params = @{
               @"keyid":[BaseMethod getEncryAes128KeyID]
               };
    [[self getManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        [formData appendPartWithFileData:imagedata name:@"image" fileName:[NSString stringWithFormat:@"%@.png",ImageName] mimeType:@"image/png"];
    } progress:^(NSProgress *uploadProgress) {
        Progress(uploadProgress);
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:responseObject];
        success(model);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}
/**3.12
 查询所有级别
 */
-(void)SendRankFindAllSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetRankFindAll_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/** 3.13
 根据ID查询级别
 @param ID 级别ID
 */
-(void)SendRankFindID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetRankFind_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.14 查询所有类别
 */
-(void)SendStyleCategoryFindAllSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetStylecategoryFindAll_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.15 根据ID查询类别
 @param ID 类别ID
 */
-(void)SendStylecategoryFindWithID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetStylecateGoryFind_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.16 根据ID查询乐曲信息
 @param ID 乐曲ID
 */
-(void)SendMusicInfoWithMusicID:(NSString *)ID type:(NSString *)type Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMusicInfo_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID,
                             @"type":type,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.17 获取五线谱图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetWxpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMusicGetWxp_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.18 获取简五谱 图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetJwpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMusicGetJwp_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.19 获取固定谱 图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetGdpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMusicGetGdp_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.20 获取首调谱 图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetSdpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMusicGetSdp_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":ID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.21 获取搜索关键字
 */
-(void)SendHotsongGetSearchWordSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetHotSongGetSearchWords_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.22 获取标签墙
 */
//标签墙
-(void)RequestWallTagSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetHotSongWallTag_URL];
    [self RequestWithGet:url parameters:nil success:^(id result) {
        BaseModel *WallInfo = [[BaseModel alloc] init];
        [WallInfo setValuesForKeysWithDictionary:result];
        if(WallInfo.success){
            
        }
        success(WallInfo);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.23 热门单曲列表
 */
-(void)RequestHotsongListWithCategorId:(NSString *)categoryId rank:(NSString *)rank Account:(NSString *)Account PageNo:(NSInteger)PageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetHotsongList_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"categoryId":categoryId,
                             @"rank":rank,
                             @"account":Account,
                             @"pageNo":[NSNumber numberWithInteger:PageNo]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.24 热门单曲关键字搜索列表
 */
-(void)SendHotSongSearchWithCategoryId:(NSString *)CategoryId Rank:(NSString *)Rank Account:(NSString *)Account PageNo:(NSInteger)PageNo KeyWord:(NSString *)KeyWord Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GethotsongSearch_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"categoryId":CategoryId,
                             @"rank":Rank,
                             @"account":Account,
                             @"pageNo":[NSNumber numberWithInteger: PageNo],
                             @"keyWord":KeyWord
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.25 根据ID获取热门单曲
 @param MusicID 热门单曲ID
 */
-(void)SendHotsongInfoMusicID:(NSString *)MusicID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetHotsongInfo_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":MusicID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.26 专辑列表
 @param PageNo 页码
 @param Account 用户账户
 */
-(void)SendAlbumListPageNo:(NSInteger)PageNo Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetAlbumList_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"pageNo":[NSNumber numberWithInteger:PageNo],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.27 专辑信息
 @param Music 专辑ID
 */
-(void)SendAlbumInfoMusicID:(NSString *)Music Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetAlbumInfo_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":Music
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.28 获取购物车数量
 @param Account 会员账户
 */
-(void)SendCartQuantityAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetCartQuantity_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.29 购物车列表
 @param Account 会员帐户
 */
-(void)SendCartListAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetCartList_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
        //更新购物车数量
        [BaseMethod CartVCUpDateCartNumber];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.30 添加购物车
 @param Account 会员帐户
 @param GoodsID 热门单曲/专辑
 @param Type 类别 0:热门单曲 1:专辑
 */
-(void)SendCartDoAddAccount:(NSString *)Account GoodsID:(NSString *)GoodsID Type:(NSInteger)Type Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetCartDoAdd_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"goodsId":GoodsID,
                             @"type":[NSNumber numberWithInteger: Type]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
        //更新购物车数量
        [BaseMethod CartVCUpDateCartNumber];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.31 删除购物车某项
 @param Account 会员帐户
 @param itemID 购物车明细ID
 */
-(void)SendCartDoDeleteAccount:(NSString *)Account itemID:(NSString *)itemID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetCartDoDelete_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"itemId":itemID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
        //更新购物车数量
        [BaseMethod CartVCUpDateCartNumber];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.32 批量删除购物车
 @param Account 会员帐户
 @param IDS Id数组，-隔开
 */
-(void)SendCartDoBatchDeleteAccount:(NSString *)Account IDS:(NSString *)IDS Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetCartDoBatchDelete_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"ids":IDS
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
        //更新购物车数量
        [BaseMethod CartVCUpDateCartNumber];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.33 清空购物车
 */
-(void)SendCartDoClearAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetCartDoClear_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
        //更新购物车数量
        [BaseMethod CartVCUpDateCartNumber];
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.34 检出订单
 @param Account 会员帐户
 */
-(void)SendOrderCheckoutAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrderCheckout_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.35 创建订单
 @param Account 会员帐户
 */
-(void)SendOrderCreateAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrderCreate_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.36 查看订单
 @param Account 会员帐户
 @param SN 单号
 */
-(void)SendOrderViewAccount:(NSString *)Account SN:(NSString *)SN Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrderView_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"sn":SN
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.37 修改会员资料
 
 @param Account 会员帐户
 @param Sex 性别 0:位置 1:男 2：女
 @param Icon 头像url
 @param UserName 用户名
 */
-(void)SendMemberDoEitAccount:(NSString *)Account Sex:(NSInteger)Sex Icon:(NSString *)Icon UserName:(NSString *)UserName  Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetMemberDoEdit_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"sex":[NSNumber numberWithInteger: Sex],
                             @"icon":Icon?Icon:@"",
                             @"username":UserName
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.38 入门知识大纲列表
 @param PageNo 页面
 */
-(void)SendKnowledgeSchemaListPageNo:(NSInteger)PageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetKnowledgeSchemaList_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"pageNo":[NSNumber numberWithInteger:PageNo],
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.39 大纲知识点列表
 @param SchemaID 刚要ID
 */
-(void)SendKnowledgeSchemaInfoWithSchemaID:(NSString *)SchemaID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetKnowSchemaInfo_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"schemaId":SchemaID
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.40 知识点详情
 @param KnowledgeId 知识点ID
 */
-(void)SendKnowledgeDetailWithKnowledgeId:(NSString *)KnowledgeId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetKonwledgeDetail_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"knowledgeId":KnowledgeId
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.41 悠点付款
 @param SN 订单号
 @param Account 会员张账号
 */
-(void)SendPaymentUshowPayWithSN:(NSString *)SN Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPaymentUShowPay_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"sn":SN,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.42 记录播放记录
 @param MusicId 乐曲ID
 @param Account 会员账号
 */
-(void)SendPlayrecordPlayWithMusicId:(NSString *)MusicId Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPlayrecordPlay_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"musicId":MusicId,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.43 播放记录列表
 @param PageNo 页码
 @param Account 会员账号
 */
-(void)SendPlayRecordListWithPageNo:(NSInteger)PageNo Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPlayRecordList_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"pageNo":[NSNumber numberWithInteger:PageNo],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.44 批量删除 播放记录
 @param IDS 播放记录ID集合
 @param Account 会员账号
 */
-(void)SendPlayrecordDoHatchDeleteWithIDS:(NSString *)IDS Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPlayRecordDoBatchDelete_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"ids":IDS,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.45 文件管理列表
 @param Type 类型0:热门单曲  1:专辑
 @param Account 会员账号
 @param PageNo 页码
 */
-(void)SendClientfileType:(NSInteger)Type Account:(NSString *)Account PageNo:(NSInteger)PageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetClientFileList_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"type":[NSNumber numberWithInteger:Type],
                             @"account":Account,
                             @"pageNo":[NSNumber numberWithInteger: PageNo]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.46 文件歌曲详情
 @param FileID 客户端文件ID
 @param Account 会员账号
 */
-(void)SendClientfileViewWithFileID:(NSString *)FileID Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetClientfileView_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":FileID,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.47 文件歌曲删除
 @param FileID 客户端文件ID
 @param Account 会员账号
 */
-(void)SendClientfileDoDeleteWithID:(NSString *)FileID Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetClientfiledoDelete_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":FileID,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.46 文件恢复下载
 @param FileID 客户端文件ID
 @param Account 会员账号
 */
-(void)SendClientFileDownLoadWithID:(NSString *)FileID Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetClientDownLoad_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"id":FileID,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.48 充值记录列表
 @param PageNo 页码
 @param Account 会员账号
 */
-(void)SendRechargerecordListWithPageNo:(NSInteger)PageNo Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetRechargerecordList_URLL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"pageNo":[NSNumber numberWithInteger: PageNo],
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.49 微信App支付 订单
 @param SN 订单号
 @param Account 会员账号
 */
-(void)SendPaymentWXAppPayWithSN:(NSString *)SN Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPaymentWXAppPay_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"sn":SN,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.50 支付宝App支付 订单
 @param SN 订单号
 @param Account 会员账号
 */
-(void)SendPaymentAliAppPayWithSN:(NSString *)SN Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPaymentAliAppPay_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"sn":SN,
                             @"account":Account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.51 微信App支付 充值
 @param RechargeAmount 充值金额
 @param Account 会员账号
 @param uAmount 悠点值
 */
-(void)SendPaymentWXAppRechargeWithRechargeAmount:(NSString *)RechargeAmount Account:(NSString *)Account uAmount:(NSString *)uAmount Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPaymentWXAppRecharge_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"rechargeAmount":RechargeAmount,
                             @"account":Account,
                             @"uAmount":uAmount
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.52 支付宝 APP支付 充值
 @param rechargeAmount 充值金额
 @param Account 会员账号
 @param uAmount 悠点值
 */
-(void)SendPaymentAliAppPayWithRechargeAmount:(NSString *)rechargeAmount Account:(NSString *)Account uAmount:(NSString *)uAmount Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetPaymentAliAppPayRecharge_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"rechargeAmount":rechargeAmount,
                             @"account":Account,
                             @"uAmount":uAmount
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.53 歌曲或专辑直接生成订单
 
 @param account 会员帐户
 @param songId 热门单曲/专辑
 @param type 类型
 @param success
 @param failure
 */
-(void)SendOrderQuickBuyWithAccount:(NSString *)account songId:(NSString *)songId type:(NSString *)type Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrderQuickBuy_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":account,
                             @"songId":songId,
                             @"type":type
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.54 订单列表
 
 @param account 会员帐户
 @param status 状态 0 已提交、1 待付款（状态废弃）、2 已付款、3 已取消
 @param pageNo 页码
 @param success
 @param failure
 */
-(void)SendOrderListWithAccount:(NSString *)account status:(NSString *)status pageNo:(NSInteger)pageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrdeList_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":account,
                             @"status":status,
                             @"pageNo":[NSNumber numberWithInteger:pageNo]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.55 订单已购买歌曲列表
 
 @param account 会员帐户
 @param pageNo 页码
 @param success
 @param failure 
 */
-(void)SendOrderListWithAccount:(NSString *)account pageNo:(NSInteger)pageNo Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetOrderSongList_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account,
                             @"pageNo":[NSNumber numberWithInteger:pageNo]
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 3.56 清空播放记录
 @param account 会员帐户
 */
-(void)SendPlayrecordRemoveAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetPlayrecordRemove_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.57 提交反馈信息
 
 @param account 会员帐户
 @param imagesUrlString 图片URL，多张图片，逗号隔开
 @param content 反馈内容
 */
-(void)SendMessagePublishAccount:(NSString *)account images:(NSString *)imagesUrlString content:(NSString *)content Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetMessagePublish_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account,
                             @"images":imagesUrlString,
                             @"content":content
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.58 消息通知条数
 
 @param account 会员帐户
 */
-(void)SendMessageNoticeAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetMessageNotice_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.59 阅读消息通知
 
 @param account 会员帐户
 */
-(void)SendMessageReadAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetMessageRead_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.60 反馈列表
 
 @param account 会员帐户
 */
-(void)SendMessageListAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetMessageList_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.61根据单号获取下载目录
 @param account 会员账户
 @param sn 订单号
 */
-(void)SendOrderGetDownLoad:(NSString *)account sn:(NSString *)sn Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetOrderGetDownLoad_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"account":account,
                             @"sn":sn
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.64发送登录验证码
 @param mobile 手机号
 */
-(void)SendLoginSendLoginValidate:(NSString *)mobile Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetLoginSendLoginValidate_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"mobile":mobile,
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.65手机+验证码登录
 @param mobile 手机号
 @param validate 验证码
 */
-(void)SendLoginLoginByValidate:(NSString *)mobile validate:(NSString *)validate Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure{
    NSString *url = [RequestURLDefine GetLoginLoginByValidate_URL];
    NSDictionary *params = @{
                             @"keyid":[BaseMethod getEncryAes128KeyID],
                             @"mobile":mobile,
                             @"validate":validate
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        PeopleInfoModel *model = [[PeopleInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        if(model.success){
            //保存用户登录信息和状态
            [BaseMethod SetUserInfo:result];
            [BaseMethod SetUserLogin:YES];
        }
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.68根据订单号查看客户端文件

 @param Account 用户账号
 @param SN 订单号
 */
-(void)SendOrderGetOrderFileViewAccount:(NSString *)Account SN:(NSString *)SN Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrderGetOrderFile_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"sn":SN
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
/**
 3.69 订单作废接口

 @param Account 用户账号
 @param SN 订单号
 */
- (void)SendOrderAbolishAccount:(NSString *)Account SN:(NSString *)SN Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure{
    NSString *url = [RequestURLDefine GetOrderAbolish_URL];
    NSDictionary *params = @{
                             @"keyId":[BaseMethod getEncryAes128KeyID],
                             @"account":Account,
                             @"sn":SN
                             };
    [self RequestWithGet:url parameters:params success:^(id result) {
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:result];
        success(model);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark private
-(void)CheckUserisLogin{
    PeopleInfoModel *peopleinfo = [BaseMethod getUserInfo];
    PeopleInfoDataModel *modelinfo = (PeopleInfoDataModel *)peopleinfo.data;
    if(modelinfo == nil){
       [BaseMethod showToastOnWindowWithString:@"请先登录" hideAfterSecond:Macro_ShowLoadingDefaultTime];
        return;
    }
}
@end
