//
//  CalendarView.m
//  chjapp
//
//  Created by susu on 14-11-23.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "CalendarView.h"
#import "CanlendarCell.h"
@implementation CalendarView
{
    NSMutableArray *tableMuArr;
    NSMutableArray *times;
    NSInteger _index;
    NSString *_currentDate;
    NSDate *_selectedDate;
    BOOL _tmpBl;
    NSString *_dateStr;
}
+ (id)loadNib
{
    CalendarView *cell=[[[NSBundle mainBundle]loadNibNamed:@"CalendarView" owner:nil options:nil]lastObject];
    return cell;
    
}


- (void)initWith
{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    tableMuArr=[[NSMutableArray alloc]init];
    self.tableView.size=CGSizeMake(Main_Screen_Width, Main_Screen_Height-64-50-301);
    self.calendar = [JTCalendar new];
    _selectedDate=[NSDate date];
    [self getData];
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
    self.calendar.calendarAppearance.ratioContentMenu = 1.;
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    [self.calendar setContentView:self.calendarContentView];
    [self.calendar setDataSource:self];
    //[self.calendar reloadData];
    [self.calendar setCurrentDateSelected:[NSDate date]];
    _currentDate=[self dateToString:[NSDate date] formatType:@"YYYY年 MM月dd日"];
    _dateStr = [self dateToString:[NSDate date] formatType:@"yyyy-MM-dd"];
}


- (void)getData
{
    _tmpBl=NO;
    NSDate *today =_selectedDate;
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:today];
    NSString *month= [self dateToString:today formatType:@"YYYY-MM"];
    NSString *begin=[NSString stringWithFormat:@"%@-%lu",month,(unsigned long)days.location];
    NSString *end=[NSString stringWithFormat:@"%@-%lu",month,(unsigned long)days.length];
    _strWhere=[NSString stringWithFormat:@"and T.MDate between %@",[NSString stringWithFormat:@"'%@' and '%@'",begin,end]];
    if (_type==1)
    {
        [self getMyAndMyAttentionPeopleMeetingOneYear2];
         [self getDayMeetings:_selectedDate];
    }
    else if(_type==2)
    {
        [self getAllMeetingsBystartIndex:0 endIndext:100];
    }
   
}
#pragma mark - JTCalendarDataSource
-(NSString*)dateToString:(NSDate*)date formatType:(NSString *)type
{
    NSDate *datenow =date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:type];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSString *dateStr=[formatter stringFromDate:datenow];
    return dateStr;
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *x=[self dateToString:date formatType:@"YYYY-MM-dd"];
    
    if (_titleBlock)
    {
        _titleBlock([self dateToString:calendar.currentDate formatType:@"yyyy年 MM月"]);
    }
    if ([times containsObject:x])
    {
        return YES;
    }
    return NO;
}
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    _currentDate=[self dateToString:date formatType:@"YYYY年 MM月dd日"];
    _dateStr=[self dateToString:date formatType:@"yyyy-MM-dd"];
    _selectedDate=date;
    if (_index==0)
    {
        [self getDayMeetings:date];
    }
    else if (_index==1)
    {
        [self getFollowPeopelData:1 endIndext:20 date:date];
    }
}
-(void)getDayMeetings:(NSDate*)date
{
    _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",[self dateToString:date formatType:@"YYYY-MM-dd"]];
    
    if (_type==1)
    {
        [self getMyMeetingsBystartIndex:0 endIndext:20];
        
    }else if(_type==2)
    {
        [self getAllMeetingsBystartIndex:0 endIndext:20];
    }
}

- (IBAction)segment:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex==0)
    {
        if (_type==1)
        {
           [self getData];
        }
        else if(_type==2)
        {
            [self getAllMeetingsBystartIndex:0 endIndext:100];
        }
    }
    else
    {
        [self getFollowPeopelData:1 endIndext:20 date:_selectedDate];
        
    }
    _index=sender.selectedSegmentIndex;
}

#pragma mark - tableViewDelegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark - tableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block CalendarView *vc=self;
    static NSString *str=@"111";
    CanlendarCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[CanlendarCell loadNib];
        UIView *xx=[[UIView alloc]initWithFrame:cell.bounds];
        xx.backgroundColor=[UIColor clearColor];
        cell.selectedBackgroundView=xx;
        cell.action=^(id obj){
            NSInteger index=[(NSString*)obj integerValue];
            if (vc.dateAction)
            {
                vc.dateAction([tableMuArr objectAtIndex:index]);
            }
        };
    }
    cell.tag=indexPath.row;
    cell.type=_index;
    [cell setValueToViews:[tableMuArr objectAtIndex:indexPath.row]];
    return cell ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableMuArr.count;
}

// 我的会议安排
-(void)getMyMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
{
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage2_2 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<EName>%@</EName>\n"
                           "<strWhere>%@</strWhere>\n"
                           "<orderby></orderby>\n"
                           "<startIndex>%ld</startIndex>\n"
                           "<endIndex>%ld</endIndex>\n"
                           "</GetListByPage2_2>\n",USER_NAME,_strWhere,(long)startIndex,(long)endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage2_2"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        NSString* request = (NSString*)result;
        //  NSLog(@" == %@",request);
        [self xmlString:request];
        
    } failure:^(NSError *error){
    }];
    [operation startWithHUD:@"" inView:self];
}
-(void)getAllMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
{
    __block CalendarView *vc=self;
    //GetListByPage3
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage3 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<strWhere>%@</strWhere>\n"
                           "<orderby></orderby>\n"
                           "<startIndex>%ld</startIndex>\n"
                           "<endIndex>%ld</endIndex>\n"
                           "</GetListByPage3>\n",_strWhere,(long)startIndex,(long)endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage3"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        NSString* request = (NSString*)result;
        if (_tmpBl==NO)
        {
            [self getDayMeetings:[NSDate date]];
        }
        //DLog(@" response== %@",request);
        _tmpBl=YES;
        [vc xxmlString:request];
    } failure:^(NSError *error){
    }];
    [operation startWithHUD:@"" inView:self];
}

- (void)xmlString:(NSString*)xmlString
{
    //    [tableMuArr  removeAllObjects];
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetListByPage2_2Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetListByPage2_2Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    [tableMuArr removeAllObjects];
    
    //获取我的本地日程
    NSMutableArray *myArr = [UserDefaults objectForKey:KEY_AddActivity];
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    Product *productModel = [[Product alloc]init];
    
    for (int i=0; i<myArr.count; i++) {
        productModel = myArr[i];
        if ([_dateStr isEqualToString:productModel.MDate]) {
            [tempArr addObject:productModel];
        }
    }
    
    if (ds.count==0 && tempArr.count==0)
    {
        productModel = [Product meetingModelWithXml:nil];
        productModel.MName=[NSString stringWithFormat:@"%@暂无工作安排",_currentDate];
        [tableMuArr addObject:productModel];
    }
    else
    {
        for (GDataXMLElement * note in ds)
        {
            productModel = [Product meetingModelWithXml:note];
            [tableMuArr addObject:productModel];
        }
        [tableMuArr addObjectsFromArray:tempArr];
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView  reloadData];
    });
    
    //    NSLog(@"tableMuArr == %d",tableMuArr.count);
    
}
- (void)xxmlString:(NSString*)xmlString
{
    
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetListByPage3Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetListByPage3Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    NSMutableArray* muArr = [NSMutableArray array];
    [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    
    if (!times)
    {
        times = [NSMutableArray array];
        for (GDataXMLElement * note in ds)
        {
            Product* productModel = [Product meetingModelWithXml:note];
            [muArr addObject:productModel];
            [times addObject:[self subStringByRange:productModel.MDate]];
        }
    }
    else
    {
        [tableMuArr removeAllObjects];
        if (ds.count==0)
        {
            Product* productModel = [Product meetingModelWithXml:nil];
            productModel.MName=[NSString stringWithFormat:@"%@ 关注人暂无工作安排",_currentDate];
            [tableMuArr addObject:productModel];
        }
        else
        {
            BOOL bl;
            if (times.count==0)
            {
                bl=YES;
            }
            else
            {
                bl=NO;
            }
            for (GDataXMLElement * note in ds)
            {
                Product* productModel = [Product meetingModelWithXml:note];
                [muArr addObject:productModel];
                [tableMuArr addObject:productModel];
                if (bl==YES)
                {
                    [times addObject:[self subStringByRange:productModel.MDate]];
                }
            }

        }
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_calendar reloadData];
        [self.tableView  reloadData];
    });
        //[muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]]；
}
-(void)getMyAndMyAttentionPeopleMeetingOneYear2
{
    __block CalendarView *vc=self;
    NSString *today=[self dateToString:[NSDate date] formatType:@"YYYY-MM-dd"];
    //GetListByPage3
    NSString* urlString = [NSString stringWithFormat:@"<GetMyAndMyAttentionPeopleMeetingDateOneMonth2 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<EName>%@</EName>\n"
                           "<dtNow>%@</dtNow>\n"
                           "</GetMyAndMyAttentionPeopleMeetingDateOneMonth2>\n",USER_NAME,today];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetMyAndMyAttentionPeopleMeetingDateOneMonth2"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        
        NSString* request = (NSString*)result;
        //DLog(@" response== %@",request);
        [vc xxxmlString:request];
    } failure:^(NSError *error){
    }];
    [operation startWithHUD:@"" inView:self];
}
- (void)xxxmlString:(NSString*)xmlString
{
    
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetMyAndMyAttentionPeopleMeetingDateOneMonth2Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetMyAndMyAttentionPeopleMeetingDateOneMonth2Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"Table1"];
    NSMutableArray* muArr = [NSMutableArray array];
    //取回本地事件
    NSMutableArray* tempArray = [NSMutableArray array];
    [tempArray addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    if (!times)
    {
        times=[[NSMutableArray alloc]init];
    }else
        [times removeAllObjects];
    for (GDataXMLElement * note in ds)
    {
        Product* productModel = [Product meetingModelWithXml:note];
        [muArr addObject:productModel];
        [times addObject:[self subStringByRange:productModel.MDate]];
    }
    if (tempArray) {
        for (int i = 0; i < tempArray.count; i++) {
            Product *pro = [tempArray objectAtIndex:i];
            [times addObject:[self subStringByRange:pro.MDate]];
        }
    }
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        [_calendar reloadData];
    });
    //    [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]]；
}
-(void)getFollowPeopelData:(NSInteger)startIndex endIndext:(NSInteger)endIndex date:(NSDate*)date
{
    __block CalendarView *vc=self;
    NSString *today=[self dateToString:date formatType:@"YYYY-MM-dd"];
    //GetListByPage3
    NSString* urlString = [NSString stringWithFormat:@"<GetMyAndMyAttentionPeopleMeetingOneDay xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<EName>%@</EName>\n"
                           "<dtNow>%@</dtNow>\n"
                           "<pageSize>%ld</pageSize>\n"
                           "<pageIndex>%ld</pageIndex>\n"
                           "</GetMyAndMyAttentionPeopleMeetingOneDay>\n",USER_NAME,today,startIndex,endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetMyAndMyAttentionPeopleMeetingOneDay"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        
        NSString* request = (NSString*)result;
        //DLog(@" response== %@",request);
        [vc xmlStr:request];
    } failure:^(NSError *error){
    }];
    [operation startWithHUD:@"" inView:self];
}
- (void)xmlStr:(NSString*)xmlString
{
    
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetMyAndMyAttentionPeopleMeetingOneDayResponse"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetMyAndMyAttentionPeopleMeetingOneDayResult"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    NSMutableArray* muArr = [NSMutableArray array];
    [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    [tableMuArr removeAllObjects];
    if (ds.count==0)
    {
        Product* productModel = [Product meetingModelWithXml:nil];
        productModel.MName=[NSString stringWithFormat:@"%@ 关注人暂无工作安排",_currentDate];
        [tableMuArr addObject:productModel];
    }else
    {
        for (GDataXMLElement * note in ds)
        {
            Product* productModel = [Product meetingModelWithXml:note];
            [muArr addObject:productModel];
            [tableMuArr addObject:productModel];
        }
    }
   
    dispatch_sync(dispatch_get_main_queue(), ^{
        [self.tableView  reloadData];
    });
    //    [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]]；
}
-(NSString *)subStringByRange:(NSString*)date
{
    date=[date substringToIndex:10];
    return date ;
}
#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    [UIView animateWithDuration:.25
                     animations:^{
                         self.calendarContentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.calendarContentView.layer.opacity = 1;
                                          }];
                     }];
}
@end
