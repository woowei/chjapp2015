//
//  DateUtils.m
//  chjapp
//
//  Created by qinian-mac on 14/11/23.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSString*)stringFromMDate:(NSString*)dateString
{
    NSString* string = [dateString substringToIndex:10];
    
    return string;
}

// 服务器时间转界面显示的时间
+(NSString*)stringFromMTime:(NSString *)timeString
{
    NSString* string = [timeString substringFromIndex:2];
    NSString *string1 = [string stringByReplacingOccurrencesOfString:@"H" withString:@":"];
   NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"M" withString:@""];
    if (string.length<5) {
        string2 = [NSString stringWithFormat:@"%@00",string2];
    }
    
    return string2;
}


// string 转date
+(NSDate*)dateFromTimeString:(NSString *)timeString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    return date;
}

// nsdate 转时间戳

+ (NSString*)stringFromDate:(NSDate*)date;
{
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeString;
}

// 时间转字符
+(NSString *)stringFromDate:(NSDate *)date withFormatter:(NSString*)formatter{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}


@end
