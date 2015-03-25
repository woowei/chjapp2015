//
//  AllViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "AllViewController.h"
#import "GDataXMLNode.h"
#import "MyActivityCell.h"

#import "AddActivity ViewController.h"
#import "DayTableViewController.h"
#import "WeekTableViewController.h"
#import "Product.h"
#import "SVProgressHUD.h"
#import "CalendarView.h"
#import "DetailsMeetingViewController.h"
#import "alertTableView.h"
#import "DateAndTimePickerViewController.h"
#import "QNCustomDatePickerView.h"
@interface AllViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_meetings;
    NSInteger _tableTag;
    NSString *_strWhere;
    DateAndTimePickerViewController *_datePicker;
    NSMutableDictionary* tableMuDic;
    NSArray* peiXuArr;
    NSInteger numIndex;
    NSDate *_weekDate;
    NSString *_dateStr;
    QNCustomDatePickerView *datePicker;
}
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)DayTableViewController *dayViewControl;
@property (strong,nonatomic)WeekTableViewController *weekViewControl;
@property (strong,nonatomic)CalendarView *calendarView;
@property (strong,nonatomic)alertTableView *alertTable;
@end

@implementation AllViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [CommonDefine saveStringToUserDefaults:@"1" WithKey:@"index"];
    self.automaticallyAdjustsScrollViewInsets=NO;
    if (!_meetings)
    {
        _meetings=[[NSMutableArray alloc]init];
    }
    AppDelegate *app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.LeftView.index=1;
    [app.LeftView.tableView reloadData];
    [self initNavigationBar];
    _strWhere=@"";
    _tableTag=1;
    _weekDate=[NSDate date];
    _dateStr = [self dateToString:[NSDate date] formatType:@"yyyy-MM-dd"];
    __block AllViewController *vc=self;
    if (!_alertTable)
    {
        _alertTable=[alertTableView loadNib];
        _alertTable.center=CGPointMake(self.view.center.x, self.view.center.y-10);
      
        _alertTable.downAction=^(NSData *obj){
            
            _weekDate=obj;
            [vc navi];
            _strWhere=[self dateToString:obj formatType:@"YYYY-MM-dd"];
            [vc getAllMeetingsBystartIndex:1 endIndext:50];
            [vc hideAlert];
        };
        _alertTable.cancelAction=^(id obj){
            [vc hideAlert];
        };
        [self.view addSubview:_alertTable];
        _alertTable.alpha=0;
    }
     [self addWeekTable];
    // Do any additional setup after loading the view.
}
-(void)showAlert
{
    [self.view bringSubviewToFront:_alertTable];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _alertTable.alpha=1;
                         self.weekViewControl.tableView.userInteractionEnabled=NO;
                     }];
}
-(void)hideAlert
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _alertTable.alpha=0;
                         self.weekViewControl.tableView.userInteractionEnabled=YES;
                     }];
}
#pragma mark -addViews
-(void)addTableView
{
    if (!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50)];
        _tableView.tag=0;
        _tableView.delegate=self;
        _tableView.dataSource=self;
         [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [_tableView addFooterWithTarget:self action:@selector(footerRefresh)];
        [self.view addSubview:_tableView];
    }
    else
    {
        self.tableView.hidden=NO;
    }
    numIndex=30;
    self.navigationItem.rightBarButtonItem=nil;
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"所有日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
    _strWhere=@"and 1=1";
    [_tableView headerBeginRefreshing];
}

-(void)addDayTable
{
    if (!_dayViewControl)
    {
        _dayViewControl=[[DayTableViewController alloc]init];
        _dayViewControl.tableView.frame=CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50);
        __block AllViewController *vc=self;
        _dayViewControl.cellAction=^(id obj){
            [vc detailMessage:obj];
        };
        [self.view addSubview:_dayViewControl.tableView];
    }
    else
    {
        _dayViewControl.tableView.hidden=NO;
    }
    
    _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",_dateStr];
    
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@日程",_dateStr] withAlignment:NavigationBarTitleViewAlignmentCenter];
    
    numIndex = 10;
    [self getDayMeetingsBystartIndex:1 endIndext:numIndex];
   
    datePicker = [[QNCustomDatePickerView alloc] initWithFrame:self.view.frame];
    [datePicker.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [datePicker.datePicker setDatePickerMode:UIDatePickerModeDate];
    datePicker.hidden = YES;
    [self.view addSubview:datePicker];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker:)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
}
-(void)titleAction:(UITapGestureRecognizer*)tap
{
    if (!_datePicker)
    {
         _datePicker =[[DateAndTimePickerViewController alloc]initWithNibName:@"DateAndTimePickerViewController" bundle:nil];
        _datePicker.view.frame=CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height);
        __block AllViewController *vc=self;
        _datePicker.dateAction=^(id obj){
//            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//            NSString *tmpDateStr = [self dateToString:[dateFormatter dateFromString:obj] formatType:@"yyyy-MM-dd"];
//            _dateStr = tmpDateStr;
            _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",obj];
            vc.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@日程",obj] withAlignment:NavigationBarTitleViewAlignmentCenter];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleAction:)];
            [vc.navigationItem.titleView addGestureRecognizer:tap];
            _datePicker=nil;
             [vc getDayMeetingsBystartIndex:1 endIndext:10];
        };
        [self.view bringSubviewToFront: _datePicker.view];
        [self.view addSubview:_datePicker.view];
    }
    [UIView animateWithDuration:0.3 animations:^{
        _datePicker.view.frame=CGRectMake(0, -24, Main_Screen_Width, Main_Screen_Height);
    }];
}

- (void)showDatePicker:(UITapGestureRecognizer *)tap
{
    datePicker.hidden = NO;
}

- (void)changeDate:(UIDatePicker *)sender
{
    NSDate *targetDate = sender.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:targetDate];
    
    _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",dateString];
    
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@日程",dateString] withAlignment:NavigationBarTitleViewAlignmentCenter];
    numIndex = 10;
    [self getDayMeetingsBystartIndex:1 endIndext:numIndex];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker:)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
}

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

-(void)addWeekTable
{
    if (!_weekViewControl)
    {
        _weekViewControl=[[WeekTableViewController alloc]init];
        _weekViewControl.tableView.frame=CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64);
        __block AllViewController *vc=self;
        _weekViewControl.cellAction=^(id obj){
            [vc detailMessage:obj];
        };
        [self.view addSubview:_weekViewControl.tableView];
    }
    else
    {
        _weekViewControl.tableView.hidden=NO;
    }
    _strWhere=[self dateToString:[NSDate date] formatType:@"YYYY-MM-dd"];
    numIndex=50;
    [self getAllMeetingsBystartIndex:1 endIndext:numIndex];
    [self navi];
    
   
    //[_weekViewControl weekTableReloadData12:_meetings];
}
-(void)navi
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@年 第%@周",currentDateStr,[self getWeekFromDate:_weekDate]] withAlignment:NavigationBarTitleViewAlignmentCenter];
    [_alertTable setValueToView:[self getWeekFromDate:[NSDate date ]] yearDate:currentDateStr];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weekTitle:)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
}
-(void)addCalendarView
{
    __block AllViewController *vc=self;
    if (!_calendarView) {
        _calendarView=[CalendarView loadNib];
        [_calendarView setFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50)];
         _calendarView.type=2;
        [_calendarView.segmentControl setHidden:YES];
        [_calendarView.label setHidden:NO];
        [_calendarView initWith];
        //_calendarView.
       
        _calendarView.dateAction=^(id obj)
        {
             [vc detailMessage:obj];
        };
        _calendarView.titleBlock=^(NSString *title){
            vc.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@",title] withAlignment:NavigationBarTitleViewAlignmentCenter];
        };
        [self.view addSubview:_calendarView];
    }else
    {
        _calendarView.hidden=NO;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy年 MM月"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@",currentDateStr] withAlignment:NavigationBarTitleViewAlignmentCenter];
}
- (NSString*)getMonthBeginAndEndWith:(NSDate *)newDate
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
    
    return [NSString stringWithFormat:@"'%@' and '%@'",beginString,endString];
}
-(NSString*)getWeekFromDate:(NSDate*)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:date];
    NSInteger week = [comps week];
    
    return [NSString stringWithFormat:@"%ld",(long)week];
}

-(void)hideTable:(NSInteger)index
{
     NSArray *tmpTables=[NSArray arrayWithObjects:_calendarView,_weekViewControl.tableView,_dayViewControl.tableView, nil];
    for (int i=0; i<tmpTables.count; i++)
    {
        UITableView *table=[tmpTables objectAtIndex:i];
        if (i!=index)
        {
            table.hidden=YES;
        }
        else
        {
            table.hidden=NO;
            [self.view bringSubviewToFront:table];
        }
    }
}
-(void)headerRefresh
{
    [self getAllMeetingsBystartIndex:0 endIndext:numIndex];
}

-(void)footerRefresh
{
    numIndex = numIndex+10;
    [self getAllMeetingsBystartIndex:0 endIndext:numIndex+10];
}
- (void)initNavigationBar
{
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"所有日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
    
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withImage:@"morex" withHighlightImage:@"morex"];
    
//    UIBarButtonItem *shareBtn=[CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(addThing) withImage:@"addx" withHighlightImage:@"addx"];
//    
//    [self.navigationItem setRightBarButtonItem:shareBtn];
}
-(void)leftMeun
{
    __block AllViewController *vc=self;
    AppDelegate *app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    app.LeftView.cellAction=^(id obj){
        //DLog(@"obj==%@",obj);
        [vc tableViewChooseed:obj];
        [app hidedLeftView];
    };
   
    if (app.LeftView.tag==0)
    {
        [app showLeftMenu];
    }
    else
    {
        [app hidedLeftView];
    }
}
-(void)tableViewChooseed:(NSString*)index
{
    _tableTag=index.integerValue;
    if (_tableTag==0)
    {
        [self addCalendarView];
    }
    else if (_tableTag==1)
    {
        [self addWeekTable];
    }
    else if (_tableTag==2)
    {
        [self addDayTable];
    }
    [self hideTable:index.integerValue];
}

-(void)addThing
{
    //NSLog(@"添加日程");
    AddActivity_ViewController* addVC = [[AddActivity_ViewController alloc]init];
    //    addVC.title = @"增加我和日程";
    [self.navigationController pushViewController:addVC animated:YES];
}

-(void)weekTitle:(UITapGestureRecognizer*)tap
{
    [self showAlert];
}
#pragma mark- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  static NSString *str=@"cell";
    MyActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[MyActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell tableViewCellDict:tableMuDic reverseArray:peiXuArr Index:indexPath.row];
//    [cell tableViewCellArray:_meetings Index:(int)indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return peiXuArr.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* keyString = [peiXuArr objectAtIndex:indexPath.row];
    
    Product* product = [tableMuDic objectForKey:keyString];
    
//    if ((BOOL)[product.MPersonal integerValue]) {
//        
//        NSLog(@"自己添加的");
//        
//        AddActivity_ViewController* addVC = [[AddActivity_ViewController alloc]init];
//        addVC.product = product;
//        [self.navigationController pushViewController:addVC animated:YES];
//    }else{
    [self detailMessage:product];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
}
-(void)detailMessage:(Product*)model
{
    DetailsMeetingViewController* detailsVC = [[DetailsMeetingViewController alloc]init];
    detailsVC.product = model;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - Request
-(void)getAllMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
{
    __block AllViewController *vc=self;
    //GetListByPage3
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage3_1 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<dtNow>%@</dtNow>\n"
                           "<orderby></orderby>\n"
                           "<startIndex>%ld</startIndex>\n"
                           "<endIndex>%ld</endIndex>\n"
                           "</GetListByPage3_1>\n",_strWhere,(long)startIndex,(long)endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage3_1"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        if (startIndex==1)
        {
            [_meetings removeAllObjects];
        }
       [_tableView footerEndRefreshing];
        [_tableView headerEndRefreshing];
        NSString* request = (NSString*)result;
         //DLog(@" response== %@",request);
        [vc xmlString:request];
        
    } failure:^(NSError *error){
        numIndex=numIndex-10;
        //NSLog(@"失败");
    }];
    [operation startWithHUD:@"加载会议" inView:self.view];
}
- (void)xmlString:(NSString*)xmlString
{
    __block AllViewController *vc=self;
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetListByPage3_1Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetListByPage3_1Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"ds"];
    

    
    for (GDataXMLElement * note in ds)
    {
        Product* productModel = [Product meetingModelWithXml:note];
        [_meetings addObject:productModel];
    }
    
    //[muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    
    tableMuDic = [ArrayUtils dictFromArray:_meetings];
    
    NSArray* keyArr = [[tableMuDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSArray* reversedArray = [[keyArr reverseObjectEnumerator] allObjects];
    peiXuArr = [NSMutableArray arrayWithArray:reversedArray];
    
    if (_meetings.count==0)
    {
        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"没有会议安排..." duration:0.8];
    }
    if (_tableTag==0)
    {
        //        [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    }
    else if (_tableTag==1)
    {
        [vc.weekViewControl weekTableReloadData:_meetings week:_weekDate];
    }
    else if (_tableTag==2)
    {
        [vc.dayViewControl dayTableReloadData:_meetings];
    }
}
-(void)getDayMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
{
    __block AllViewController *vc=self;
    //GetListByPage3
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage3 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<strWhere>%@</strWhere>\n"
                           "<orderby></orderby>\n"
                           "<startIndex>%ld</startIndex>\n"
                           "<endIndex>%ld</endIndex>\n"
                           "</GetListByPage3>\n",_strWhere,(long)startIndex,(long)endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage3"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        if (startIndex==1)
        {
            [_meetings removeAllObjects];
        }
        [_tableView footerEndRefreshing];
        [_tableView headerEndRefreshing];
        NSString* request = (NSString*)result;
        //DLog(@" response== %@",request);
        [vc xxmlString:request];
        
    } failure:^(NSError *error){
        numIndex=numIndex-10;
        //NSLog(@"失败");
    }];
    [operation startWithHUD:@"加载会议" inView:self.view];
}
- (void)xxmlString:(NSString*)xmlString
{
    __block AllViewController *vc=self;
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
    
    
    
    for (GDataXMLElement * note in ds)
    {
        Product* productModel = [Product meetingModelWithXml:note];
        [_meetings addObject:productModel];
    }
    
    //    [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    
    tableMuDic = [ArrayUtils dictFromArray:_meetings];
    
    NSArray* keyArr = [[tableMuDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSArray* reversedArray = [[keyArr reverseObjectEnumerator] allObjects];
    peiXuArr = [NSMutableArray arrayWithArray:reversedArray];
    
    if (_meetings.count==0)
    {
        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"没有会议安排..." duration:0.8];
    }
    if (_tableTag==0)
    {
        //        [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    }
    else if (_tableTag==1)
    {
        [vc.weekViewControl weekTableReloadData:_meetings week:_weekDate];
    }
    else if (_tableTag==2)
    {
        [vc.dayViewControl dayTableReloadData:_meetings];
    }
}

#pragma mark - MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
