//
//  NotificationUtils.h
//  chjapp
//
//  Created by qinian-mac on 14/11/25.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationUtils : NSObject



// 添加本地推送
+ (void)setNotificationDate:(NSDate*)date alertBody:(NSString*)string;



// 删除本地推送
- (void)removeNotification:(NSString*)notKey;



@end
