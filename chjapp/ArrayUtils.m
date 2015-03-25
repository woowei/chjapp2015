//
//  ArrayUtils.m
//  chjapp
//
//  Created by qinian-mac on 14/11/23.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "ArrayUtils.h"
#import "Product.h"

@implementation ArrayUtils

// 数组转成字典
+(NSMutableDictionary*)dictFromArray:(NSMutableArray*)array
{
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    
    for (Product* prod in array) {
        
        NSString* timeStr = [NSString stringWithFormat:@"%@ %@",[DateUtils stringFromMDate:prod.MDate],[DateUtils stringFromMTime:prod.MSTIme]];
        NSDate* date = [DateUtils dateFromTimeString:timeStr];
        NSString* dateStr = [DateUtils stringFromDate:date];
        [dic setObject:prod forKey:dateStr];
        
    }
    
//    NSArray* keyArr = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
//    NSArray* reversedArray = [[keyArr reverseObjectEnumerator] allObjects];
//    NSLog(@"%@",reversedArray);
    
    return dic;
}


@end
