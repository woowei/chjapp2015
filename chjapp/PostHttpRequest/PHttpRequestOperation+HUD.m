//
//  PHttpRequestOperation+HUD.m
//  iHaiGo
//
//  Created by kcmini on 14-6-19.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "PHttpRequestOperation+HUD.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "PHttpRequest.h"

typedef enum{
    HUDAppearTypeSuccess,
    HUDAppearTypeFailed,
    HUDAppearTypePause,
    HUDAppearTypeCancel,
}HUDAppearType;

@implementation PHttpRequestOperation (HUD)

- (void)startWithHUD:(NSString *)title inView:(UIView *)view automaticHidden:(BOOL)automatic
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = [NSString stringWithFormat:@"正在%@",title];
    
    NSString *URLString = [self urlStringWithBaseURL:self.request.baseURL
                                          requestURL:self.request.requestURL];
    
    DLog(@"url==%@",URLString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = self.request.timeOutInterval;
    
    NSMutableURLRequest *request = [manager.requestSerializer
                                    requestWithMethod:self.request.httpMethod
                                    URLString:[[NSURL URLWithString:URLString] absoluteString]
                                    parameters:self.request.parameters
                                    error:nil];
    DLog(@"request == %@",request);
    self.operation = [manager HTTPRequestOperationWithRequest:request
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      DLog(@"请求成功\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n得到的结果为\n%@\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n",responseObject);
                                                      if (automatic) {
                                                          //显示成功提示
                                                          MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
                                                          hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_CHECK]];
                                                          hud.mode = MBProgressHUDModeCustomView;
                                                          hud.labelText = [NSString stringWithFormat:@"%@成功",title];
                                                          hud.tag = HUDAppearTypeSuccess;
                                                          [hud hide:YES afterDelay:0.5];
                                                          hud.completionBlock = ^{
                                                              if (self.success) {
                                                                  self.success(self, responseObject);
                                                              }
                                                          };
                                                      }else{
                                                          if (self.success) {
                                                              self.success(self, responseObject);
                                                          }
                                                      }
                                                  }
                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      DLog(@"请求失败\n<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\nERROR为\n%@\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n",error);
                                                      //显示失败提示
                                                      MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
                                                      hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ERROR]];
                                                      hud.mode = MBProgressHUDModeCustomView;
                                                      hud.labelText = [NSString stringWithFormat:@"%@失败",title];
                                                      [hud hide:YES afterDelay:0.5];
                                                      hud.completionBlock = ^{
                                                          if (self.failure) {
                                                              self.failure(self,error);
                                                          }
                                                      };
                                                  }];
    [manager.operationQueue addOperation:self.operation];
    [self.operation start];
}


- (void)startWithHUDInView:(UIView *)view automaticHidden:(BOOL)automatic
{
    [self startWithHUD:@"加载" inView:view automaticHidden:automatic];
}

- (void)cancelWithHUD:(NSString *)title inView:(UIView *)view automaticHidden:(BOOL)automatic
{
    [self.operation cancel];
    //显示取消提示
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ERROR]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = [NSString stringWithFormat:@"取消%@",title];
    [hud hide:YES afterDelay:0.5];
}

- (void)pauseWithHUD:(NSString *)title inView:(UIView *)view automaticHidden:(BOOL)automatic
{
    [self.operation pause];
    //显示取消提示
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ERROR]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = [NSString stringWithFormat:@"暂停%@",title];
    [hud hide:YES afterDelay:0.5];
}

- (void)cancelWithHUDInView:(UIView *)view automaticHidden:(BOOL)automatic
{
    [self cancelWithHUD:@"加载" inView:view automaticHidden:automatic];
}

- (void)pauseWithHUDInView:(UIView *)view automaticHidden:(BOOL)automatic
{
    [self pauseWithHUD:@"加载" inView:view automaticHidden:automatic];
}

- (void)hideHUDSuccessWithTitle:(NSString *)title inView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_CHECK]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = title;
    [hud hide:YES afterDelay:0.5];
    if (completion) {
        hud.completionBlock = completion;
    }
}

- (void)hideHUDFailedWithTitle:(NSString *)title inView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:IMG_ERROR]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = title;
    [hud hide:YES afterDelay:0.5];
    if (completion) {
        hud.completionBlock = completion;
    }
}

- (void)hideHUDDirectlyInView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    [hud hide:YES afterDelay:0.1];
    if (completion) {
        hud.completionBlock = completion;
    }
}
@end
