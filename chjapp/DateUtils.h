//
//  DateUtils.h
//  chjapp
//
//  Created by qinian-mac on 14/11/23.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

// 日期
+(NSString*)stringFromMDate:(NSString*)dateString;


// 服务器时间转界面显示的时间
+(NSString*)stringFromMTime:(NSString *)timeString;


// string 转date
+(NSDate*)dateFromTimeString:(NSString *)timeString;


// nsdate 转时间戳

+ (NSString*)stringFromDate:(NSDate*)date;

//时间转字符
+(NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString*)formatter;


@end
