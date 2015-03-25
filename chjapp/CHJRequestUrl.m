//
//  CHJRequestUrl.m
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "CHJRequestUrl.h"

@implementation CHJRequestUrl

- (id)initWithBaseURL:(NSString *)baseURL
              service:(NSString *)service
               method:(NSString *)method
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
             soapBody:(NSString*)soapBody soapUrl:(NSString *)soapUrl
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _service = service;
        _method = method;
        _httpMethod = httpMethod;
        _parameters = parameters;
        _timeOutInterval = 30;
        _soapBody=soapBody;
        _soapUrl=soapUrl;
        _requestURL = [self requestUrlStringService:service method:method];
    }
    return self;
}
- (NSString *)requestUrlStringService:(NSString *)service
                               method:(NSString *)method
{
    NSString *URLString = service;
    URLString = [URLString stringByAppendingString:@"/"];
    URLString = [URLString stringByAppendingString:method];
    return URLString;
}
@end
