//
//  CHJRequestUrl.h
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHJRequestUrl : NSObject
@property (strong, nonatomic)NSString *baseURL;
@property (strong, nonatomic)NSString *service;
@property (strong, nonatomic)NSString *method;
@property (strong, nonatomic)NSDictionary *parameters;
@property (assign, nonatomic)NSTimeInterval timeOutInterval;
@property (strong, nonatomic)NSString *httpMethod;
@property (strong, nonatomic)NSString *requestURL;
@property (strong, nonatomic)NSString *soapBody;
@property (strong, nonatomic)NSString *soapUrl;

- (id)initWithBaseURL:(NSString *)baseURL
              service:(NSString *)service
               method:(NSString *)method
           httpMethod:(NSString *)httpMethod
           parameters:(NSDictionary *)parameters
             soapBody:(NSString*)soapBody
              soapUrl:(NSString*)soapUrl;
@end
