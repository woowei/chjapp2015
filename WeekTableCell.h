//
//  WeekTableCell.h
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface WeekTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIView *markerView;
@property (strong,nonatomic)UIScrollView *scroll;
+(id)loadNib;
-(void)setValueToViews:(Product*)dict;
-(void)setValueToViews;
@end
