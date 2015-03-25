//
//  IHGHttpRequest.m
//  iHaiGo
//
//  Created by kcmini on 14-6-17.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "IHGHttpRequest.h"

@implementation IHGHttpRequest

#pragma mark - lius

    //首页列表
+ (PHttpRequest *)getHomeInfo
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"home"
                                                          method:@""
                                                      httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}

    //商品列表
+ (PHttpRequest *)getGoodsList:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"home"
                                                          method:@"goods"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

    //首页广告
+ (PHttpRequest *)getHomeAds
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"home"
                                                          method:@"ads"
                                                      httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}

    //首页汇率
+ (PHttpRequest *)getExchangeRate
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"home"
                                                          method:@"exchangeRate"
                                                      httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}

    //添加收货地址
+ (PHttpRequest *)insertUserAddress:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"insertUserAddress"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

    //获取收货地址列表
+ (PHttpRequest *)getUserAddress:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"getUserAddress"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

    //修改收货地址
+ (PHttpRequest *)updateUserAddress:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"updateUserAddress"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

    //删除收货地址
+ (PHttpRequest *)deleteUserAddress:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"deleteUserAddress"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
    
}

    //获取用户信息
+ (PHttpRequest *)getFindUser:(NSDictionary *)parameters{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"findUser"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
    
}

    //修改个人信息
+ (PHttpRequest *)updateUser:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"updateUser"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;

}

//修改个人信息 新 不带头像
+ (PHttpRequest *)updateUserNew:(NSDictionary *)parameters{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"user"
                                                          method:USER_ID
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

    //修改密码
+ (PHttpRequest *)updatePassword:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"updatePassword"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

    //检测用户是否存在密码
+ (PHttpRequest *)checkPwd:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"checkPwd"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//意见反馈
+ (PHttpRequest *)insertActive:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"version"
                                                          method:@"insertActive"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//订单反馈
+ (PHttpRequest *)insertOrderFeedback:(NSDictionary *)parameters{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"version"
                                                          method:@"insertOrderFeedback"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//绑定手机
+ (PHttpRequest *)bindingMobile:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"bindingMobile"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//用户积分
+ (PHttpRequest *)insertuserScore:(NSString *)type Channel:(NSString *)channel{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    [parameters setObject:USER_ID      forKey:@"userId"];
    [parameters setObject:type         forKey:@"type"];     //加分或减分
    [parameters setObject:channel      forKey:@"channel"];  //类型

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"userScore"
                                                          method:@"insertuserScore"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//添加用户身份信息
+ (PHttpRequest *)insertUserCard:(NSDictionary*)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"insertUserCard"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//身份信息列表
+ (PHttpRequest *)getUserCard:(NSDictionary*)parameters{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"getUserCard"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//修改身份证信息
+ (PHttpRequest *)updateUserCard:(NSDictionary*)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"updateUserCard"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//删除身份证信息
+ (PHttpRequest *)deleteUserCard:(NSDictionary*)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"deleteUserCard"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
};

//对代购商评价列表
+ (PHttpRequest *)getEvaluationAgentsList:(NSDictionary*)parameters{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"evaluation"
                                                        method:@"getEvaluationAgentsList"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//获取转运公司详情
+ (PHttpRequest *)getTransportCompanyInfo:(NSDictionary*)parameters CompanyId:(NSString *)companyId{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"transports"
                                                          method:[NSString stringWithFormat:@"company/%@",companyId]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//添加运单
+ (PHttpRequest *)addLogistics:(NSDictionary*)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"logistics"
                                                          method:[NSString stringWithFormat:@"%@/add",USER_ID]
                                                      httpMethod:@"post"
                                                      parameters:parameters];
    return request;
}

//添加预报
+ (PHttpRequest *)addForecast:(NSDictionary*)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"transports"
                                                          method:@"forecast"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//添加用户对转运公司评价
+ (PHttpRequest *)insertEvaluationAgents:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"evaluation"
                                                        method:@"insertEvaluationAgents"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//添加预警
+ (PHttpRequest *)addRemind:(NSDictionary *)parameters gid:(NSString*)gid{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"message"
                                                          method:[NSString stringWithFormat:@"%@/add",gid]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//修改预警
+ (PHttpRequest *)updateRemind:(NSDictionary *)parameters gid:(NSString*)gid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"message"
                                                          method:[NSString stringWithFormat:@"%@/updateRemind",gid]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//删除预警
+ (PHttpRequest *)deleteRemind:(NSString*)rid
{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                      requestURL:[NSString stringWithFormat:@"message/%@",rid]
                                                      httpMethod:@"DELETE"
                                                      parameters:nil];
    return request;
}
//获取推送通知详情
+ (PHttpRequest *)getMessageInfo{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"message"
                                                          method:USER_ID
                                                      httpMethod:@"GET"
                                                      parameters:nil];
    return request;
    
}

//修改推送通知
+ (PHttpRequest *)messageUpdate:(NSDictionary *)parameters messageID:(NSString *)messageID{
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"message"
                                                          method:[NSString stringWithFormat:@"%@/update",messageID]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//版本信息
+ (PHttpRequest *)getVersion:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"version"
                                                          method:@"getVersion"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;

}

//转运公司评价列表
+ (PHttpRequest *)getEvaluationTransport:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"evaluation"
                                                          method:@"getEvaluationTransport"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;

}

//商品历史价格列表
+ (PHttpRequest *)getHistorical:(NSDictionary*)parameters Gid:(NSString*)gid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:@"http://192.168.1.3:8080"
                                                         service:@"message"
                                                          method:[NSString stringWithFormat:@"%@/getGoodHistorical",gid]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//首页通知列表
+ (PHttpRequest *)getNotice:(NSDictionary *)parameters{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"message"
                                                          method:[NSString stringWithFormat:@"getNotice"]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

#pragma mark - yu
//获取商品详情
+ (PHttpRequest *)goodsDetail:(NSString*)Gid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"goods/%@",Gid]
                                                      httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}
//获取商品收藏
+ (PHttpRequest *)getCollectedCount:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"getCount"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//商品收藏
+(PHttpRequest *)CollectGoods:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"insertCollection"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//添加用户对商品的评论
+(PHttpRequest *)addComment:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"evaluation"
                                                          method:@"insertEvaluationGood"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//商品库存
+ (PHttpRequest *)goodsStocks:(NSString*)Gid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"goods/%@/stocks",Gid]
                                                      httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}
//添加商品到购物车
+(PHttpRequest *)addShoppingCart:(NSDictionary*)parameters userId:(NSString*)uid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG requestURL:[NSString stringWithFormat:@"cart/%@",uid] httpMethod:@"POST" parameters:parameters];
    return request;
}
//获取购物车列表
+ (PHttpRequest *)getShoppingCartList:(NSString*)uid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"cart/%@",uid] httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}
//删除购物车商品
+ (PHttpRequest *)deleteGoods:(NSDictionary*)paramebers UserId:(NSString*)uid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"cart/%@/delete",uid]
                                                      httpMethod:@"POST"
                                                      parameters:paramebers];
    return request;
}
//修改商品车商品
+ (PHttpRequest *)changeGoods:(NSDictionary*)paramebers UserId:(NSString*)uid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"cart/%@/update",uid]
                                                      httpMethod:@"POST"
                                                      parameters:paramebers];
    return request;
}
//移至收藏夹
+ (PHttpRequest *)moveGoods:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"favorites"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//获取代购商列表
+ (PHttpRequest *)getAgentsList:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"agents"
                                                          method:@"getAgentsList"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
//获取代购商详情
+ (PHttpRequest *)getAgentDescribe:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"agents"
                                                          method:@"findAgents"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
//获取代购商评价列表
+ (PHttpRequest *)getAgentComments:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"evaluation"
                                                          method:@"getEvaluationAgentsList"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//获取代购商评价列表
+ (PHttpRequest *)getGoodsCommentsList:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"evaluation"
                                                          method:@"getEvaluationGoodList"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//获取商品收藏列表
+ (PHttpRequest *)getCollectedList:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"getCollection"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
//发表话题
+ (PHttpRequest *)publicationTopic:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"topics"
                                                          method:@"add"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//话题列表
+ (PHttpRequest *)publicationTopicList:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"topics"
                                                          method:@""
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
//话题详情
+ (PHttpRequest *)topicDescribe:(NSString*)tid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                      requestURL:[NSString stringWithFormat:@"topics/%@/show",tid] httpMethod:@"GET"
                                                      parameters:nil];
    return request;
}

//发表话题评论
+ (PHttpRequest *)publicationComment:(NSDictionary*)paramebers Tid:(NSString*)uid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                      requestURL:[NSString stringWithFormat:@"topics/%@/add",uid]
                                                      httpMethod:@"POST"
                                                      parameters:paramebers];
    return request;
}
//话题详情下的评论列表
+ (PHttpRequest *)topicCommentList:(NSDictionary*)paramebers UserId:(NSString*)tid
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                      requestURL:[NSString stringWithFormat:@"topics/%@/getList",tid]
                                                      httpMethod:@"GET"
                                                      parameters:paramebers];
    return request;
}
//获取我的话题列表
+ (PHttpRequest *)getMyTopicList:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"topics"
                                                          method:@"myTopic"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
//获取我的回复列表
+ (PHttpRequest *)getMyCommentsList:(NSDictionary*)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"topics"
                                                          method:@"respond"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
//删除收藏商品
+ (PHttpRequest *)deleteCollectedGoods:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"deleteCollection"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}
//取消收藏
+ (PHttpRequest *)cancelCollected:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"usercenter"
                                                          method:@"cancelCollection"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//关键字搜索 参数 criteria 关键字  category 分类  sort 排列方式
+ (PHttpRequest *)getSearch:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"goods"
                                                          method:@"search"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

#pragma mark - xu
//检验验证码
+ (PHttpRequest *)checkMessageCode:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"checkMsgCode"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)checkPhoneNumber:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"checkUser"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)getMessageCode:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"getMsgCode"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)registerUser:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"regUser"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)userActive:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"insertActive"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)login:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"loginUser"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)resetPassword:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"resetPassword"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

+ (PHttpRequest *)forgetPassword:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"forgetPwd"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//第三方登录
+ (PHttpRequest *)fastLogin:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"user"
                                                          method:@"fastLogin"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//订单列表
+ (PHttpRequest *)orders:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"orders"
                                                          method:@""
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//获取系统生成物流列表
+ (PHttpRequest *)systemLogistics:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"logistics"
                                                          method:@"system"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//获取手动生成物流列表
+ (PHttpRequest *)manualLogistics:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"logistics"
                                                          method:@"manual"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//物流列表
+ (PHttpRequest *)logisticsList:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_LI
                                                         service:@"logistics"
                                                          method:@""
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//订单详情
+ (PHttpRequest *)getOrderDetail:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"orders/%@/show",orderId]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//转运订单详情
+ (PHttpRequest *)getTransportOrderDetail:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"transports/%@",orderId]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//提交订单
+ (PHttpRequest *)submitOrder:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"orders"
                                                          method:@""
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//对代购商评价
+ (PHttpRequest *)insertEvaluateionAgents:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"evaluation"
                                                          method:@"insertEvaluationAgents"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//提醒发货
+ (PHttpRequest *)remindOrder:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"orders/%@/remind",orderId]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//确认收货
+ (PHttpRequest *)confirmOrder:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"orders/%@/confirm",orderId]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//物流地址详情
+ (PHttpRequest *)findLogistics:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"logistics/%@",orderId]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//修改物流
+ (PHttpRequest *)updateLogistics:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"logistics/%@",orderId]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//删除订单
+ (PHttpRequest *)deleteOrder:(NSString *)orderID parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"orders/%@/delete/%@",USER_ID,orderID]
                                                      httpMethod:@"DELETE"
                                                      parameters:parameters];
    return request;
}

//删除转运订单（取消预报）
+ (PHttpRequest *)deleteTransportOrder:(NSString *)orderID parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"transports/%@/delete/%@",USER_ID,orderID]
                                                      httpMethod:@"DELETE"
                                                      parameters:parameters];
    return request;
}

//移除订单条目
+ (PHttpRequest *)removeOrderItems:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"orders/%@",orderId]
                                                      httpMethod:@"DELETE"
                                                      parameters:parameters];
    return request;
}

//修改订单
+ (PHttpRequest *)editOrder:(NSString *)orderId parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"orders/%@",orderId]
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//获取物流公司列表
+ (PHttpRequest *)getLogisticsCompanyList:(double)time parameters:(NSDictionary *)parameters
{
    NSString *method = @"";
    if (time > 0) {
        method = [NSString stringWithFormat:@"%.0lf",time];
    }
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:@[method] forKeys:@[@"time"]];
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"app/logistics"]
                                                      httpMethod:@"GET"
                                                      parameters:dict];
    return request;
}

//获取转运公司列表
+ (PHttpRequest *)getTransportCompanyList:(double)time parameters:(NSDictionary *)parameters
{
    NSString *method = @"";
    if (time > 0) {
        method = [NSString stringWithFormat:@"%.0lf",time];
    }
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:@[method] forKeys:@[@"time"]];
    
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"app/transport"]
                                                      httpMethod:@"GET"
                                                      parameters:dict];
    return request;
}

//生成未完成订单
+ (PHttpRequest *)commitTransportOrder:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"transports"
                                                          method:@""
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//转运订单列表
+ (PHttpRequest *)getTransportOrderList:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"transports"
                                                          method:@""
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//获取转运公司包裹信息
+ (PHttpRequest *)getTransportGoods:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"transports"
                                                          method:@"goods"
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//发货操作
+ (PHttpRequest *)uploadOperation:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"transports"
                                                          method:@"operate"
                                                      httpMethod:@"POST"
                                                      parameters:parameters];
    return request;
}

//获得广告推广商品列表
+ (PHttpRequest *)getAdsGoodsList:(NSDictionary *)parameters adsID:(NSString *)adsID{

    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                         service:@"ads"
                                                          method:adsID
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//运单详情
+ (PHttpRequest *)getLogisticsDetail:(NSString *)loID parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"logistics/%@",loID]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}

//包裹运单详情
+ (PHttpRequest *)getPackageLogisticsDetail:(NSString *)loID parameters:(NSDictionary *)parameters
{
    PHttpRequest *request = [[PHttpRequest alloc]initWithBaseURL:BASE_URL_ZHENG
                                                      requestURL:[NSString stringWithFormat:@"logistics/%@/package",loID]
                                                      httpMethod:@"GET"
                                                      parameters:parameters];
    return request;
}
@end
