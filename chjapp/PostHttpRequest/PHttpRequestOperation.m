//
//  PHttpRequestOperation.m
//  iHaiGo
//
//  Created by kcmini on 14-6-17.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "PHttpRequestOperation.h"
#import "PHttpRequest.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@interface PHttpRequestOperation()

@end


@implementation PHttpRequestOperation

- (id)initWithRequest:(PHttpRequest *)request
              success:(SuccessCompletion)success
              failure:(FailureCompletion)failure
{
    if (self = [super init]) {
        _request = request;
        _success = success;
        _failure = failure;
    }
    return self;
}

- (void)start
{
    NSString *URLString = [self urlStringWithBaseURL:_request.baseURL
                                          requestURL:_request.requestURL];
    DLog(@"url==%@",URLString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = _request.timeOutInterval;
    
    NSMutableURLRequest *request = [manager.requestSerializer
                                    requestWithMethod:_request.httpMethod
                                    URLString:[[NSURL URLWithString:URLString] absoluteString]
                                    parameters:_request.parameters
                                    error:nil];
    DLog(@"request==%@",request);
    _operation = [manager HTTPRequestOperationWithRequest:request
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      DLog(@"请求成功\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n得到的结果为\n%@\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n",responseObject);
                                                      if (self.success) {
                                                          self.success(self, responseObject);
                                                      }
    }
                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      DLog(@"请求失败\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\nERROR为\n%@\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n",error);
                                                      DLog(@"error code>>>>>>%d",error.code);
                                                      if (self.failure) {
                                                          self.failure(self,error);
                                                      }
    }];
    [manager.operationQueue addOperation:_operation];
    [_operation start];
}

- (void)cancel
{
    [self.operation cancel];
}

- (void)pause
{
    [self.operation pause];
}


- (NSString *)urlStringWithBaseURL:(NSString *)baseURL
                        requestURL:(NSString *)requestURL
{
    NSString *URLString = [baseURL stringByAppendingString:@"/"];
    URLString = [URLString stringByAppendingString:requestURL];
    return URLString;
}

@end
