//
//  RequestURLDefine.m
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import "RequestURLDefine.h"
//#define URL_Prefix @"http://101.132.107.77:8080/yxshop/api/"
#define URL_Prefix @"http://app.ushowpiano.com/yxshop/api/"


//获取全部车品牌
 #define FindCarBrandAll @"car/findCarBrandAll.jhtml"//keyid=362831589e5d170fc6323d59db034bf5
//根据ID查询车品牌
 #define FindCarBrand @"car/findCarBrand.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&id=3
//根据字母获取车品牌
  #define FindCarBrandByFast @"car/findCarBrandByFast.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&fast=D
//根据品牌查找车系
#define FindCarSeriesByBrand @"car/findCarSeriesByBrand.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&brandId=3
//获取全部车系
 #define FindCarSeriesAll @"car/findCarSeriesAll.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5
//查找单个车系
#define FindCarSeries @"car/findCarSeries.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&id=2
//根据车系查找车型
 #define FindCarModelBySeries @"car/findCarModelBySeries.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&seriesId=3
//根据车品牌获取车型
 #define FindCarModelByBrand @"car/findCarModelByBrand.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&brandId=3
//获取全部车型
 #define FindCarModelAll @"car/findCarModelAll.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5
//查找单个车型
#define FindCarModel @"car/findCarModel.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&id=2
//查询所有分类列表
#define FindCAtegoryAll @"car/findCategoryAll.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5
//查找单个栏目分类
#define FindCategory @"car/findCategory.jhtml"//?keyid=362831589e5d170fc6323d59db034bf5&id=1
#define FindCategoryChildren @"car/findCategoryChildren.jhtml"
//查询根地区
#define FindAreaRoot @"common/findAreaRoot.jhtml"
//查询全部根地区
#define FindAreaRoots @"common/findAreaRoots.jhtml"
//查询节点的子节点(地区)
#define FindChildren @"common/findChildren.jhtml"//?areaId=1
#define FindHotSearchs @"common/findHotSearchs.jhtml" //keyid=xxxxxxx
#define FindBanners @"common/findBanners.jhtml"//
//查看短信验证码
#define Look @"common/look.jhtml"//?mobile=18379174290

//申请注册发送验证码 //?mobile=18379174290&keyid=362831589e5d170fc6323d59db034bf5&step=1
//提交注册会员 mobile=18379174290&password=123456&validate=321234&keyid=362831589e5d170fc6323d59db034bf5&step=2




//退出登录
#define Logout @"login/logout.jhtml"//?mobile=18379174290&keyid=362831589e5d170fc6323d59db034bf5


//图片上传接口   (未测试) 文件参数名：image



//3.30收货地址列表 moauth 安全码，keyid
#define Receiver_list @"receiver/list.jhtml"
#define Receiver_DoAdd @"receiver/doAdd.jhtml"
#define Receiver_DoEdit @"receiver/doEdit.jhtml"
#define Receiver_Find @"receiver/find.jhtml"
#define Receiver_DoDefault @"receiver/doDefault.jhtml"
#define Receiver_doRemove @"receiver/doRemove.jhtml"

//商家
#define Member_DoShopInfo @"member/doShopInfo.jhtml"
#define Car_Search @"car/search.jhtml"
#define Product_Search @"product/search.jhtml"
#define Product_List @"product/list.jhtml"
#define Product_Info @"product/info.jhtml"
#define Prodect_GoodsTop @"product/goodsTop.jhtml"
#define Cart_Quantity @"cart/quantity.jhtml"
#define Cart_DoAdd @"cart/doAdd.jhtml"
#define Cart_DoEdit @"cart/doEdit.jhtml"
#define Cart_DoDelete @"cart/doDelete.jhtml"
#define Cart_List @"cart/list.jhtml"
#define Cart_DoClear @"cart/doClear.jhtml"
#define Cart_DoBatchDelete @"cart/doBatchDelete.jhtml"
#define Favorite_Add @"favorite/add.jhtml"
#define Favorite_Cancel @"favorite/cancel.jhtml"
#define Favorite_List @"favorite/list.jhtml"
#define Order_Checkout @"order/checkout.jhtml"
#define Order_Calculate @"order/calculate.jhtml"
#define Order_Create @"order/create.jhtml"
#define Order_View @"order/view.jhtml"
#define Order_Cancel @"order/cancel.jhtml"
#define Order_Receive @"order/receive.jhtml"
#define Order_List @"order/list.jhtml"

#define Vin_Query @"vin/query.jhtml"
#define Vin_QueryParts @"vin/queryParts.jhtml"

//发布话题
#define Topic_Publish @"topic/publish.jhtml"
#define Topic_Edit @"topic/edit.jhtml"
#define Topic_Cancel @"topic/cancel.jhtml"
#define Topic_GiveThumb @"topic/giveThumb.jhtml"
#define Topic_CancelThumb @"topic/cancelThumb.jhtml"
#define Topic_List @"topic/list.jhtml"
#define Topic_Info @"topic/info.jhtml"
#define Topic_myTopics @"topic/myTopics.jhtml"
#define Topic_myThumbTopics @"topic/myThumbTopics.jhtml"
#define Comment_Publish @"comment/publish.jhtml"
#define Comment_Reply @"comment/reply.jhtml"
#define Comment_Edit @"comment/edit.jhtml"
#define Comment_Cancel @"comment/cancel.jhtml"
#define Comment_GiveThump @"comment/giveThumb.jhtml"
#define Comment_CancelThump @"comment/cancelThumb.jhtml"
#define Comment_myComments @"comment/myComments.jhtml"
#define Comment_myThumbComments @"comment/myThumbComments.jhtml"
#define Comment_TopicComments @"comment/topicComments.jhtml"
//3.79
#define Comment_Info @"comment/info.jhtml"
#define Comment_getReplys @"comment/getReplys.jhtml"

#pragma mark 优秀钢琴url
#define ApiCommonLook @"api/common/look.jhtml" //3.1 查看短信验证码
#define DoRegister @"register/doRegister.jhtml" //3.2 申请注册发送验证码 3.3 提交注册会员
#define Login @"login/login.jhtml"//登录验证//?mobile=18379174290&password=111111&keyid=362831589e5d170fc6323d59db034bf5
#define LoginOut @"login/logout.jhtml" //3.5 退出登录
#define DoForgetPwd @"register/doForgetPwd.jhtml" //3.6 申请忘记发送验证码 3.7 提交忘记密码
#define MemberFindByMobile @"member/findByMobile.jhtml" //3.8 根据手机号查询会员资料
#define MemberFindByAccount @"member/findByAccount.jhtml" //3.9 根据账号查询会员资料
#define DoEditPass @"member/doEditPwd.jhtml" //3.10 修改密码
#define UpLoadImage @"common/uploadImage.jhtml"//3.11 图片上传接口 ?keyid=362831589e5d170fc6323d59db034bf5
#define RankFindAll_URL @"rank/findAll" //3.12 查询所有级别
#define RankFind @"rank/find.jhtml" //3.13根据ID查询级别
#define StylecategoryFindAll @"stylecategory/findAll"//3.14 查询所有类别
#define StylecateGoryFind @"stylecategory/find" //3.15 根据ID查询类别
#define MusicInfo @"music/info" //3.16 根据ID查询乐曲信息
#define MusicGetWxp @"music/getWxp" //3.17 获取五线谱
#define MusicGetJwp @"music/getJwp" //3.18 获取简五图谱
#define MusicGetGdp @"music/getGdp" //3.19获取固定谱 图谱
#define MusicGetSdp @"music/getSdp" //3.20 获取首调谱 图谱
#define HotSongGetSearchWords @"hotsong/getSearchWord" //3.12 获取 搜索关键字
#define HotSongWallTag_URL @"hotsong/wallTag" //3.22 获取标签墙
#define HotsongList_URL @"hotsong/list" //3.23 获取热门单曲列表
#define hotsongSearch_URL @"hotsong/search" //3.24 热门单曲关键字搜索列表
#define HotsongInfo_URL @"hotsong/info" //3.25 根据id获取热门单曲
#define AlbumList_URL @"album/list" //3.26 专辑列表
#define AlbumInfo_URL @"album/info" //3.27 专辑信息
#define CartQuantity_URL @"cart/quantity" //3.28 获取购物车数量
#define CartList_URL @"cart/list"   //3.29 购物车列表
#define CartDoAdd_URL @"cart/doAdd" //3.30 添加购物车
#define CartDoDelete_URL @"cart/doDelete"   //3.31 删除购物车某项
#define CartDoBatchDelete_URL @"cart/doBatchDelete" //3.32 批量删除购物车
#define CartDoClear_URL @"cart/doClear" //3.33 清空购物车
#define OrderCheckout_URL @"order/checkout"   //3.34 检出订单
#define OrderCreate_URL @"order/create" //3.35 创建订单
#define OrderView_URL @"order/view" //3.36 查看订单
#define MemberDoEdit    @"member/doEdit"    //3.37 修改会员资料
#define KnowledgeSchemaList @"knowledge/schemaList" //3.38 入门知识大纲列表
#define KnowSchemaInfo_URL @"knowledge/schemaInfo"  //3.39 大纲知识点列表
#define KonwledgeDetail_URL @"knowledge/detail" //3.40 知识点详情
#define PaymentUShowPay_URL @"payment/ushowPay" //3.41 悠点付款
#define PlayrecordPlay_URL @"playrecord/play"   //3.42 记录播放记录
#define PlayRecordList_URL @"playrecord/list"   //3.43 播放记录列表
#define PlayRecordDoBatchDelete @"playrecord/doBatchDelete" //3.44 批量删除 播放记录
#define ClientFileList @"clientfile/list"   //3.45文件管理列表
#define ClientfileView @"clientfile/view"  //3.46  文件歌曲详情
#define ClientfiledoDelete @"clientfile/doDelete"   //3.47 文件歌曲删除
#define ClientDownLoad @"clientfile/download"   //3.46  文件恢复下载
#define RechargerecordList @"rechargerecord/list" //3.48 充值记录列表
#define PaymentWXAppPay_URL @"payment/wxAppPay" //3.49 微信app支付订单
#define PaymentAliAppPay_URL @"payment/aliAppPay"    //3.50 支付宝App支付 订单
#define PaymentWXAppRecharge_URL @"payment/wxAppRecharge" //3.51 微信 APP支付 充值
#define PaymentAliAppPayRecharge_URL @"payment/aliAppRecharge"   //3.52 支付宝 APP支付 充值
#define OrderQuickBuy_URL @"order/quickBuy" //3.53 3.53歌曲或专辑直接生成订单
#define OrderList_URL @"order/list" //3.54  订单列表
#define OrderSongList_URL @"order/songList" //3.55 订单已购买
#define PlayRecordRemove_URL @"playrecord/remove"    //3.56 清空播放记录
#define MessagePublish_URL @"message/publish"    //3.57 提交反馈信息
#define MessageNotice_URL @"message/notice"    //3.58 消息通知条数
#define MessageRead_URL @"message/read"    //3.59 阅读消息通知
#define MessageList_URL @"message/list" //3.60 反馈列表
#define OrderGetDownLoad_URL @"order/getDownLoad" //3.61根据单号获取下载目录
#define LoginSendLoginValidate_URL @"login/sendLoginValidate" //3.64 发送登录验证吗
#define LoginLoginByValidate_URL @"login/loginByValidate" //3.65 手机+验证码登录
#define OrderGetOrderFile_URL @"order/getOrderFile"   //3.68 根据订单号查看客户端文件
#define OrderAbolish_URL @"order/abolish" //    3.69 订单作废接口
@implementation RequestURLDefine
+( NSString *)getFindCarBrandAll_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarBrandAll];
    return   url;
}
+( NSString *)getFindCarBrand_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarBrand];
    return   url;
}
+( NSString *)getFindCarBrandByFast_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarBrandByFast];
    return   url;
}
+( NSString *)getFindCarSeriesByBrand_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarSeriesByBrand];
    return   url;
}
+( NSString *)getFindCarSeriesAll_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarSeriesAll];
    return   url;
}
+( NSString *)getFindCarSeries_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarSeries];
    return   url;
}
+( NSString *)getFindCarModelBySeries_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarModelBySeries];
    return   url;
}
+( NSString *)getFindCarModelByBrand_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarModelByBrand];
    return   url;
}
+( NSString *)getFindCarModelAll_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarModelAll];
    return   url;
}
+( NSString *)getFindCarModel_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCarModel];
    return   url;
}
+( NSString *)getFindCAtegoryAll_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCAtegoryAll];
    return   url;
}
+( NSString *)getFindCategory_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCategory];
    return   url;
}
+( NSString *)getFindCategoryChildren_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindCategoryChildren];
    return   url;
}
+( NSString *)getFindAreaRoot_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindAreaRoot];
    return   url;
}
+( NSString *)getFindAreaRoots_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindAreaRoots];
    return   url;
}
+( NSString *)getFindChildren_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindChildren];
    return   url;
}
+( NSString *)getLook_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Look];
    return   url;
}




+( NSString *)getUpLoadImage_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,UpLoadImage];
    return   url;
}
+( NSString *)getDoEditPwd_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,DoEditPass];
    return   url;
}


+( NSString *)getReceiverList_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Receiver_list];
    return   url;
}
+( NSString *)getReceiverDoAdd_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Receiver_DoAdd];
    return   url;
}
+( NSString *)getReceiverDoEdit_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Receiver_DoEdit];
    return   url;
}
+( NSString *)getReceiverFind_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Receiver_Find];
    return   url;
}
+( NSString *)getReceiverDoDefault_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Receiver_DoDefault];
    return   url;
}
+( NSString *)getReceiverDoRemove_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Receiver_doRemove];
    return url;
}
+( NSString *)GetMemberDoShopInfo_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Member_DoShopInfo];
    return   url;
}
+( NSString *)GetCarSearch_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Car_Search];
    return   url;
}
+( NSString *)GetProductSearch_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Product_Search];
    return   url;
}
+( NSString *)GetProduct_list_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Product_List];
    return   url;
}
+( NSString *)GetProduct_Info_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Product_Info];
    return   url;
}
+( NSString *)GetCart_Quantity_ULR{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_Quantity];
    return   url;
}

+( NSString *)GetCart_DoAdd_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_DoAdd];
    return   url;
}
+( NSString *)GetCart_DoEdit_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_DoEdit];
    return   url;
}
+( NSString *)GetCart_Delete_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_DoDelete];
    return   url;
}
+( NSString *)GetCart_List_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_List];
    return   url;
}
+( NSString *)GetCart_DoClear_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_DoClear];
    return   url;
}
+( NSString *)GetFavorite_Add_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Favorite_Add];
    return   url;
}
+( NSString *)GetFavorite_Cancel_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Favorite_Cancel];
    return   url;
}
+( NSString *)GetFavorite_List_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Favorite_List];
    return   url;
}
+( NSString *)GetOrder_Checkout_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_Checkout];
    return   url;
}
+( NSString *)GetOrder_Calculate_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_Calculate];
    return   url;
}
+( NSString *)GetOrder_Create_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_Create];
    return   url;
}
+( NSString *)GetOrder_View_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_View];
    return   url;
}
+( NSString *)GetOrder_Cancel_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_Cancel];
    return   url;
}
+( NSString *)GetOrder_Receive_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_Receive];
    return   url;
}
+( NSString *)GetOrder_List_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Order_List];
    return   url;
}
+( NSString *)GetCart_DoBatchDelete_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Cart_DoBatchDelete];
    return   url;
}
+( NSString *)GetCommon_FindHotSearchs_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindHotSearchs];
    return   url;
}
+( NSString *)GetCommon_FindBanners_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,FindBanners];
    return   url;
}
+( NSString *)GetProduct_GoodsTop_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Prodect_GoodsTop];
    return   url;
}
+( NSString *)GetVinQuery_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Vin_Query];
    return url;
}
+( NSString *)GetVinQueryParts_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Vin_QueryParts];
    return url;
}

//社区论坛
+( NSString *)GetTopic_Publish_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_Publish];
    return url;
}
+( NSString *)GetTopic_Edit_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_Edit];
    return url;
}
+( NSString *)GetTopic_Cancel_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_Cancel];
    return url;
}
+( NSString *)GetTopic_GiveThumb_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_GiveThumb];
    return url;
}
+( NSString *)GetTopic_CancelThumb_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_CancelThumb];
    return url;
}
+( NSString *)GetTopic_List_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_List];
    return url;
}
+( NSString *)GetTopic_Info_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_Info];
    return url;
}
+( NSString *)GetTopic_myTopics_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_myTopics];
    return url;
}
+( NSString *)GetTopic_myThumbTopics_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Topic_myThumbTopics];
    return url;
}
+( NSString *)GetComment_Publish_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_Publish];
    return url;
}
+( NSString *)GetComment_Reply_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_Reply];
    return url;
}
+( NSString *)GetComment_Edit_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_Edit];
    return url;
}
+( NSString *)GetComment_Cancel_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_Cancel];
    return url;
}
+( NSString *)GetComment_GiveThump_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_GiveThump];
    return url;
}
+( NSString *)GetComment_CancelThump_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_CancelThump];
    return url;
}
+( NSString *)GetComment_myComments_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_myComments];
    return url;
}
+( NSString *)GetComment_myThumbComments_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_myThumbComments];
    return url;
}
+( NSString *)GetComment_TopicComments_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_TopicComments];
    return url;
}
+(NSString *)GetComment_CommentInfo_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_Info];
    return url;
}
+(NSString *)GetComment_GetReplysInfo_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Comment_getReplys];
    return url;
}

#pragma mark 优秀钢琴

+(NSString *)GetRankFindAll_URL{ //查询所有级别
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,RankFindAll_URL];
    return url;
}
+(NSString *)GetApiCommonLook_URL{ //3.1 查看短信验证码
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,ApiCommonLook];
    return url;
}

+( NSString *)getDoRegister_URL{ //3.2 申请注册发送验证码 3.3 提交注册会员
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,DoRegister];
    return   url;
}
+( NSString *)getLogin_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Login];
    return   url;
}
+( NSString *)getLogout_URL{ //3.5 退出登录
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,Logout];
    return   url;
}
+( NSString *)getDoForgetPwd_URL{
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,DoForgetPwd];
    return   url;
}
+( NSString *)GetMemberFindByMobile_URL{ //3.8 根据手机号查询会员资料
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,MemberFindByMobile];
    return   url;
}
+( NSString *)GetMemberFindByOauth_URL{ //3.9 根据账号查询会员资料
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, MemberFindByAccount];
    return   url;
}
+(NSString *)GetDoEditPass_URL{ //3.10 修改密码
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, DoEditPass];
    return   url;
}
+(NSString *)GetUpLoadImage_URL{ ////3.11 图片上传接口 ?keyid=362831589e5d170fc6323d59db034bf5
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, UpLoadImage];
    return   url;
}
+(NSString *)GetRankFind_URL{ //3.13 查询 根据ID查询级别
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, RankFind];
    return   url;
}
+(NSString *)GetStylecategoryFindAll_URL{ //3.14 查询所有类别
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, StylecategoryFindAll];
    return   url;
}
+(NSString *)GetStylecateGoryFind_URL{ //3.15 根据ID查询类别
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, StylecateGoryFind];
    return   url;
}
+(NSString *)GetMusicInfo_URL{ //3.16 根据ID查询乐曲信息
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, MusicInfo];
    return   url;
}
+(NSString *)GetMusicGetWxp_URL{  //3.17 获取五线谱
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, MusicGetWxp];
    return   url;
}
+(NSString *)GetMusicGetJwp_URL{  //3.18 获取简五图谱
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, MusicGetJwp];
    return   url;
}
+(NSString *)GetMusicGetGdp_URL{  //3.19获取固定谱 图谱
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, MusicGetGdp];
    return   url;
}
+(NSString *)GetMusicGetSdp_URL{  //3.20 获取首调谱 图谱
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, MusicGetSdp];
    return   url;
}
+(NSString *)GetHotSongGetSearchWords_URL{ //3.12 获取 搜索关键字
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix, HotSongGetSearchWords];
    return   url;
}
+(NSString *)GetHotSongWallTag_URL{ //3.22 获取标签墙
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,HotSongWallTag_URL];
    return url;
}
+(NSString *)GetHotsongList_URL{ //3.23 获取热门单曲列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,HotsongList_URL];
    return url;
}
+(NSString *)GethotsongSearch_URL{ //3.24 热门单曲关键字搜索列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,hotsongSearch_URL];
    return url;
}
+(NSString *)GetHotsongInfo_URL{ //3.25 根据id获取热门单曲
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,HotsongInfo_URL];
    return url;
}
+(NSString *)GetAlbumList_URL{ //3.26 专辑列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,AlbumList_URL];
    return url;
}
+(NSString *)GetAlbumInfo_URL{ //3.27 专辑信息
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,AlbumInfo_URL];
    return url;
}
+(NSString *)GetCartQuantity_URL{   //3.28 获取购物车数量
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,CartQuantity_URL];
    return url;
}
+(NSString *)GetCartList_URL{   //3.29 购物车列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,CartList_URL];
    return url;
}
+(NSString *)GetCartDoAdd_URL{   //3.30 添加购物车
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,CartDoAdd_URL];
    return url;
}
+(NSString *)GetCartDoDelete_URL{  //3.31 删除购物车某项
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,CartDoDelete_URL];
    return url;
}
+(NSString *)GetCartDoBatchDelete_URL{ //3.32 批量删除购物车
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,CartDoBatchDelete_URL];
    return url;
}
+(NSString *)GetCartDoClear_URL{ //3.33 清空购物车
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,CartDoClear_URL];
    return url;
}
+(NSString *)GetOrderCheckout_URL{  //3.34 检出订单
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderCheckout_URL];
    return url;
}
+(NSString *)GetOrderCreate_URL{  //3.35 创建订单
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderCreate_URL];
    return url;
}
+(NSString *)GetOrderView_URL{ //3.36 查看订单
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderView_URL];
    return url;
}
+(NSString *)GetMemberDoEdit_URL{  //3.37 修改会员资料
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,MemberDoEdit];
    return url;
}
+(NSString *)GetKnowledgeSchemaList_URL{  //3.38 入门知识大纲列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,KnowledgeSchemaList];
    return url;
}
+(NSString *)GetKnowSchemaInfo_URL{   //3.39 大纲知识点列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,KnowSchemaInfo_URL];
    return url;
}
+(NSString *)GetKonwledgeDetail_URL{   //3.40 知识点详情
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,KonwledgeDetail_URL];
    return url;
}
+(NSString *)GetPaymentUShowPay_URL{   //3.41 悠点付款
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PaymentUShowPay_URL];
    return url;
}
+(NSString *)GetPlayrecordPlay_URL{  //3.42 记录播放记录
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PlayrecordPlay_URL];
    return url;
}
+(NSString *)GetPlayRecordList_URLL{  //3.43 播放记录列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PlayRecordList_URL];
    return url;
}
+(NSString *)GetPlayRecordDoBatchDelete_URLL{  //3.44 批量删除 播放记录
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PlayRecordDoBatchDelete];
    return url;
}
+(NSString *)GetClientFileList_URLL{  //3.45文件管理列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,ClientFileList];
    return url;
}
+(NSString *)GetClientfileView_URLL{  //3.46  文件歌曲详情
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,ClientfileView];
    return url;
}
+(NSString *)GetClientfiledoDelete_URLL{  //3.47 文件歌曲删除
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,ClientfiledoDelete];
    return url;
}
+(NSString *)GetClientDownLoad_URLL{   //3.46  文件恢复下载
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,ClientDownLoad];
    return url;
}
+(NSString *)GetRechargerecordList_URLL{  //3.48 充值记录列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,RechargerecordList];
    return url;
}
+(NSString *)GetPaymentWXAppPay_URL{ //3.49 微信app支付订单
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PaymentWXAppPay_URL];
    return url;
}
+(NSString *)GetPaymentAliAppPay_URL{  //3.50 支付宝App支付 订单 //3.52 支付宝 APP支付 充值
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PaymentAliAppPay_URL];
    return url;
}
+(NSString *)GetPaymentWXAppRecharge_URL{  //3.51 微信 APP支付 充值
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PaymentWXAppRecharge_URL];
    return url;
}
+(NSString *)GetPaymentAliAppPayRecharge_URL{ //3.52 支付宝 APP支付 充值
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PaymentAliAppPayRecharge_URL];
    return url;
}
+(NSString *)GetOrderQuickBuy_URL{//3.53 歌曲或专辑直接生成订单
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderQuickBuy_URL];
    return url;
}
+(NSString *)GetOrdeList_URL{   //3.54 订单列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderList_URL];
    return url;
}
+(NSString *)GetOrderSongList_URL{ //3.55 订单已购买歌曲列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderSongList_URL];
    return url;
}
+(NSString *)GetPlayrecordRemove_URL{ //3.56 清空播放记录
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,PlayRecordRemove_URL];
    return url;
}
+(NSString *)GetMessagePublish_URL{ //3.57 提交反馈信息
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,MessagePublish_URL];
    return url;
}
+(NSString *)GetMessageNotice_URL{  //3.58 消息通知条数
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,MessageNotice_URL];
    return url;
}
+(NSString *)GetMessageRead_URL{    //3.59 阅读消息通知
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,MessageRead_URL];
    return url;
}
+(NSString *)GetMessageList_URL{    //3.60 反馈列表
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,MessageList_URL];
    return url;
}
+(NSString *)GetOrderGetDownLoad_URL{ //3.61 根据单号获取下载目录
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderGetDownLoad_URL];
    return url;
}
+(NSString *)GetLoginSendLoginValidate_URL{ //3.64发送登录验证码
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,LoginSendLoginValidate_URL];
    return url;
}
+(NSString *)GetLoginLoginByValidate_URL{// 3.65手机+验证码登录
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,LoginLoginByValidate_URL];
    return url;
}
+(NSString *)GetOrderGetOrderFile_URL{  //3.68 根据订单号查看客户端文件
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderGetOrderFile_URL];
    return url;
}
+ (NSString *)GetOrderAbolish_URL{ //3.69 订单作废接口
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_Prefix,OrderAbolish_URL];
    return url;
}
@end
