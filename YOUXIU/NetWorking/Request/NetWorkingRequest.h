//
//  NetWorkingRequest.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "BaseRequest.h"
//#import "findCarBrandAllModel.h"
//#import "CarSeriesModel.h"
//#import "CarModelModel.h"
//#import "findCategoryAllModel.h"
//#import "findAreaRootModel.h"
#import "PeopleInfoModel.h"
//#import "ReceiverListModel.h"
//#import "ProductSearchModel.h"
//#import "GoodsDetailModel.h"
//#import "CollectionGoodsModel.h"
//#import "BannerModel.h"
//#import "VinQueryModel.h"
//#import "OrderListModel.h"
//#import "OrderCheckoutModel.h"
//#import "OrderCreateModel.h"
//#import "TopicListModel.h"
//#import "TopicDetailModel.h"
//#import "CommentModel.h"
//#import "CommentDetailModel.h"
//#import "DiscussReplayModel.h"
@interface NetWorkingRequest : BaseRequest

///**
// 获取全部车品牌
//
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarBrandAll_Request_Success:(void(^)(findCarBrandAllModel *info))success failure:(void(^)(NSError *error))failure;
///**
// //根据字母获取车品牌
//
// @param CarID 字母： 116
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarBrandWithCarID_Request:(NSString *)CarID Success:(void(^)(findCarBrandAllModel *info))success failure:(void(^)(NSError *error))failure;
///**
// //根据字母获取车品牌
//
// @param fast 字母： D
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarBrandByFast_Request:(NSString *)fast Success:(void(^)(findCarBrandAllModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 根据品牌查找车系
//
// @param brandId 车牌 brandId=3
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarSeriesByBrand_Request:(NSString *)brandId Success:(void(^)(CarSeriesModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 获取全部车系
//
// @param success 返回车辆信息
// @param failure 失败
//
// */
//-(void)FindCarSeriesAll_RequestSuccess:(void(^)(CarSeriesModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 查找单个车系
//
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarSeries_Request:(NSString *)carid Success:(void(^)(CarSeriesModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 根据车系查找车型
//
// @param seriesId 车系id seriesId=3
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarModelBySeries_Request:(NSString *)seriesId Success:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 根据车品牌获取车型
//
// @param brandId 车品牌 brandId=3
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarModelByBrand_Request:(NSString *)brandId Success:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 获取全部车型
//
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarModelAll_RequestSuccess:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure;
//
//
///**
// 查找单个车型
//
// @param carid carid
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCarModel_Request:(NSString *)carid Success:(void(^)(CarModelModel *info))success failure:(void(^)(NSError *error))failure;
//
//
///**
// 查询所有分类列表
//
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCategoryAll_RequestSuccess:(void(^)(findCategoryAllModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
//查找单个栏目分类
//
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCategory_Request:(NSString *)thisid Success:(void(^)(findCategoryAllModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.13查找类别的子类别
//
// @param success 返回车辆信息
// @param failure 失败
// */
//-(void)FindCategoryChildren_Request:(NSString *)thisid Success:(void(^)(findCategoryAllModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 查询根地区
//
// @param success 成功
// @param failure 失败
// */
//-(void)FindAreaRoot_RequestSuccess:(void(^)(findAreaRootModel *info))success failure:(void(^)(NSError *error))failure;
//
//
///**
// 查询全部根地区
//
// @param success 成功
// @param failure 失败
// */
//-(void)FindAreaRoots_RequestSuccess:(void(^)(findAreaRootModel *info))success failure:(void(^)(NSError *error))failure;
//
//
///**
// 查询节点的子节点(地区)
//
// @param areaId 地区id
// @param success 成功
// @param failure 失败
// */
//-(void)FindChildren_RequestareaId:(NSString *)areaId Success:(void(^)(findAreaRootModel *info))success failure:(void(^)(NSError *error))failure;
//



//

//
///**
// 用户登出
//
// @param mobile 1
// @param success 1
// @param failure 1
// */
//-(void)SendUserLogin_loginout_Request:(NSString *)mobile Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//

//
///**
// 3.28修改资料
//
// @param nickname 昵称
// @param name 姓名
// @param icon 调用图片上传接口获取图片地址，传地址即可
// @param success 1
// @param failure 1
// */
//-(void)SentDoEdit_RequestNickName:(NSString *)nickname icon:(NSString *)icon gender:(NSString *)gender Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;


///**
// 3.30收货地址列表
//
// @param success 1
// @param failure 1
// */
//-(void)SendGetReceiverList_RequestSuccess:(void(^)(ReceiverListModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 添加收货地址
//
// @param consignee 收货人
// @param address 地址
// @param phone 电话
// @param isDefault 是否默认 是否默认 （1或0）
// */
//-(void)SendReceiverDoAdd_Request:(NSString *)consignee address:(NSString *)address phone:(NSString *)phone isDefault:(NSString *)isDefault provinceId:(NSString *)provinceId cityId:(NSString *)cityId districtId:(NSString *)districtId success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.32修改收货地址
//
// @param consignee 收货人
// @param address 地址
// @param phone 电话
// @param isDefault 是否默认 是否默认 （1或0）
// @param areaId 区域ID
// */
//-(void)SendReceiverDoEdit_Request:(NSString *)consignee peopleID:(NSString *)peopleID address:(NSString *)address phone:(NSString *)phone isDefault:(NSString *)isDefault provinceId:(NSString *)provinceId cityId:(NSString *)cityId districtId:(NSString *)districtId success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 3.33查询收货人信息
//
// @param success 1
// @param failure 1
// */
//-(void)SendGetReceiverFind_RequestPeopleId:(NSString *)PeopleId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.34设置默认收货地址
//
// @param peopleID 收货人id，每个地址对应一个收货人id
// @param success 1
// @param failure 1
// */
//-(void)SendReceiverDoDefault:(NSString *)peopleID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//
//
///**
// 3.29商家资料增加 或修改
//
// @param provinceId 省份ID
// @param cityId 城市ID
// @param districId 区县ID
// @param address 地址
// @param bizNo 营业执照号
// @param shopName 店家名称
// @param shopImageName 店招图片的地址
// @param success 1
// @param failure 1
// */
//-(void)SendMemberDoShopInfoWithProvinceId:(NSString *)provinceId cityId:(NSString *)cityId districtId:(NSString *)districId address:(NSString *)address bizNo:(NSString *)bizNo shopName:(NSString *)shopName shpImageName:(NSString *)shopImageName Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 3.34搜索 汽车品牌，车型，车系
//
// @param keyword 搜索字 非必填
// 只支持
// series: 车系搜索
// model：车型搜索
// @param parendId 父类ID
// @param type 搜索
// brand :车品牌搜索
// series:车系搜索
// model：车型搜索
// category：类别搜索
// @param success 1
// @param failure 1
// */
//-(void)SendCarSearchKeyWord:(NSString *)keyword parendId:(NSString *)parendId type:(NSString *)type Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 3.35搜索商品
//
// @param keyword 搜索字
// @param brandID 品牌ID
// @param seriesId 车系ID
// @param modelId 车型ID
// @param categoryId 列表ID
// @param pageNo 当前页码
// @param pageSize 页码内容大小
// @param order 排序字段
// @param sort 排序顺序
// @param success 1
// @param failure 1
// */
//-(void)SendProductSearchKeyword:(NSString *)keyword brandID:(NSString *)brandID seriesID:(NSString *)seriesId modelId:(NSString *)modelId categoryId:(NSString *)categoryId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize order:(NSString *)order sort:(NSString *)sort Success:(void(^)(ProductSearchModel *info))success failure:(void(^)(NSError *error))failure;
//
///**
// 3.35商品列表
//
// @param brandID 品牌ID
// @param seriesId 车系ID
// @param modelId 车型ID
// @param categoryId 列表ID
// @param pageNo 当前页码
// @param pageSize 页码内容大小
// @param order 排序字段
// 不填 无排序
// 只能填：
// price：价格
// sales  总销量
// @param sort 排序顺序
// 不填 无排序
// 只能填
// asc 升徐
// desc  降序
// @param success 1
// @param failure 1
// */
//-(void)SendProductListbrandID:(NSString *)brandID seriesID:(NSString *)seriesId modelId:(NSString *)modelId categoryId:(NSString *)categoryId pageNo:(NSString *)pageNo pageSize:(NSString *)pageSize order:(NSString *)order sort:(NSString *)sort Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.36商品详情
//
// @param success 1
// @param failure 1
// */
//-(void)SendProductInfoID:(NSString *)goodID Success:(void(^)(GoodsDetailModel  *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartQuantitySuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartDoAddProductId:(NSString *)productId quanitity:(NSString *)quantity Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartDoEditId:(NSString *)CartitemId quanitity:(NSString *)quantity Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartDoDeleteId:(NSString *)CartitemId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartListSuccess:(void(^)(CollectionGoodsModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartDoClearSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendFavoriteAddproductId:(NSString *)productId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendFavoriteCancelproductId:(NSString *)productId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(id)SendSynFavoriteCancelproductId:(NSString *)productId;
//-(void)SendfavoriteListSuccess:(void(^)(ProductSearchModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderCheckoutSuccess:(void(^)(OrderCheckoutModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderCalculateReceiverId:(NSString *)receiverid shippingMethodid:(NSString *)shippingMethodId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderCreateReceiverId:(NSString *)receiverid shippingMethodid:(NSString *)shippingMethodId cartToken:(NSString *)cartToken memo:(NSString *)memo Success:(void(^)(OrderCreateModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderViewSn:(NSString *)sn Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderCancelSn:(NSString *)sn Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderReceiveSn:(NSString *)sn Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendOrderListType:(NSString *)type Success:(void(^)(OrderListModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCartDoBatchDelete:(NSArray *)ids Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCommonFindHotSearchSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendCommonFindBannersSuccess:(void(^)(BannerModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendProductGoodsTopSuccess:(void(^)(GoodsDetailModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendVinQuery:(NSString *)VinCode Success:(void(^)(VinQueryModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendVinQueryParts:(NSString *)VinCode pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize order:(NSString *)order sort:(NSString *)sort Success:(void(^)(ProductSearchModel *info))success failure:(void(^)(NSError *error))failure;
////社区论坛
///**
// 发布话题
//
// @param Type talent 人才交流, problem 问题讨论
// @param Kind recruit 招聘 , technology 技术, abnormal 异常, repair 维修, other 其他
// @param Title title
// @param Content content
// @param images 请求格式：图片url数组json字符串。图片URL参考上传图片
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_PublishRequestWithType:(NSString *)Type Kind:(NSString *)Kind Title:(NSString *)Title Content:(NSString *)Content images:(NSArray *)images Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.62编辑话题
//
// @param thisid 话题ID
// @param title 1
// @param content 1
// @param images 1
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_EditRequestWithID:(NSString *)thisid title:(NSString *)title content:(NSString *)content images:(NSArray *)images Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 删除话题
//
// @param Thisid 话题ID
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_CancelRequestWithID:(NSString *)Thisid Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.64话题点赞
//
// @param ThisID 话题ID
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_GiveThumbRequestWithID:(NSString *)ThisID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.65取消话题点赞
//
// @param Thisid 话题ID
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_CancelThumbRequestWithID:(NSString *)Thisid Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.66话题列表
//
// @param pageSize 页码内容大小 默认10
// @param pageNo 当前页码
// @param type 话题类型 talent 人才交流, problem 问题讨论
// @param kind 种类 recruit 招聘 , technology 技术, abnormal 异常, repair 维修,other 其他
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_ListRequestWithPageSize:(NSString *)pageSize pageNo:(NSString *)pageNo type:(NSString *)type kind:(NSString *)kind Success:(void(^)(TopicListModel *info))success failure:(void(^)(NSError *error))failure;;
///**
// 3.67话题详情
//
// @param Thisid 话题ID
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_InfoRequestWithID:(NSString *)Thisid Success:(void(^)(TopicDetailModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.68我的帖子
//
// @param pageNo 1
// @param pageSize 1
// @param type 1
// @param kind 1
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_myTopicsRequestWithpageNo:(NSString *)pageNo pageSize:(NSString *)pageSize type:(NSString *)type kind:(NSString *)kind Success:(void(^)(TopicListModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.69我点赞的帖子
//
// @param pageNo 1
// @param pageSize 1
// @param type 1
// @param kind 1
// @param success 1
// @param failure 1
// */
//-(void)SendTopic_myThumbTopicsRequestWithpageNo:(NSString *)pageNo pageSize:(NSString *)pageSize type:(NSString *)type kind:(NSString *)kind Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 3.70发表评论
//
// @param topicId 话题ID
// @param content 内容
// @param success 1
// @param failure 1
// */
//-(void)SendComment_PublishRequestWithTopicId:(NSString *)topicId content:(NSString *)content Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_ReplyRequestWithTopicId:(NSString *)topicId commentId:(NSString *)commentId content:(NSString *)content Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_EditRequestWithID:(NSString *)thisId content:(NSString *)content Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_CancelRequestWithID:(NSString *)thisId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_GiveThumpRequestWithID:(NSString *)thisId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_CancelThumpRequestWithID:(NSString *)thisId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_myCommentsRequestWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize Success:(void(^)(CommentModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_myThumbCommentsRequestWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
//-(void)SendComment_TopicCommentsWithPageNo:(NSString *)pageNo pageSize:(NSString *)pageSize TopicId:(NSString *)topId Success:(void(^)(CommentModel *info))success failure:(void(^)(NSError *error))failure;
////3.79 commentid 评论id
//-(void)SendComment_InfoWithCommentId:(NSString *)commentid Success:(void(^)(CommentDetailModel *info))success failure:(void(^)(NSError *error))failure;
////3.80
//-(void)SendComment_getReplysWithCommentId:(NSString *)commentid Success:(void(^)(DiscussReplayModel *info))success failure:(void(^)(NSError *error))failure;

//-(void)SendReceiverDoRemoveReceiverPeopleID:(NSString *)peopleID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
#pragma mark 优秀钢琴
//3.12 查询所有级别
//查询所有级别
-(void)RequestCommonLookMobile:(NSString *)mobile Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;//
///**
// 申请注册发送验证码／注册
//
// @param mobile 手机号
// @param step 1获取验证码，2，注册，1时不用传password,validate
// */
-(void)SendMobileCaptcha_doRegister_Request:(NSString *)mobile step:(NSString *)step password:(NSString *)password validate:(NSString *)validate Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 申请忘记发送验证码/提交忘记密码
 
 @param mobile 手机号
 @param step 步骤，1，2
 @param success 1
 @param failure 1
 */
-(void)SendMobileCaptcha_doForgetPwd_Request:(NSString *)mobile step:(NSString *)step password:(NSString *)password validate:(NSString *)validate Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
///**
// 登录验证
//
// @param mobile 1
// @param password 1
// @param success 1
// @param failure 1
// */
-(void)SendUserLogin_login_Request:(NSString *)mobile password:(NSString *)password Success:(void(^)(PeopleInfoModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.26根据会员手机号查询会员资料
 
 @param success 1
 @param failure 1
 */
-(void)SendFindByOauth_RequestSuccess:(void(^)(PeopleInfoModel *peopleinfo))success failure:(void(^)(NSError *error))failure;
/**
 3.5 退出登录
 @param mobile 手机号
 */
-(void)SendLogoutMobile:(NSString *)mobile Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
////修改密码
-(void)SendMemberDoEditPwd:(NSString *)CurrentPassWord password:(NSString *)password Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 上传图片

 @param image 1
 @param success 1
 @param failure 1
 */
-(void)SentuploadImage_Request:(UIImage *)image imageName:(NSString *)ImageName Progress:(void (^)(NSProgress *progress))Progress Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 查询所有级别
 */
-(void)SendRankFindAllSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 根据ID查询级别
 @param ID 级别ID
 */
-(void)SendRankFindID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.14 查询所有类别
 */
-(void)SendStyleCategoryFindAllSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.15 根据ID查询类别
 @param ID 类别ID
 */
-(void)SendStylecategoryFindWithID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.16 根据ID查询乐曲信息
 @param ID 乐曲ID
 */
-(void)SendMusicInfoWithMusicID:(NSString *)ID type:(NSString *)type Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.17 获取五线谱图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetWxpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.18 获取简五谱 图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetJwpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.19 获取固定谱 图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetGdpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.20 获取首调谱 图谱
 @param ID 乐曲ID
 */
-(void)SendMusicGetSdpWithMusicID:(NSString *)ID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.21 获取搜索关键字
 */
-(void)SendHotsongGetSearchWordSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.22 获取标签墙
 */
-(void)RequestWallTagSuccess:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure; //获取标签墙
/**
 3.23 热门单曲列表
 */
-(void)RequestHotsongListWithCategorId:(NSString *)categoryId rank:(NSString *)rank Account:(NSString *)Account PageNo:(NSInteger)PageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.24 热门单曲关键字搜索列表
 */
-(void)SendHotSongSearchWithCategoryId:(NSString *)CategoryId Rank:(NSString *)Rank Account:(NSString *)Account PageNo:(NSInteger)PageNo KeyWord:(NSString *)KeyWord Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.25 根据ID获取热门单曲
 @param MusicID 热门单曲ID
 */
-(void)SendHotsongInfoMusicID:(NSString *)MusicID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.26 专辑列表
 @param PageNo 页码
 @param Account 用户账户
 */
-(void)SendAlbumListPageNo:(NSInteger)PageNo Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.27 专辑信息
 @param Music 专辑ID
 */
-(void)SendAlbumInfoMusicID:(NSString *)Music Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.28 获取购物车数量
 @param Account 会员账户
 */
-(void)SendCartQuantityAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.29 购物车列表
 @param Account 会员帐户
 */
-(void)SendCartListAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.30 添加购物车
 @param Account 会员帐户
 @param GoodsID 热门单曲/专辑
 @param Type 类别 0:热门单曲 1:专辑
 */
-(void)SendCartDoAddAccount:(NSString *)Account GoodsID:(NSString *)GoodsID Type:(NSInteger)Type Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.31 删除购物车某项
 @param Account 会员帐户
 @param itemID 购物车明细ID
 */
-(void)SendCartDoDeleteAccount:(NSString *)Account itemID:(NSString *)itemID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.32 批量删除购物车
 @param Account 会员帐户
 @param IDS Id数组，-隔开
 */
-(void)SendCartDoBatchDeleteAccount:(NSString *)Account IDS:(NSString *)IDS Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.33 清空购物车
 */
-(void)SendCartDoClearAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.34 检出订单
 @param Account 会员帐户
 */
-(void)SendOrderCheckoutAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.35 创建订单
 @param Account 会员帐户
 */
-(void)SendOrderCreateAccount:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.36 查看订单
 @param Account 会员帐户
 @param SN 单号
 */
-(void)SendOrderViewAccount:(NSString *)Account SN:(NSString *)SN Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.37 修改会员资料

 @param Account 会员帐户
 @param Sex 性别 0:位置 1:男 2：女
 @param Icon 头像url
 @param UserName 用户名
 */
-(void)SendMemberDoEitAccount:(NSString *)Account Sex:(NSInteger)Sex Icon:(NSString *)Icon UserName:(NSString *)UserName  Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.38 入门知识大纲列表
 @param PageNo 页面
 */
-(void)SendKnowledgeSchemaListPageNo:(NSInteger)PageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.39 大纲知识点列表
 @param SchemaID 刚要ID
 */
-(void)SendKnowledgeSchemaInfoWithSchemaID:(NSString *)SchemaID Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.40 知识点详情
 @param KnowledgeId 知识点ID
 */
-(void)SendKnowledgeDetailWithKnowledgeId:(NSString *)KnowledgeId Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.41 悠点付款
 @param SN 订单号
 @param Account 会员张账号
 */
-(void)SendPaymentUshowPayWithSN:(NSString *)SN Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.42 记录播放记录
 @param MusicId 乐曲ID
 @param Account 会员账号
 */
-(void)SendPlayrecordPlayWithMusicId:(NSString *)MusicId Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.43 播放记录列表
 @param PageNo 页码
 @param Account 会员账号
 */
-(void)SendPlayRecordListWithPageNo:(NSInteger)PageNo Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.44 批量删除 播放记录
 @param IDS 播放记录ID集合
 @param Account 会员账号
 */
-(void)SendPlayrecordDoHatchDeleteWithIDS:(NSString *)IDS Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.45 文件管理列表
 @param Type 类型0:热门单曲  1:专辑
 @param Account 会员账号
 @param PageNo 页码
 */
-(void)SendClientfileType:(NSInteger)Type Account:(NSString *)Account PageNo:(NSInteger)PageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.46 文件歌曲详情
 @param FileID 客户端文件ID
 @param Account 会员账号
 */
-(void)SendClientfileViewWithFileID:(NSString *)FileID Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.47 文件歌曲删除
 @param FileID 客户端文件ID
 @param Account 会员账号
 */
-(void)SendClientfileDoDeleteWithID:(NSString *)FileID Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.46 文件恢复下载
 @param FileID 客户端文件ID
 @param Account 会员账号
 */
-(void)SendClientFileDownLoadWithID:(NSString *)FileID Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.48 充值记录列表
 @param PageNo 页码
 @param Account 会员账号
 */
-(void)SendRechargerecordListWithPageNo:(NSInteger)PageNo Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.49 微信App支付 订单
 @param SN 订单号
 @param Account 会员账号
 */
-(void)SendPaymentWXAppPayWithSN:(NSString *)SN Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.50 支付宝App支付 订单
 @param SN 订单号
 @param Account 会员账号
 */
-(void)SendPaymentAliAppPayWithSN:(NSString *)SN Account:(NSString *)Account Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.51 微信App支付 充值
 @param RechargeAmount 充值金额
 @param Account 会员账号
 @param uAmount 悠点值
 */
-(void)SendPaymentWXAppRechargeWithRechargeAmount:(NSString *)RechargeAmount Account:(NSString *)Account uAmount:(NSString *)uAmount Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.52 支付宝 APP支付 充值
 @param rechargeAmount 充值金额
 @param Account 会员账号
 @param uAmount 悠点值
 */
-(void)SendPaymentAliAppPayWithRechargeAmount:(NSString *)rechargeAmount Account:(NSString *)Account uAmount:(NSString *)uAmount Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.53 歌曲或专辑直接生成订单

 @param account 会员帐户
 @param songId 热门单曲/专辑
 @param type 类型
 @param success
 @param failure 
 */
-(void)SendOrderQuickBuyWithAccount:(NSString *)account songId:(NSString *)songId type:(NSString *)type Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.54 订单列表

 @param account 会员帐户
 @param status 状态 0 已提交、1 待付款（状态废弃）、2 已付款、3 已取消
 @param pageNo 页码
 @param success
 @param failure
 */
-(void)SendOrderListWithAccount:(NSString *)account status:(NSString *)status pageNo:(NSInteger)pageNo Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.55 订单已购买歌曲列表

 @param account 会员帐户
 @param pageNo 页码
 */
-(void)SendOrderListWithAccount:(NSString *)account pageNo:(NSInteger)pageNo Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.56 清空播放记录
 @param account 会员帐户
 */
-(void)SendPlayrecordRemoveAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.57 提交反馈信息

 @param account 会员帐户
 @param imagesUrlString 图片URL，多张图片，逗号隔开
 @param content 反馈内容
 */
-(void)SendMessagePublishAccount:(NSString *)account images:(NSString *)imagesUrlString content:(NSString *)content Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.58 消息通知条数

 @param account 会员帐户
 */
-(void)SendMessageNoticeAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.59 阅读消息通知

 @param account 会员帐户
 */
-(void)SendMessageReadAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.60 反馈列表
 @param account 会员帐户
 */
-(void)SendMessageListAccount:(NSString *)account Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.61根据单号获取下载目录
 @param account 会员账户
 @param sn 订单号
 */
-(void)SendOrderGetDownLoad:(NSString *)account sn:(NSString *)sn Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.64发送登录验证码
 @param mobile 手机号
 */
-(void)SendLoginSendLoginValidate:(NSString *)mobile Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.65手机+验证码登录
 @param mobile 手机号
 @param validate 验证码
 */
-(void)SendLoginLoginByValidate:(NSString *)mobile validate:(NSString *)validate Success:(void (^)(BaseModel *))success failure:(void (^)(NSError *))failure;
/**
 3.68根据订单号查看客户端文件
 @param Account 用户账号
 @param SN 订单号
 */
-(void)SendOrderGetOrderFileViewAccount:(NSString *)Account SN:(NSString *)SN Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
/**
 3.69 订单作废接口
 
 @param Account 用户账号
 @param SN 订单号
 */
- (void)SendOrderAbolishAccount:(NSString *)Account SN:(NSString *)SN Success:(void(^)(BaseModel *info))success failure:(void(^)(NSError *error))failure;
@end
