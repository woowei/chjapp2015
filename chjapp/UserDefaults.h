//
//  UserDefaults.h
//  chjapp
//
//  Created by qinian-mac on 14/11/22.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject


+ (void)setObject:(id)value forKey:(NSString *)defaultName;


// 取对象
+ (NSMutableArray*)objectForKey:(NSString *)defaultName;


// 取字典
+ (NSMutableArray*)objectArrForKey:(NSString *)defaultName;



@end
