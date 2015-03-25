//
//  UserDefaults.m
//  chjapp
//
//  Created by qinian-mac on 14/11/22.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "UserDefaults.h"
#import "Product.h"

@implementation UserDefaults



+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:defaultName];
    [userDefaults synchronize];
}

+ (NSMutableArray*)objectForKey:(NSString *)defaultName{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* jsonString =[userDefaults objectForKey:defaultName];
    
    NSMutableArray* muArr = [NSMutableArray array];
    if (jsonString!=nil) {
        
        
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        
        for (NSDictionary* dic in array) {
            Product* model = [[Product alloc]init];
            model.MName = [dic objectForKey:@"MName"];
            model.MDate = [dic objectForKey:@"MDate"];
            model.MSTIme = [dic objectForKey:@"MSTIme"];
            model.METime = [dic objectForKey:@"METime"];
            model.MNote = [dic objectForKey:@"MNote"];
            model.MRemind = [dic objectForKey:@"MRemind"];
            model.MPersonal = [dic objectForKey:@"MPersonal"];
            model.MIdentifier = [dic objectForKey:@"MIdentifier"];
            //        NSLog(@"mprer ==%@   \n\n %@",jsonString,model.MPersonal);
            [muArr addObject:model];
        }

    }
    
    //    NSLog(@"array == %ld",array.count);
    
    
    
    return muArr;
}

+ (NSMutableArray*)objectArrForKey:(NSString *)defaultName
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* jsonString =[userDefaults objectForKey:defaultName];
    
    NSMutableArray *muArray = [NSMutableArray array];
    if (jsonString!=nil) {
        NSError *error;
        muArray = [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    }

    return muArray;
}

@end
