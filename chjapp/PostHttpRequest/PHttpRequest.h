//
//  PHttpRequest.h
//  iHaiGo
//
//  Created by kcmini on 14-6-17.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PHttpRequestOperation.h"

@interface PHttpRequest : NSObject

@property (strong, nonatomic)NSString *baseURL;
@property (strong, nonatomic)NSString *service;
@property (strong, nonatomic)NSString *method;
@property (strong, nonatomic)NSDictionary *parameters;
@property (assign, nonatomic)NSTimeInterval timeOutInterval;
@property (strong, nonatomic)NSString *httpMethod;
@property (strong, nonatomic)NSString *requestURL;

- (id)initWithBaseURL:(NSString *)baseURL
              service:(NSString *)service
               method:(NSString *)method
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters;

- (id)initWithBaseURL:(NSString *)baseURL
              service:(NSString *)service
               method:(NSString *)method
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
              timeOut:(NSTimeInterval)timeOutInterval;

- (id)initWithBaseURL:(NSString *)baseURL
           requestURL:(NSString *)requestURL
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters;

- (id)initWithBaseURL:(NSString *)baseURL
           requestURL:(NSString *)requestURL
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
              timeOut:(NSTimeInterval)timeOutInterval;

@end
