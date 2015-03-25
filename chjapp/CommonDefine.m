//
//  CommonDefine.m
//  iHaiGo
//
//  Created by kc09 on 14-6-13.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import "CommonDefine.h"

@implementation CommonDefine

+ (void)saveStringToUserDefaults:(NSString *)string WithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%@",string] forKey:key];
    [defaults synchronize];
}

+ (NSString *)getStringFromUserDefaultsWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *object = [defaults objectForKey:key];
    return object;
}

+(float) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [[numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]]floatValue];
}

+ (NSString *)getSecretMobile:(NSString *)mobile
{
    NSString *content = [NSString stringWithFormat:@"%@****%@",[mobile substringToIndex:3],[mobile substringWithRange:NSMakeRange(7,4)]];
    return content;
}

+ (NSString *)subChineseString:(NSString*)text
{
    NSInteger length = [text length];
    NSString *tmp=@"";
    for (int i=0; i<length; ++i)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [text substringWithRange:range];
        
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3)
        {
            tmp =[tmp stringByAppendingString:subString];
        }
    }
    
    for (int i=0; i<tmp.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [tmp substringWithRange:range];
        text = [text stringByReplacingOccurrencesOfString:subString withString:@""];
    }
    return text;
}

+ (NSString *)cancelSpecificSymbolForString:(NSString*)text
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *trimmedString = [text stringByTrimmingCharactersInSet:set];
    return trimmedString;
}

+ (NSDictionary *)getDictByName:(NSString *)name
{
    NSString *namep = [[NSBundle mainBundle]pathForResource:@"area" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:namep];
    NSDictionary *array = [dict objectForKey:name];
    return array;
}

//随机数
+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from+arc4random()%(to-from+1));
}

//通过初始日期+7天 然后距离今天的倒计时
+ (NSDateComponents *)countDownFromDate:(NSDate *)date
{
    NSTimeInterval interval = 86400.0 * 7;
    NSDate *dd = [date dateByAddingTimeInterval:interval];
    
    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    NSDate *today = [NSDate date];//得到当前时间
    
    //用来得到具体的时差
    unsigned int unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:dd options:0];
    
    return d;
}

//打电话
+ (void)callOut:(NSString *)mobile
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",mobile]]];
}

//跳网址
+ (void)goWebsite:(NSString *)website
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:website]];
}

@end
