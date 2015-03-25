//
//  CalendarView.h
//  chjapp
//
//  Created by susu on 14-11-23.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"

@interface CalendarView : UIView<JTCalendarDataSource,UITableViewDataSource,UITableViewDelegate>
{
     NSString *_strWhere;
}
@property (weak , nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (weak , nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (strong,nonatomic) JTCalendar *calendar;
@property (copy , nonatomic) CommonBlock dateAction;
@property (copy , nonatomic) CommonBlock titleBlock;
@property (assign,nonatomic)NSInteger type;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentControl;
@property (nonatomic,retain) IBOutlet UILabel *label;

+ (id)loadNib;
- (void)initWith;
- (void)getData;

@end
