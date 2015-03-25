//
//  CHJRequest.h
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHJRequestUrl.h"
#define BASE_URL    @"http://oa.caohejing.com:8080/"

@interface CHJRequest : NSObject
//登录
+ (CHJRequestUrl *)loginRequestWithSoapBody:(NSString*)soapBody soapUrl:(NSString*)soapUrl;

//我的会议安排
+ (CHJRequestUrl *)GetListByPage2:(NSString*)soapBody soapUrl:(NSString*)soapUrl;

//关注人的会议
+ (CHJRequestUrl *)GetMyAttentionPeopleMeetings2:(NSString*)soapBody soapUrl:(NSString*)soapUrl;
@end
