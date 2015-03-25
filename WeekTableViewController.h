//
//  WeekTableViewController.h
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface WeekTableViewController : UITableViewController
@property (copy,nonatomic) CommonBlock cellAction;
@property (strong,nonatomic) NSMutableArray *dataArray;//外部数据的接口
-(void)weekTableReloadData:(NSArray*)array week:(NSDate *)weekStr;
@end
