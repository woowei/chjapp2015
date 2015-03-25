//
//  PHttpRequestOperation+HUD.h
//  iHaiGo
//
//  Created by kcmini on 14-6-19.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "PHttpRequestOperation.h"
#import "MBProgressHUD.h"

#define IMG_CHECK @"icon_check_hud"
#define IMG_ERROR @"icon_error_hud"

@interface PHttpRequestOperation (HUD)

/**
*  当网络操作时需要HUD时使用此系列方法
*
*  @param title     为网络操作动作名称，如：加载，请求等
*  @param view      为HUD加载的view，如：[[UIApplication sharedApplication] keyWindow]
*  @param automatic 成功后HUD是否自动隐藏，若选择不自动隐藏，则需要在成功方法中隐藏HUD，失败一直为自动隐藏
*/
- (void)startWithHUD:(NSString *)title inView:(UIView *)view automaticHidden:(BOOL)automatic;
- (void)cancelWithHUD:(NSString *)title inView:(UIView *)view automaticHidden:(BOOL)automatic;
- (void)pauseWithHUD:(NSString *)title inView:(UIView *)view automaticHidden:(BOOL)automatic;

/**
 *  当网络操作时需要HUD时使用此系列方法
 *
 *  @param title     title默认为加载时调用此方法
 *  @param view      为HUD加载的view，如：[[UIApplication sharedApplication] keyWindow]
 *  @param automatic 成功后HUD是否自动隐藏，若选择不自动隐藏，则需要在成功方法中隐藏HUD，失败一直为自动隐藏
 */
- (void)startWithHUDInView:(UIView *)view automaticHidden:(BOOL)automatic;
- (void)cancelWithHUDInView:(UIView *)view automaticHidden:(BOOL)automatic;
- (void)pauseWithHUDInView:(UIView *)view automaticHidden:(BOOL)automatic;

/**
 *  若选择不自动隐藏HUD后在请求完成方法中可调用以下方法隐藏HUD
 *
 *  @param title      HUD的标题
 *  @param view       HUD所在的view，如：[[UIApplication sharedApplication] keyWindow]
 *  @param completion HUD隐藏后BLOCK
 */
- (void)hideHUDSuccessWithTitle:(NSString *)title inView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;
- (void)hideHUDFailedWithTitle:(NSString *)title inView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;
- (void)hideHUDDirectlyInView:(UIView *)view completion:(MBProgressHUDCompletionBlock)completion;

@end
