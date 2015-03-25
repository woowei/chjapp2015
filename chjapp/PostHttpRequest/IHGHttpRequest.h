//
//  IHGHttpRequest.h
//  iHaiGo
//
//  Created by kcmini on 14-6-17.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHttpRequest.h"

#ifdef DEBUG

//#define BASE_URL_LI     @"http://192.168.1.4:8080"
//#define BASE_URL_ZHENG  @"http://192.168.1.4:8080"
//#define BASE_IMAGE_ZHENG @"http://192.168.1.4:3000"
#define BASE_URL_LI     @"http://api.ihaigo.com/ihaigo"
#define BASE_URL_ZHENG  @"http://api.ihaigo.com/ihaigo"
#define BASE_IMAGE_ZHENG @"http://www.ihaigo.com"

#else

#define BASE_URL_LI     @"http://api.ihaigo.com/ihaigo"
#define BASE_URL_ZHENG  @"http://api.ihaigo.com/ihaigo"
#define BASE_IMAGE_ZHENG @"http://www.ihaigo.com"

#endif

@interface IHGHttpRequest : NSObject

//根据用户名查询用户是否注册
+ (PHttpRequest *)checkPhoneNumber:(NSDictionary *)parameters;

//获取验证码
+ (PHttpRequest *)getMessageCode:(NSDictionary *)parameters;

//检验验证码
+ (PHttpRequest *)checkMessageCode:(NSDictionary *)parameters;

//用户注册
+ (PHttpRequest *)registerUser:(NSDictionary *)parameters;

//首页
+ (PHttpRequest *)getHomeInfo;

//首页广告
+ (PHttpRequest *)getHomeAds;

//首页汇率
+ (PHttpRequest *)getExchangeRate;

//产品列表
+ (PHttpRequest *)getGoodsList:(NSDictionary *)parameters;

//用户激活
+ (PHttpRequest *)userActive:(NSDictionary *)parameters;

//用户登录
+ (PHttpRequest *)login:(NSDictionary *)parameters;

//用户设置密码
+ (PHttpRequest *)resetPassword:(NSDictionary *)parameters;

//找回密码
+ (PHttpRequest *)forgetPassword:(NSDictionary *)parameters;

//修改密码
+ (PHttpRequest *)updatePassword:(NSDictionary *)parameters;

//添加收货地址
+ (PHttpRequest *)insertUserAddress:(NSDictionary *)parameters;

//获取收货地址列表
+ (PHttpRequest *)getUserAddress:(NSDictionary *)parameters;

//修改收货地址
+ (PHttpRequest *)updateUserAddress:(NSDictionary *)parameters;

//获取用户信息
+ (PHttpRequest *)getFindUser:(NSDictionary *)parameters;

//修改个人信息
+ (PHttpRequest *)updateUser:(NSDictionary *)parameters;

//检测用户是否存在密码
+ (PHttpRequest *)checkPwd:(NSDictionary *)parameters;

//删除收货地址
+ (PHttpRequest *)deleteUserAddress:(NSDictionary *)parameters;

//获取商品详情
+ (PHttpRequest *)goodsDetail:(NSString*)Gid;

//商品收藏
+(PHttpRequest *)CollectGoods:(NSDictionary*)parameters;

//添加用户对商品的评论
+(PHttpRequest *)addComment:(NSDictionary*)parameters;

//第三方登录
+ (PHttpRequest *)fastLogin:(NSDictionary *)parameters;

//获取订单列表
+ (PHttpRequest *)orders:(NSDictionary *)parameters;

//获取系统生成物流列表
+ (PHttpRequest *)systemLogistics:(NSDictionary *)parameters;

//获取手动生成物流列表
+ (PHttpRequest *)manualLogistics:(NSDictionary *)parameters;

//物流列表
+ (PHttpRequest *)logisticsList:(NSDictionary *)parameters;

//商品库存
+ (PHttpRequest *)goodsStocks:(NSString*)Gid;

//添加商品到购物车
+(PHttpRequest *)addShoppingCart:(NSDictionary*)parameters userId:(NSString*)uid;

//获取购物车列表
+ (PHttpRequest *)getShoppingCartList:(NSString*)uid;

//删除商品车商品
+ (PHttpRequest *)deleteGoods:(NSDictionary*)paramebers UserId:(NSString*)uid;

//获取代购商列表
+ (PHttpRequest *)getAgentsList:(NSDictionary*)parameters;

//获取代购商详情
+ (PHttpRequest *)getAgentDescribe:(NSDictionary*)parameters;

//订单详情
+ (PHttpRequest *)getOrderDetail:(NSString *)orderId parameters:(NSDictionary *)parameters;

//获取代购商评价列表
+ (PHttpRequest *)getAgentComments:(NSDictionary*)parameters;


//获取代购商评价列表
+ (PHttpRequest *)getGoodsCommentsList:(NSDictionary*)parameters;


//提交订单
+ (PHttpRequest *)submitOrder:(NSDictionary *)parameters;

//意见反馈
+ (PHttpRequest *)insertActive:(NSDictionary *)parameters;

//修改个人信息 新 不带头像
+ (PHttpRequest *)updateUserNew:(NSDictionary *)parameters;


//修改商品车商品
+ (PHttpRequest *)changeGoods:(NSDictionary*)paramebers UserId:(NSString*)uid;

//绑定手机
+ (PHttpRequest *)bindingMobile:(NSDictionary *)parameters;

//对代购商评价
+ (PHttpRequest *)insertEvaluateionAgents:(NSDictionary *)parameters;

//提醒发货
+ (PHttpRequest *)remindOrder:(NSString *)orderId parameters:(NSDictionary *)parameters;

//确认收货
+ (PHttpRequest *)confirmOrder:(NSString *)orderId parameters:(NSDictionary *)parameters;

//物流地址详情
+ (PHttpRequest *)findLogistics:(NSString *)orderId parameters:(NSDictionary *)parameters;

//修改物流
+ (PHttpRequest *)updateLogistics:(NSString *)orderId parameters:(NSDictionary *)parameters;

//删除订单
+ (PHttpRequest *)deleteOrder:(NSString *)orderID parameters:(NSDictionary *)parameters;

//删除转运订单（取消预报）
+ (PHttpRequest *)deleteTransportOrder:(NSString *)orderID parameters:(NSDictionary *)parameters;

//移除订单条目
+ (PHttpRequest *)removeOrderItems:(NSString *)orderId parameters:(NSDictionary *)parameters;

//修改订单
+ (PHttpRequest *)editOrder:(NSString *)orderId parameters:(NSDictionary *)parameters;

//订单反馈
+ (PHttpRequest *)insertOrderFeedback:(NSDictionary *)parameters;

//获取商品收藏列表
+ (PHttpRequest *)getCollectedList:(NSDictionary*)parameters;


//发表话题
+ (PHttpRequest *)publicationTopic:(NSDictionary*)parameters;


//获取物流公司列表
+ (PHttpRequest *)getLogisticsCompanyList:(double)time parameters:(NSDictionary *)parameters;

//话题列表
+ (PHttpRequest *)publicationTopicList:(NSDictionary*)parameters;


//话题详情
+ (PHttpRequest *)topicDescribe:(NSString*)tid;


/*用户积分
  type  = 1加分 2减分
  channel ＝ 1、每日在线时间2 小时   2、分享软件     3、分享商品
             4、分享转运公司        5、分享话题     6、分享最新消息
*/
 + (PHttpRequest *)insertuserScore:(NSString *)type Channel:(NSString *)channel;

//添加用户身份信息
+ (PHttpRequest *)insertUserCard:(NSDictionary*)parameters;

//身份信息列表
+ (PHttpRequest *)getUserCard:(NSDictionary*)parameters;

//修改身份证信息
+ (PHttpRequest *)updateUserCard:(NSDictionary*)parameters;

//删除身份证信息
+ (PHttpRequest *)deleteUserCard:(NSDictionary*)parameters;

//获取转运公司列表
+ (PHttpRequest *)getTransportCompanyList:(double)time parameters:(NSDictionary *)parameters;

//发表话题评论
+ (PHttpRequest *)publicationComment:(NSDictionary*)paramebers Tid:(NSString*)uid;


//话题详情下的评论列表
+ (PHttpRequest *)topicCommentList:(NSDictionary*)paramebers UserId:(NSString*)tid;


//对代购商评价列表
+ (PHttpRequest *)getEvaluationAgentsList:(NSDictionary*)parameters;

//获取转运公司详情
+ (PHttpRequest *)getTransportCompanyInfo:(NSDictionary*)parameters CompanyId:(NSString *)companyId;

//添加运单
+ (PHttpRequest *)addLogistics:(NSDictionary*)parameters;

//添加预报
+ (PHttpRequest *)addForecast:(NSDictionary*)parameters;


//获取我的回复列表
+ (PHttpRequest *)getMyCommentsList:(NSDictionary*)parameters;

//获取我的话题列表
+ (PHttpRequest *)getMyTopicList:(NSDictionary*)parameters;

//生成未完成订单
+ (PHttpRequest *)commitTransportOrder:(NSDictionary *)parameters;

//添加用户对转运公司评价
+ (PHttpRequest *)insertEvaluationAgents:(NSDictionary *)parameters;

//转运订单列表
+ (PHttpRequest *)getTransportOrderList:(NSDictionary *)parameters;

//转运订单详情
+ (PHttpRequest *)getTransportOrderDetail:(NSString *)orderId parameters:(NSDictionary *)parameters;

//添加商品预警
+ (PHttpRequest *)addRemind:(NSDictionary *)parameters gid:(NSString*)gid;

//获取某个商品是否收藏以及收藏量
+ (PHttpRequest *)getCollectedCount:(NSDictionary*)parameters;

//获取转运公司包裹信息
+ (PHttpRequest *)getTransportGoods:(NSDictionary *)parameters;

//获取推送通知详情
+ (PHttpRequest *)getMessageInfo;

//修改推送通知
+ (PHttpRequest *)messageUpdate:(NSDictionary *)parameters messageID:(NSString *)messageID;

//删除收藏商品
+ (PHttpRequest *)deleteCollectedGoods:(NSDictionary *)parameters;

//取消收藏
+ (PHttpRequest *)cancelCollected:(NSDictionary *)parameters;

//发货操作
+ (PHttpRequest *)uploadOperation:(NSDictionary *)parameters;
//修改预警
+ (PHttpRequest *)updateRemind:(NSDictionary *)parameters gid:(NSString*)gid;

//删除预警
+ (PHttpRequest *)deleteRemind:(NSString*)rid;

//获得广告推广商品列表
+ (PHttpRequest *)getAdsGoodsList:(NSDictionary *)parameters adsID:(NSString *)adsID;

//移至收藏夹
+ (PHttpRequest *)moveGoods:(NSDictionary*)parameters;

//版本信息
+ (PHttpRequest *)getVersion:(NSDictionary *)parameters;

//转运公司评价列表
+ (PHttpRequest *)getEvaluationTransport:(NSDictionary *)parameters;

//商品历史价格列表
+ (PHttpRequest *)getHistorical:(NSDictionary*)parameters Gid:(NSString*)gid;

//运单详情
+ (PHttpRequest *)getLogisticsDetail:(NSString *)loID parameters:(NSDictionary *)parameters;

//包裹运单详情
+ (PHttpRequest *)getPackageLogisticsDetail:(NSString *)loID parameters:(NSDictionary *)parameters;

//关键字搜索
+ (PHttpRequest *)getSearch:(NSDictionary *)parameters;

//首页通知列表
+ (PHttpRequest *)getNotice:(NSDictionary *)parameters;

@end
