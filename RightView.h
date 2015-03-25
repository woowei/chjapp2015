//
//  RightView.h
//  chjapp
//
//  Created by Gavin ican on 15/1/19.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic)CommonBlock cellAction;
@property (strong, nonatomic) NSMutableArray *dataSource;

- (id)initWithFrame:(CGRect)frame;
- (void)loadData:(NSArray*)array;

@end
