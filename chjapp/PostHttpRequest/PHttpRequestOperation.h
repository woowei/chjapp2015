//
//  PHttpRequestOperation.h
//  iHaiGo
//
//  Created by kcmini on 14-6-17.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <Foundation/Foundation.h>

@class PHttpRequestOperation;
typedef void (^SuccessCompletion) (PHttpRequestOperation *operation, id resultObject);
typedef void (^FailureCompletion) (PHttpRequestOperation *operation, NSError *error);

@class PHttpRequest;
@class AFHTTPRequestOperation;

@interface PHttpRequestOperation : NSObject

@property (strong, nonatomic)PHttpRequest *request;
@property (copy, nonatomic)SuccessCompletion success;
@property (copy, nonatomic)FailureCompletion failure;
@property (strong, nonatomic)AFHTTPRequestOperation *operation;


- (id)initWithRequest:(PHttpRequest *)request
              success:(SuccessCompletion)success
              failure:(FailureCompletion)failure;

- (NSString *)urlStringWithBaseURL:(NSString *)baseURL
                        requestURL:(NSString *)requestURL;

- (void)start;
- (void)cancel;
- (void)pause;


@end
