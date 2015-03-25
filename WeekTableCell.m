//
//  WeekTableCell.m
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "WeekTableCell.h"
#import "DateUtils.h"
@implementation WeekTableCell

+(id)loadNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WeekTableCell" owner:nil options:nil]lastObject];
}
-(void)setValueToViews:(Product*)dict
{
    self.weekLabel.text=[NSString stringWithFormat:@"%@ - %@",[DateUtils stringFromMTime:dict.MSTIme],[DateUtils stringFromMTime:dict.METime]];
    self.dateLabel.text=dict.MName;
}

-(void)setValueToViews
{
    self.dateLabel.text=@"暂无工作安排";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
