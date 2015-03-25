//
//  NotificationUtils.m
//  chjapp
//
//  Created by qinian-mac on 14/11/25.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "NotificationUtils.h"

@implementation NotificationUtils

+ (void)setNotificationDate:(NSDate*)date alertBody:(NSString*)string
{
    
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"mainSwitch"];//总闹铃开关 1开启 0关闭
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"oneTime"];//1为当次事件提醒开启 0关闭
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"allDay"];//1为全天事件提醒开启  0关闭
    //    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"zhenDong"];//1 为震动 0 为铃音
    //    [[NSUserDefaults standardUserDefaults] setObject:@"8:00" forKey:@"oneDayOnceTime"];//全天事件提醒时间
    //    [[NSUserDefaults standardUserDefaults] setObject:@"15" forKey:@"allDayTime"];//当次时间提醒提前时间默认提前15分
    
    
    NSUserDefaults* userDefau = [NSUserDefaults standardUserDefaults];
    long timeLong = ([[userDefau objectForKey:@"allDayTime"] integerValue])*60;
    long longDate = [date timeIntervalSince1970];
    NSDate *notifDate = [NSDate dateWithTimeIntervalSince1970:longDate-timeLong];
    
    if ([[userDefau objectForKey:@"mainSwitch"] isEqualToString:@"1"]) {  // 判断有没有开闹钟
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        
        if (notification!=nil) {
            
            notification.fireDate=[notifDate dateByAddingTimeInterval:5];//10秒后通知
            notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
            notification.timeZone=[NSTimeZone defaultTimeZone];
            //        notification.applicationIconBadgeNumber=1; //应用的红色数字
            if ([[userDefau objectForKey:@"zhenDong"] isEqualToString:@"1"]) {
                notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成
                //NSLog(@"没开铃声 ");
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"短信01" forKey:@"ring"];
                NSString* senxinStr = [NSString stringWithFormat:@"%@.caf",[[NSUserDefaults standardUserDefaults] objectForKey:@"ring"]];
                //NSLog(@"开铃声了 %@",senxinStr);
                notification.soundName = senxinStr;
            }
            //去掉下面2行就不会弹出提示框
            notification.alertBody=string;//提示信息 弹出提示框
            notification.alertAction = @"确定";  //提示框按钮
            notification.hasAction = YES; //是否显示额外的按钮，为no时alertAction消失
            NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
            notification.userInfo = infoDict; //添加额外的信息
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            
        }
    }
}




- (void)removeNotification:(NSString*)notKey
{
    // 获得 UIApplication
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [app scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;
            if (dict) {
                NSString *inKey = [dict objectForKey:@"key"];
                if ([inKey isEqualToString:@"对应的key值"]) {
                    if (localNotification){
                        
                        localNotification = nil;
                    }
                    
                    break;
                }
            }
        }
//        //判断是否找到已经存在的相同key的推送
//        if (!localNotification) {
//            //不存在初始化
//            localNotification = [[UILocalNotification alloc] init];
//        }
//        
//        if (localNotification) {
//            //不推送 取消推送
//            [app cancelLocalNotification:localNotification];
//            return;
//        }
    }
}

@end
