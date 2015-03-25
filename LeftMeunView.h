//
//  LeftMeunView.h
//  chjapp
//
//  Created by 小郁 on 14-11-11.
//  Copyright (c) 2014年 chj. All rights reserved.
//
typedef void (^cellBlock)(id object);
#import <UIKit/UIKit.h>

@interface LeftMeunView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *titles;
@property (copy , nonatomic) cellBlock cellAction;
@property (assign,nonatomic)  NSInteger index;
-(id)initWithFrame:(CGRect)frame;
@end
