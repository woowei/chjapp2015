//
//  CommonDefine.h
//
//  Created by kc09 on 14-6-13.
//  Copyright (c) 2014年 kunchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MOBILE_INPUT_NAV    @"mobilenav"
#define GO_MOBILE_INPUT     @"gomobilenav"

#define KEY_ID              @"userId"
#define KEY_MOBILE          @"mobile"
#define KEY_USER_NAME       @"name"
#define KEY_CODE            @"code"
#define KEY_LOGIN_SUCCESS   @"loginsuccess"
#define KEY_BINDING_MOBILE  @"bindingmobile"
#define KEY_SOUND           @"sound"
#define KEY_VIBRATION       @"vibration"
#define KEY_LAMP            @"lamp"
#define KEY_REMOTE_PUSH     @"remote" //远程推送通知名称
#define KEY_EXIT_LOGIN      @"exit" //退出登录
#define KEY_PUSH_TOKEN      @"pushtoken"
#define KEY_AddActivity      @"addActivity"// 自己添加的个人会议安排

#define USER_ID     [CommonDefine getStringFromUserDefaultsWithKey:KEY_ID]
#define USER_MOBILE [CommonDefine getStringFromUserDefaultsWithKey:KEY_MOBILE]

#define USER_NAME  [CommonDefine getStringFromUserDefaultsWithKey:KEY_USER_NAME]

#define PUSH_TOKEN  (([CommonDefine getStringFromUserDefaultsWithKey:KEY_PUSH_TOKEN] == nil) ? @"" :[CommonDefine getStringFromUserDefaultsWithKey:KEY_PUSH_TOKEN])
#define USER_CODE   [CommonDefine getStringFromUserDefaultsWithKey:KEY_CODE]
#define IS_BINDING_MOBILE (([CommonDefine getStringFromUserDefaultsWithKey:KEY_BINDING_MOBILE]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_BINDING_MOBILE] isEqualToString:@"yes"])? YES : NO)

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
#define APP_DOWNLOAD_URL @"https://itunes.apple.com/us/app/cao-he-jing-ri-li/id958476900?mt=8&uo=4"
#define APP_SOUND (([CommonDefine getStringFromUserDefaultsWithKey:KEY_SOUND]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_SOUND] isEqualToString:@"yes"])? YES : NO)
#define APP_VIBRATION (([CommonDefine getStringFromUserDefaultsWithKey:KEY_VIBRATION]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_VIBRATION] isEqualToString:@"yes"])? YES : NO)
#define APP_LAMP (([CommonDefine getStringFromUserDefaultsWithKey:KEY_LAMP]==nil||[[CommonDefine getStringFromUserDefaultsWithKey:KEY_LAMP] isEqualToString:@"yes"])? YES : NO)

#define UmengAppkey @"50c72e295270153a8500000d"
#define kTagShareEdit 101
#define kTagSharePost 102

@interface CommonDefine : NSObject

/**
 *  把字符串格式数据存入USERDEFAULTS
 *
 *  @param string 存入的数据
 *  @param key    数据对应的KEY
 */
+ (void)saveStringToUserDefaults:(NSString *)string WithKey:(NSString *)key;
/**
 *  从USERDEFAULTS里获取字符串格式数据
 *
 *  @param key 数据对应的KEY
 *
 *  @return 字符串格式的数据
 */
+ (NSString *)getStringFromUserDefaultsWithKey:(NSString *)key;

/*
 四舍五入的方法
 floatV:需要处理的数字，
 format：保留小数点第几位，
 */
+(float) decimalwithFormat:(NSString *)format  floatV:(float)floatV;

/**
 *  将电话号码中间四位改为星号
 *
 *  @param 需要转换的电话号码
*
 *  @return 中间四位为星号的电话号码
 */
+ (NSString *)getSecretMobile:(NSString *)mobile;
//去除字符串
+(NSString *)subChineseString:(NSString*)text;
//去除特殊符号
+(NSString *)cancelSpecificSymbolForString:(NSString*)text;
//获取plist字典
+ (NSDictionary *)getDictByName:(NSString *)name;
//随机数
+ (int)getRandomNumber:(int)from to:(int)to;
//通过初始日期+7天 然后距离今天的倒计时
+ (NSDateComponents *)countDownFromDate:(NSDate *)date;
//打电话
+ (void)callOut:(NSString *)mobile;
//跳网址
+ (void)goWebsite:(NSString *)website;

@end
