//
//  CHJRequest.m
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "CHJRequest.h"

@implementation CHJRequest
//登录
+ (CHJRequestUrl *)loginRequestWithSoapBody:(NSString*)soapBody soapUrl:(NSString*)soapUrl
{
    CHJRequestUrl *request = [[CHJRequestUrl alloc]initWithBaseURL:BASE_URL
                                                         service:@"WebService"
                                                          method:@"Employees.asmx"
                                                      httpMethod:@"POST"
                                                      parameters:nil
                                                        soapBody:soapBody
                                                        soapUrl:soapUrl];
    return request;
}

//我的会议安排
+ (CHJRequestUrl *)GetListByPage2:(NSString*)soapBody soapUrl:(NSString*)soapUrl
{
    CHJRequestUrl *request = [[CHJRequestUrl alloc]initWithBaseURL:BASE_URL
                                                           service:@"WebService"
                                                            method:@"Meetings.asmx"
                                                        httpMethod:@"POST"
                                                        parameters:nil
                                                          soapBody:soapBody
                                                           soapUrl:soapUrl];
    return request;
}

//关注人的会议
+ (CHJRequestUrl *)GetMyAttentionPeopleMeetings2:(NSString*)soapBody soapUrl:(NSString*)soapUrl
{
    CHJRequestUrl *request = [[CHJRequestUrl alloc]initWithBaseURL:BASE_URL
                                                           service:@"WebService"
                                                            method:@"Attention.asmx"
                                                        httpMethod:@"POST"
                                                        parameters:nil
                                                          soapBody:soapBody
                                                           soapUrl:soapUrl];
    return request;
}


@end
