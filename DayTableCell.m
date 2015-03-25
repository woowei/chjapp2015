//
//  DayTableCell.m
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "DayTableCell.h"

@implementation DayTableCell
+(id)loadNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DayTableCell" owner:nil options:nil]lastObject];
}
-(void)setValueToViews:(Product*)dict
{
    [_point setFrame:CGRectMake(9.5, 21, 10, 10)];
    [self drawCircle:_point radius:5 borderWidth:1.5 borderColor:S_GRAY_LINE];
    self.timeLabel.text=[NSString stringWithFormat:@"%@ - %@",[DateUtils stringFromMTime:dict.MSTIme],[DateUtils stringFromMTime:dict.METime]];
    self.contentLabel.text=[NSString stringWithFormat:@"%@",dict.MName];
}
#pragma mark - 辅助操作（画圆角、根据文字获取label的高度
//画圆
-(void)drawCircle:(UIView*)view radius:(CGFloat)f borderWidth:(CGFloat)width borderColor:(UIColor*)color
{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = f;
    view.layer.borderWidth = width;
    view.layer.borderColor=[color CGColor];
}
@end
