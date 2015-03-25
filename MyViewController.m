//
//  MyViewController.m
//  chjapp
//
//  Created by 小郁 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "MyViewController.h"
#import "MJRefresh.h"
#import "MyActivityCell.h"
#import "GDataXMLNode.h"
#import "AddActivity ViewController.h"
#import "DetailsMeetingViewController.h"
#import "Product.h"
#import "DayTableViewController.h"
#import "WeekTableViewController.h"
#import "Product.h"
#import "SVProgressHUD.h"
#import "CalendarView.h"
#import "LoginViewController.h"
#import "DateAndTimePickerViewController.h"
#import "alertTableView.h"
#import "QNCustomDatePickerView.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    UITableView *myTableView;
    BOOL   isShowed;
    NSString *_strWhere; //查询条件
    NSMutableArray* tableMuArr;
    NSMutableDictionary* tableMuDic;
    NSArray* peiXuArr;
    DateAndTimePickerViewController *_datePicker;
    NSInteger _tableTag;
    NSInteger numIndex;
    NSDate *_weekDate;
    NSString *_dateStr;
}

@property (strong,nonatomic)DayTableViewController *dayViewControl;
@property (strong,nonatomic)WeekTableViewController *weekViewControl;
@property (strong,nonatomic)CalendarView *calendarView;
@property (strong,nonatomic)alertTableView *alertTable;

@end

@implementation MyViewController
{
    NSMutableArray *dataArray;
    QNCustomDatePickerView *datePicker;     //按日显示选取日期
}

// 我的会议安排
- (void)getAllMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
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
        //        NSLog(@" == %@",request);
        [myTableView headerEndRefreshing];
        [myTableView footerEndRefreshing];
        [self xmlString:request];
    } failure:^(NSError *error){
        //NSLog(@"失败");
    }];
    [operation startWithHUD:@"获取我的日程" inView:self.view];
}

- (void)xmlString:(NSString *)xmlString
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
    //读取本地我的日程
    NSMutableArray *myArray = [UserDefaults objectForKey:KEY_AddActivity];
    //所选日的日程
    NSMutableArray *dateArray = [[NSMutableArray alloc]init];
    if(myArray.count>0)
    {
        for (int i=0; i<myArray.count; i++) {
            Product *productModel = myArray[i];
            if([_dateStr isEqualToString:productModel.MDate]){
                [dateArray addObject:productModel];
            }
        }
    }
    
    NSMutableArray* muArr = [NSMutableArray array];
    tableMuArr = [NSMutableArray array];
    for (GDataXMLElement * note in ds){
        Product* productModel = [Product meetingModelWithXml:note];
        [muArr addObject:productModel];
        [tableMuArr addObject:productModel];
    }
    [muArr addObjectsFromArray:dateArray];
    [tableMuArr addObjectsFromArray:myArray];

    __block MyViewController *vc=self;
    if (muArr.count==0)
    {
        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"没有会议安排..." duration:0.8];
    }
    
    [tableMuDic removeAllObjects];
    tableMuDic = [ArrayUtils dictFromArray:muArr];
    
    NSArray* keyArr = [[tableMuDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSArray* reversedArray = [[keyArr reverseObjectEnumerator] allObjects];
    peiXuArr = [NSMutableArray arrayWithArray:reversedArray];
    if (_tableTag==0)
    {
        //        [muArr addObjectsFromArray:[UserDefaults objectForKey:KEY_AddActivity]];
    }
    else if (_tableTag==1)
    {
        [vc.weekViewControl weekTableReloadData:tableMuArr week:_weekDate];
        [vc.weekViewControl.tableView reloadData];
      
    }
    else if (_tableTag==2)
    {
         [vc.dayViewControl dayTableReloadData:muArr];
    }
    
    //    NSLog(@"tableMuArr == %d",tableMuArr.count);
    
}


//查询所有人今日会议安排
- (void)getDayMeetingsBystartIndex:(NSInteger)startIndex endIndext:(NSInteger)endIndex
{
    __block MyViewController *vc=self;
    //GetListByPage3
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //用[NSDate date]可以获取系统当前时间
    //NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    //NSString *dateStr = [NSString stringWithFormat:@"and T.MDate='%@'",currentDateStr];
    NSString *dateStr = [NSString stringWithFormat:@"and 1=1"];
    NSString* urlString = [NSString stringWithFormat:@"<GetListByPage3 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<strWhere>%@</strWhere>\n"
                           "<orderby>MDate desc</orderby>\n"
                            "<startIndex>%ld</startIndex>\n"
                           "<endIndex>%ld</endIndex>\n"
                           "</GetListByPage3>\n",dateStr,(long)startIndex,(long)endIndex];
    CHJRequestUrl *request=[CHJRequest GetListByPage2:urlString soapUrl:@"GetListByPage3"];

    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        if (startIndex==1)
        {
            //[dataArray removeAllObjects];
        }
        NSString* request = (NSString*)result;
        [vc xxmlString:request];
        
    } failure:^(NSError *error){
        //numIndex=numIndex-10;
        //NSLog(@"失败");
    }];
    [operation startWithHUD:@"" inView:self.view];
}

- (void)xxmlString:(NSString *)xmlString
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
    dataArray = [NSMutableArray array];
    for (GDataXMLElement * note in ds)
    {
        Product* productModel = [Product meetingModelWithXml:note];
        [dataArray addObject:productModel];
    }
    
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //增删改本地日程后返回月历更新数据
    if (_tableTag == 0) {
        [_calendarView getData];
    } else if (_tableTag == 1) {
        [self addWeekTable];
    } else if (_tableTag == 2) {
        [self getDayData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _weekDate=[NSDate date];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _strWhere=@"";
    _dateStr = [self dateToString:[NSDate date] formatType:@"yyyy-MM-dd"];
    numIndex = 0;
    
    LoginViewController *login=[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];;
    __block MyViewController *vc=self;
    login.loginAction=^(id obj){
        dispatch_sync(dispatch_get_main_queue(), ^{
            tableMuDic = [NSMutableDictionary dictionary];
             [self addCalendarView];
        });
       
    };
    [self presentViewController:login animated:YES completion:nil];
    [vc initNavigationBar];
    
    //左滑快捷清单
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightViewMeun)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe];
    
    if (!_alertTable)
    {
        _alertTable=[alertTableView loadNib];
        _alertTable.center=CGPointMake(self.view.center.x, self.view.center.y-10);
        
        _alertTable.downAction=^(NSData *obj){
            
            _weekDate=obj;
            [vc navi];
            _strWhere=[NSString stringWithFormat:@"and T.MDate between %@",[self getMonthBeginAndEndWith:obj]];
            [vc getAllMeetingsBystartIndex:1 endIndext:50];
            [vc hideAlert];
        };
        _alertTable.cancelAction=^(id obj){
            [vc hideAlert];
        };
        [self.view addSubview:_alertTable];
        _alertTable.alpha=0;
    }
    
}

#pragma mark -addViews
- (void)addTableView
{
    if (!myTableView)
    {
        myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50)];
        myTableView.delegate=self;
        myTableView.dataSource=self;
        [myTableView addHeaderWithTarget:self action:@selector(headerRefresh)];
        [myTableView addFooterWithTarget:self action:@selector(footerRefresh)];
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:myTableView];
    } else
    {
        myTableView.hidden=NO;
    }
    _strWhere=@"and 1=1";
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"我的日程"] withAlignment:NavigationBarTitleViewAlignmentCenter];
}

//day
- (void)addDayTable
{
    if (!_dayViewControl)
    {
        _dayViewControl=[[DayTableViewController alloc]init];
        _dayViewControl.tableView.frame=CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50);
        
        __block MyViewController *vc = self;
        _dayViewControl.cellAction=^(id obj){
            [vc detailMessage:(Product*)obj];
        };
        [self.view addSubview:_dayViewControl.tableView];
    }
    else
    {
        _dayViewControl.tableView.hidden = NO;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    _dateStr =currentDateStr;
    [self getDayData];
    
    //日期选择
    datePicker = [[QNCustomDatePickerView alloc] initWithFrame:self.view.frame];
    [datePicker.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
    [datePicker.datePicker setDatePickerMode:UIDatePickerModeDate];
    datePicker.hidden = YES;
    [self.view addSubview:datePicker];
}

- (void)titleAction:(UITapGestureRecognizer *)tap
{
    __block MyViewController *vc=self;
    if (!_datePicker)
    {
        _datePicker =[[DateAndTimePickerViewController alloc]initWithNibName:@"DateAndTimePickerViewController" bundle:nil];
        
        _datePicker.view.frame=CGRectMake(0, Main_Screen_Height, Main_Screen_Width, Main_Screen_Height);
        
        _datePicker.dateAction=^(id obj){
            _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",obj];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *tmpDateStr = [self dateToString:[dateFormatter dateFromString:obj] formatType:@"yyyy-MM-dd"];
            _dateStr = tmpDateStr;
            vc.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@日程",_dateStr] withAlignment:NavigationBarTitleViewAlignmentCenter];
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleAction:)];
            [vc.navigationItem.titleView addGestureRecognizer:tap];
            _datePicker=nil;
            [vc getAllMeetingsBystartIndex:1 endIndext:10];
            
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
    _dateStr = dateString;
    [self getDayData];
}

- (void)getDayData
{
    _strWhere=[NSString stringWithFormat:@"and T.MDate='%@'",_dateStr];
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@日程",_dateStr] withAlignment:NavigationBarTitleViewAlignmentCenter];
    [self getAllMeetingsBystartIndex:1 endIndext:10];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDatePicker:)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
}

//week
- (void)addWeekTable
{
    __block MyViewController *vc=self;
    if (!_weekViewControl)
    {
        _weekViewControl=[[WeekTableViewController alloc]init];
        _weekViewControl.tableView.frame=CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50);
        _weekViewControl.cellAction=^(id obj){
            [vc detailMessage:obj];
        };
        [self.view addSubview:_weekViewControl.tableView];
    }
    else
    {
        _weekViewControl.tableView.hidden=NO;
    }
    
    _strWhere=[NSString stringWithFormat:@"and T.MDate between %@",[self getMonthBeginAndEndWith:_weekDate]];
    numIndex=50;
    [self getAllMeetingsBystartIndex:0 endIndext:numIndex];
    
    [self navi];
}

- (void)showAlert
{
    [self.view bringSubviewToFront:_alertTable];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _alertTable.alpha=1;
                         self.weekViewControl.tableView.userInteractionEnabled=NO;
                     }];
}

- (void)hideAlert
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _alertTable.alpha=0;
                         self.weekViewControl.tableView.userInteractionEnabled=YES;
                     }];
}

- (void)weekTitle:(UITapGestureRecognizer *)tap
{
    [self showAlert];
}

- (void)navi
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[self getWeekWithDate:_weekDate] withAlignment:NavigationBarTitleViewAlignmentCenter];
    [_alertTable setValueToView:[self getWeekFromDate] yearDate:currentDateStr];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(weekTitle:)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
}

- (NSString *)getWeekWithDate:(NSDate *)newDate
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
    
    //NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    //NSLog(@"%@",s);
    
    return [NSString stringWithFormat:@"%@至%@",beginString,endString];
}

- (NSString *)getWeekFromDate
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSYearCalendarUnit |
//    NSMonthCalendarUnit |
//    NSDayCalendarUnit |
//    NSWeekdayCalendarUnit |
//    NSHourCalendarUnit |
//    NSMinuteCalendarUnit |
//    NSSecondCalendarUnit;
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:date];
    NSInteger week = [comps week];
    
    return [NSString stringWithFormat:@"%ld",(long)week];
}

- (NSString *)dateToString:(NSDate *)date formatType:(NSString *)type
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

//month
- (void)addCalendarView
{
    __block MyViewController *vc=self;
    if (!_calendarView) {
        _calendarView=[CalendarView loadNib];
        [_calendarView setFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64-50)];
         _calendarView.type=1;
        [_calendarView initWith];
        _calendarView.dateAction=^(id obj){
           [vc detailMessage: (Product*)obj];
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
    [dateFormatter setDateFormat:@"yyyy年 MM月"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:[NSString stringWithFormat:@"%@",currentDateStr] withAlignment:NavigationBarTitleViewAlignmentCenter];
}

- (void)detailMessage:(Product *)model
{
    DetailsMeetingViewController* detailsVC = [[DetailsMeetingViewController alloc]init];
    detailsVC.product = model;
    [self.navigationController pushViewController:detailsVC animated:YES];
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
    
    //NSString *s = [NSString stringWithFormat:@"%@-%@",beginString,endString];
    //NSLog(@"%@",s);
    
    return [NSString stringWithFormat:@"'%@' and '%@'",beginString,endString];
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

-(void)headerRefresh
{
    //NSLog(@"下拉了");
    [self getAllMeetingsBystartIndex:0 endIndext:numIndex+10];
}
-(void)footerRefresh
{
    numIndex = numIndex+10;
    [self getAllMeetingsBystartIndex:0 endIndext:numIndex+10];
    //NSLog(@"上拉了"); // 下拉
}
- (void)initNavigationBar
{
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"我的日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
    
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withImage:@"morex" withHighlightImage:@"morex"];
    
    UIBarButtonItem *shareBtn=[CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(addThing) withImage:@"addx" withHighlightImage:@"addx"];
    [self.navigationItem setRightBarButtonItem:shareBtn];
    
}
-(void)leftMeun
{
    __block MyViewController *vc=self;
    AppDelegate *app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    app.LeftView.cellAction=^(id obj){
        //DLog(@"obj==%@",obj);
        [vc tableViewChooseed:obj];
        [app hidedLeftView];
    };
    if (app.LeftView.tag==0)
    {
        [CommonDefine saveStringToUserDefaults:[NSString stringWithFormat:@"%ld",(long)_tableTag] WithKey:@"index"];
        [app showLeftMenu];
    }
    else
    {
        [app hidedLeftView];
    }
}

- (void)rightViewMeun
{
    __block MyViewController *vc = self;
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    app.rightView.cellAction = ^(id obj){
        [vc detailMessage:obj];
        [app hidedRightView:0.01f];
    };
    if (app.rightView.tag == 0 && app.LeftView.tag == 0){
        [self getDayMeetingsBystartIndex:1 endIndext:100];
        //[app.rightView.dataSource addObjectsFromArray:dataArray];
        [app.rightView loadData:dataArray];
        if (dataArray) {
            [app showRightView];
        }
    }else if (app.rightView.tag == 1 && app.LeftView.tag == 0) {
        [app hidedRightView:0.26f];
    }
}


-(void)addThing
{
    //NSLog(@"添加日程");
    AddActivity_ViewController* addVC = [[AddActivity_ViewController alloc]init];
    //    addVC.title = @"增加我和日程";
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    MyActivityCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[MyActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell tableViewCellDict:tableMuDic reverseArray:peiXuArr Index:indexPath.row];
    
    //    [cell tableViewCellArray:tableMuArr Index:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return peiXuArr.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString* keyString = [peiXuArr objectAtIndex:indexPath.row];
    
    Product* product = [tableMuDic objectForKey:keyString];
    
    if ((BOOL)[product.MPersonal integerValue]) {
        
        //NSLog(@"自己添加的");
        
        AddActivity_ViewController* addVC = [[AddActivity_ViewController alloc]init];
        addVC.product = product;
        [self.navigationController pushViewController:addVC animated:YES];
    }else{
        DetailsMeetingViewController* detailsVC = [[DetailsMeetingViewController alloc]init];
        detailsVC.product = product;
        [self.navigationController pushViewController:detailsVC animated:YES];
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
