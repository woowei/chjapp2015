//
//  WeekTableViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "WeekTableViewController.h"
#import "WeekTableCell.h"
#import "SectionHeaderView.h"
@interface WeekTableViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_weeks;
    NSMutableArray *_sectionViews;
    NSMutableArray *_tmpDataArray;
    NSMutableArray *_statusArray;
}

@end

@implementation WeekTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _weeks=[[NSMutableArray alloc]init];
    _dataArray=[[NSMutableArray alloc]init];
    _sectionViews=[[NSMutableArray alloc]init];
    _tmpDataArray=[[NSMutableArray alloc]init];
    _statusArray=[[NSMutableArray alloc]init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}
-(void)dateHelp:(NSDate*)week
{
    NSDate *now = week;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit
                                         fromDate:now];
    //设置周一为这周第一天
    [calendar setFirstWeekday:2];
    // 得到星期几
    // 1(星期天) 2(星期一) 3(星期二) 4(星期三) 5(星期四) 6(星期五) 7(星期六)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];
    //NSLog(@"weekDay:%ld   day:%ld",weekDay,day);
    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 8 - weekDay;
    }
    
    for (int i=1; i<8; i++)
    {
        // NSArray *weeks=[NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
        NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
        [firstDayComp setDay:day + firstDiff];
        firstDiff++;
        NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr=[formater stringFromDate:firstDayOfWeek];
        //dateStr =[dateStr stringByAppendingString:weeks[i-1]];
        // NSLog(@"开始 %@",[formater stringFromDate:firstDayOfWeek]);
        [_weeks addObject:dateStr];
    }
}

-(void)weekTableReloadData:(NSArray*)array week:(NSDate *)weekStr
{
    [_statusArray removeAllObjects];
    [_weeks removeAllObjects];
    [_dataArray removeAllObjects];
    [_tmpDataArray removeAllObjects];
    [_sectionViews removeAllObjects];
    [self dateHelp:weekStr];
    [self sectionViewsHelp:_weeks];
    [self sectionData:array];
    
}
-(void)sectionData:(NSArray*)array
{
    for (int d=0; d<_weeks.count; d++)
    {
        
        NSMutableArray *tmpArray=[[NSMutableArray alloc]init];
        NSString *dateStr=[_weeks objectAtIndex:d];
        [_tmpDataArray addObject:tmpArray];
        for (int i=0; i<array.count; i++)
        {
            Product *model=[array objectAtIndex:i];
            model.MDate=[model.MDate substringToIndex:10];
            
            if ([dateStr isEqualToString:model.MDate])
            {
                [tmpArray addObject:model];
            }
        }
        [_statusArray addObject:@"1"];
        [_dataArray addObject:tmpArray];
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        //回调或者说是通知主线程刷新，
        [self.tableView reloadData];
    });
    
}
-(void)sectionViewsHelp:(NSArray*)array
{
}
-(void)sectionActionByindex:(NSInteger)index addOrMove:(BOOL)bl
{
    if (bl == 0)
    {
        [_tmpDataArray replaceObjectAtIndex:index withObject:[NSArray array]];
    }
    else
    {
        [_tmpDataArray replaceObjectAtIndex:index withObject:[_dataArray objectAtIndex:index]];
    }
    [_statusArray replaceObjectAtIndex:index withObject:[NSString stringWithFormat:@"%d",bl]];
    [self.tableView reloadData];
}
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _weeks.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *data=[_tmpDataArray objectAtIndex:section];
    return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"week";
    WeekTableCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[WeekTableCell loadNib];
    }
    [cell  setValueToViews:[[_tmpDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    //cell.weekLabel.text=[_weeks objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}
#pragma mark - Delegate
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //DLog(@"sec==%ld",_weeks.count);
    NSArray *tmpArray=[NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    __block WeekTableViewController *vc=self;
    
    SectionHeaderView *header=[SectionHeaderView loadNib];
    header.timeLab.text=[NSString stringWithFormat:@"%@   %@",_weeks[section],tmpArray[section]];
    header.btn.tag=section;
    header.selected=[[_statusArray objectAtIndex:section] boolValue];
    header.action=^(UIButton *btn, id objc){
        NSString *str=objc;
        [vc sectionActionByindex:btn.tag addOrMove:str.integerValue];
    };
    
    //判断是否为今日
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [dateFormatter stringFromDate:[NSDate date]];
    if ([today isEqualToString:_weeks[section]] == YES) {
        
    }
    //[_sectionViews addObject:header];
    
    return header;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView  deselectRowAtIndexPath:indexPath animated:YES];
    if (_cellAction)
    {
        _cellAction([[_tmpDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 39;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
