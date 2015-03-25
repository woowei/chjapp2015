//
//  DayTableViewController.h
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTableViewController : UITableViewController
@property (copy,nonatomic)CommonBlock cellAction;
@property (strong,nonatomic) NSArray *dataArray;//外部数据的接口
-(void)dayTableReloadData:(NSArray*)array;
@end
