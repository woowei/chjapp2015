//
//  alertTableView.m
//  chjapp
//
//  Created by Chester on 14/12/14.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "alertTableView.h"

@implementation alertTableView
{
    NSString *_dateString;
    NSString *_yearString;
}

+(id)loadNib
{
    alertTableView *view=[[[NSBundle mainBundle] loadNibNamed:@"alertTableView" owner:nil options:nil]lastObject];
    [view drawCircle:view radius:3 borderWidth:1 borderColor:S_GRAY_LINE];
   
    return view;
}

-(void)setValueToView:(NSString*)date yearDate:(NSString*)year
{
    if (!_weeksArray)
    {
        _weeksArray=[[NSMutableArray alloc]init];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
    }
    else
    {
        [_weeksArray removeAllObjects];
    }
    _dateString=date;
    _yearString=year;
    [self weekByDate];
    [self.tableView reloadData];
}
-(void)weekByDate
{
    NSInteger week=_dateString.integerValue;
    NSInteger tmp;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:_yearString.integerValue];
    NSInteger d=52-week+4;
    for (int i=0; i<d; i++)
    {
        tmp= week-2+i;
        //NSString *str=[NSString stringWithFormat:@"%ld",(long)tmp];
        [comps setWeek:tmp];
        NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date = [cal dateFromComponents:comps];
        [_weeksArray addObject:date];
    }
}
- (IBAction)down:(UIButton *)sender
{
    if (_downAction)
    {
        _downAction(_dateString);
    }
}

- (IBAction)cancel:(UIButton *)sender
{
    if (_cancelAction)
    {
        _cancelAction(nil);
    }
}

#pragma mark - delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_downAction)
    {
        _downAction([self stringToDate:indexPath.row-3]);
    }
}

-(NSDate *)stringToDate:(NSInteger)index
{
    CGFloat now=[ [NSDate date] timeIntervalSince1970];
    now=now+index*7*24*3600;
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:now];
    //NSLog(@"date1:%@",date2);
    return date2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _weeksArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.font=[UIFont systemFontOfSize:14.0];
    cell.textAlignment = UITextAlignmentCenter;
    //cell.textLabel.text= [NSString stringWithFormat:@"%@年 第%@周",_yearString,_weeksArray[indexPath.row]];
    cell.textLabel.text = [self getWeekWithDate:_weeksArray[indexPath.row]];
    
    return cell;
}

- (NSString*)getWeekWithDate:(NSDate *)newDate
{
    if (newDate == nil) {
        newDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return nil;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    return [NSString stringWithFormat:@"%@至%@",beginString,endString];
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
