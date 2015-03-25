//
//  CHJRequestoperation.h
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//
#define IMG_CHECK @"icon_check_hud"
#define IMG_ERROR @"icon_error_hud"
typedef enum{
    HUDAppearTypeSuccess,
    HUDAppearTypeFailed,
    HUDAppearTypePause,
    HUDAppearTypeCancel,
}HUDAppearType;

typedef void (^SuccessdCompletion) (id resultObject);
typedef void (^FailedCompletion) (NSError *error);
#import <Foundation/Foundation.h>
#import "CHJRequestUrl.h"
#import "SVProgressHUD.h"

@class CHJRequest;
@class CHJRequestUrl;
@interface CHJRequestoperation : NSObject

@property (strong, nonatomic)CHJRequestUrl *request;
@property (copy, nonatomic)SuccessdCompletion success;
@property (copy, nonatomic)FailedCompletion failure;
@property (strong, nonatomic)NSOperation *operation;

- (id)initWithRequest:(CHJRequestUrl *)request
              success:(SuccessdCompletion)success
              failure:(FailedCompletion)failure;

- (void)startWithHUD:(NSString *)title inView:(UIView *)view;
- (void)cancel;

@end
