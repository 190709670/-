//
//  RequestURLDefine.h
//  QiXiuApp
//
//  Created by lihui on 2017/6/19.
//  Copyright © 2017年 HongJunTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestURLDefine : NSObject
+( NSString *)getFindCarBrandAll_URL;
+( NSString *)getFindCarBrand_URL;
+( NSString *)getFindCarBrandByFast_URL;
+( NSString *)getFindCarSeriesByBrand_URL;
+( NSString *)getFindCarSeriesAll_URL;
+( NSString *)getFindCarSeries_URL;
+( NSString *)getFindCarModelBySeries_URL;
+( NSString *)getFindCarModelByBrand_URL;
+( NSString *)getFindCarModelAll_URL;
+( NSString *)getFindCarModel_URL;

+( NSString *)getFindCAtegoryAll_URL;
+( NSString *)getFindCategory_URL;
+( NSString *)getFindCategoryChildren_URL;

//地址信息
+( NSString *)getFindAreaRoot_URL;
+( NSString *)getFindAreaRoots_URL;
+( NSString *)getFindChildren_URL;

+( NSString *)getLook_URL;
//收货地址相关
+( NSString *)getReceiverList_URL;
+( NSString *)getReceiverDoAdd_URL;
+( NSString *)getReceiverDoEdit_URL;
+( NSString *)getReceiverFind_URL;
+( NSString *)getReceiverDoDefault_URL;
+( NSString *)getReceiverDoRemove_URL;
//修改用户信息
+( NSString *)getUpLoadImage_URL; //上传图片／头像
//商家
+( NSString *)GetMemberDoShopInfo_URL;

+( NSString *)GetCarSearch_URL;
+( NSString *)GetProductSearch_URL;
+( NSString *)GetProduct_list_URL;
+( NSString *)GetProduct_Info_URL;
+( NSString *)GetCart_Quantity_ULR;
+( NSString *)GetCart_DoAdd_URL;
+( NSString *)GetCart_DoEdit_URL;
+( NSString *)GetCart_Delete_URL;
+( NSString *)GetCart_List_URL;
+( NSString *)GetCart_DoClear_URL;
+( NSString *)GetFavorite_Add_URL;
+( NSString *)GetFavorite_Cancel_URL;
+( NSString *)GetFavorite_List_URL;
+( NSString *)GetOrder_Checkout_URL;
+( NSString *)GetOrder_Calculate_URL;
+( NSString *)GetOrder_Create_URL;
+( NSString *)GetOrder_View_URL;
+( NSString *)GetOrder_Cancel_URL;
+( NSString *)GetOrder_Receive_URL;
//+( NSString *)GetOrder_List_URL;

+( NSString *)GetCart_DoBatchDelete_URL;
+( NSString *)GetCommon_FindHotSearchs_URL;
+( NSString *)GetCommon_FindBanners_URL;
+( NSString *)GetProduct_GoodsTop_URL;
+( NSString *)GetVinQuery_URL;
+( NSString *)GetVinQueryParts_URL;

//社区论坛
+( NSString *)GetTopic_Publish_URL;
+( NSString *)GetTopic_Edit_URL;
+( NSString *)GetTopic_Cancel_URL;
+( NSString *)GetTopic_GiveThumb_URL;
+( NSString *)GetTopic_CancelThumb_URL;
+( NSString *)GetTopic_List_URL;
+( NSString *)GetTopic_Info_URL;
+( NSString *)GetTopic_myTopics_URL;
+( NSString *)GetTopic_myThumbTopics_URL;
+( NSString *)GetComment_Publish_URL;
+( NSString *)GetComment_Reply_URL;
+( NSString *)GetComment_Edit_URL;
+( NSString *)GetComment_Cancel_URL;
+( NSString *)GetComment_GiveThump_URL;
+( NSString *)GetComment_CancelThump_URL;
+( NSString *)GetComment_myComments_URL;
+( NSString *)GetComment_myThumbComments_URL;
+( NSString *)GetComment_TopicComments_URL;
//3.79
+(NSString *)GetComment_CommentInfo_URL;
//3.80
+(NSString *)GetComment_GetReplysInfo_URL;
+( NSString *)getDoEditPwd_URL;


#pragma mark 优秀钢琴
+(NSString *)GetRankFindAll_URL; //查询所有级别
+(NSString *)GetApiCommonLook_URL; //3.1 查看短信验证码
+( NSString *)getDoRegister_URL; //3.2 申请注册发送验证码 3.3 提交注册会员
+( NSString *)getLogin_URL;
+( NSString *)getLogout_URL; //3.5 退出登录
+( NSString *)getDoForgetPwd_URL;
+( NSString *)GetMemberFindByMobile_URL; //3.8 根据手机号查询会员资料
+( NSString *)GetMemberFindByOauth_URL; //3.9 根据账号查询会员资料
+(NSString *)GetDoEditPass_URL; //3.10 修改密码
+(NSString *)GetUpLoadImage_URL; ////3.11 图片上传接口 ?keyid=362831589e5d170fc6323d59db034bf5
+(NSString *)GetRankFind_URL; //3.13 查询 根据ID查询级别
+(NSString *)GetStylecategoryFindAll_URL; //3.14 查询所有类别
+(NSString *)GetStylecateGoryFind_URL; //3.15 根据ID查询类别
+(NSString *)GetMusicInfo_URL; //3.16 根据ID查询乐曲信息
+(NSString *)GetMusicGetWxp_URL;  //3.17 获取五线谱
+(NSString *)GetMusicGetJwp_URL;  //3.18 获取简五图谱
+(NSString *)GetMusicGetGdp_URL;  //3.19获取固定谱 图谱
+(NSString *)GetMusicGetSdp_URL;  //3.20 获取首调谱 图谱
+(NSString *)GetHotSongGetSearchWords_URL; //3.12 获取 搜索关键字
+(NSString *)GetHotSongWallTag_URL; //3.22 获取标签墙
+(NSString *)GetHotsongList_URL; //3.23 获取热门单曲列表
+(NSString *)GethotsongSearch_URL; //3.24 热门单曲关键字搜索列表
+(NSString *)GetHotsongInfo_URL; //3.25 根据id获取热门单曲
+(NSString *)GetAlbumList_URL; //3.26 专辑列表
+(NSString *)GetAlbumInfo_URL; //3.27 专辑信息
+(NSString *)GetCartQuantity_URL;   //3.28 获取购物车数量
+(NSString *)GetCartList_URL;   //3.29 购物车列表
+(NSString *)GetCartDoAdd_URL;   //3.30 添加购物车
+(NSString *)GetCartDoDelete_URL;  //3.31 删除购物车某项
+(NSString *)GetCartDoBatchDelete_URL; //3.32 批量删除购物车
+(NSString *)GetCartDoClear_URL; //3.33 清空购物车
+(NSString *)GetOrderCheckout_URL;  //3.34 检出订单
+(NSString *)GetOrderCreate_URL;  //3.35 创建订单
+(NSString *)GetOrderView_URL; //3.36 查看订单
+(NSString *)GetMemberDoEdit_URL;  //3.37 修改会员资料
+(NSString *)GetKnowledgeSchemaList_URL;  //3.38 入门知识大纲列表
+(NSString *)GetKnowSchemaInfo_URL;   //3.39 大纲知识点列表
+(NSString *)GetKonwledgeDetail_URL;   //3.40 知识点详情
+(NSString *)GetPaymentUShowPay_URL;   //3.41 悠点付款
+(NSString *)GetPlayrecordPlay_URL;  //3.42 记录播放记录
+(NSString *)GetPlayRecordList_URLL;  //3.43 播放记录列表
+(NSString *)GetPlayRecordDoBatchDelete_URLL;  //3.44 批量删除 播放记录
+(NSString *)GetClientFileList_URLL;  //3.45文件管理列表
+(NSString *)GetClientfileView_URLL;  //3.46  文件歌曲详情
+(NSString *)GetClientfiledoDelete_URLL;  //3.47 文件歌曲删除
+(NSString *)GetClientDownLoad_URLL;   //3.46  文件恢复下载
+(NSString *)GetRechargerecordList_URLL;  //3.48 充值记录列表
+(NSString *)GetPaymentWXAppPay_URL; //3.49 微信app支付订单
+(NSString *)GetPaymentAliAppPay_URL;  //3.50 支付宝App支付 订单
+(NSString *)GetPaymentWXAppRecharge_URL;  //3.51 微信 APP支付 充值
+(NSString *)GetPaymentAliAppPayRecharge_URL; //3.52 支付宝 APP支付 充值
+(NSString *)GetOrderQuickBuy_URL;//3.53 歌曲或专辑直接生成订单
+(NSString *)GetOrdeList_URL;   //3.54 订单列表 3.55 订单已购买歌曲列表
+(NSString *)GetOrderSongList_URL; //3.55 订单已购买歌曲列表
+(NSString *)GetPlayrecordRemove_URL; //3.56 清空播放记录
+(NSString *)GetMessagePublish_URL; //3.57 提交反馈信息
+(NSString *)GetMessageNotice_URL;  //3.58 消息通知条数
+(NSString *)GetMessageRead_URL;    //3.59 阅读消息通知
+(NSString *)GetMessageList_URL;    //3.60 反馈列表
+(NSString *)GetOrderGetDownLoad_URL; //3.61 根据单号获取下载目录
+(NSString *)GetLoginSendLoginValidate_URL; //3.64发送登录验证码
+(NSString *)GetLoginLoginByValidate_URL;// 3.65手机+验证码登录
+(NSString *)GetOrderGetOrderFile_URL;  //3.68 根据订单号查看客户端文件
+ (NSString *)GetOrderAbolish_URL;//3.69 订单作废接口
@end
