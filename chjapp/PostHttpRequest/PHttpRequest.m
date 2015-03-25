//
//  PHttpRequest.m
//  iHaiGo
//
//  Created by kcmini on 14-6-17.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "PHttpRequest.h"

@implementation PHttpRequest

- (id)initWithBaseURL:(NSString *)baseURL
              service:(NSString *)service
               method:(NSString *)method
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _service = service;
        _method = method;
        _httpMethod = httpMethod;
        _parameters = parameters;
        _timeOutInterval = 30;
        _requestURL = [self requestUrlStringService:service method:method];
    }
    return self;
}

- (id)initWithBaseURL:(NSString *)baseURL
              service:(NSString *)service
               method:(NSString *)method
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
              timeOut:(NSTimeInterval)timeOutInterval
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _service = service;
        _method = method;
        _httpMethod = httpMethod;
        _parameters = parameters;
        _timeOutInterval = timeOutInterval;
        _requestURL = [self requestUrlStringService:service method:method];
    }
    return self;
}


- (id)initWithBaseURL:(NSString *)baseURL
           requestURL:(NSString *)requestURL
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _requestURL = requestURL;
        _httpMethod = httpMethod;
        _parameters = parameters;
        _timeOutInterval = 30;
    }
    return self;
}

- (id)initWithBaseURL:(NSString *)baseURL
           requestURL:(NSString *)requestURL
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
              timeOut:(NSTimeInterval)timeOutInterval
{
    if (self = [super init]) {
        _baseURL = baseURL;
        _requestURL = requestURL;
        _httpMethod = httpMethod;
        _parameters = parameters;
        _timeOutInterval = timeOutInterval;
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
