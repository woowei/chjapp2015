//
//  AddActivity ViewController.m
//  chjapp
//
//  Created by 启年信息 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "AddActivity ViewController.h"
#import "QNCustomDatePickerView.h"
#import "DetailsMeetingViewController.h"

@interface AddActivity_ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    QNCustomDatePickerView* datePicker;
    UITextField* textf;
    UITextView* textView;
    UILabel* textViewLab;
    
    UIButton* leftButt;
    UILabel* leftLab1;
    UILabel* leftLab2;
    
    
    UIButton* rightButt;
    UILabel* rightLab1;
    UILabel* rightLab2;
    
    
    NSString* mDate;
    NSString* beginTime;
    NSString* endTime;
    
    BOOL isRemind;
    
    NSMutableArray* addActivityMuArr;
}
@end

@implementation AddActivity_ViewController

@synthesize product;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    isRemind = (BOOL)[product.MPersonal integerValue];
    
    addActivityMuArr = [NSMutableArray arrayWithArray:[UserDefaults objectArrForKey:KEY_AddActivity]];
    //NSLog(@"%ld",addActivityMuArr.count);
    
    [self initNavigationBar];
    
    [self addTableView];
    
}


- (void)initNavigationBar
{
    //编辑事件
    if (product) {
        self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"编辑事件" withAlignment:NavigationBarTitleViewAlignmentCenter];
        self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withTitle:@"取消"];
        self.navigationItem.rightBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(rightSaveMeun) withTitle:@"完成"];
    } else {
        self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"增加我的日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
        self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withTitle:@"返回"];
        self.navigationItem.rightBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(rightMeun) withTitle:@"保存"];
    }
}

- (void)addTableView
{
    UITableView* myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setBackgroundColor:RGBCOLOR(220, 220, 220)];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [myTableView setTableFooterView:view];
    
    // 去掉保存button
    
    // [myTableView setTableFooterView:[self addTableFootView]];
    
    [self.view addSubview:myTableView];
    
    
    datePicker = [[QNCustomDatePickerView alloc]initWithFrame:self.view.frame];
    [datePicker.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.hidden = YES;
    [self.view addSubview:datePicker];
    
    if (product!=nil) {
        [self setAllViewiewText:product];
    }
    
}


- (void)setAllViewiewText:(Product*)model
{
    textf.text = model.MName;
    //leftLab1.text = [DateUtils stringFromMDate:model.MDate];
    //    leftLab2.text = str1;
    //    [leftButt setTitle:@"" forState:UIControlStateNormal];
    //
    //    rightLab1.text = str;
    //    rightLab2.text = str1;
    //    [rightButt setTitle:@"" forState:UIControlStateNormal];
}

- (UIView*)addTableFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200)];
    
    UIButton* footButt = [UIButton buttonWithType:UIButtonTypeCustom];
    [footButt setFrame:CGRectMake(0, 0, 210, 40)];
    [footButt setCenter:CGPointMake(footView.frame.size.width/2, 40)];
    [footButt setBackgroundImage:[UIImage imageNamed:@"savebtn.png"] forState:UIControlStateNormal];
    [footButt setBackgroundImage:[UIImage imageNamed:@"savebtnx.png"] forState:UIControlStateHighlighted];
    [footButt addTarget:self action:@selector(footButt:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:footButt];
    
    return footView;
    
}


- (void)rightMeun
{
    [self saveData];
}

//编辑事件时保存返回到详情
- (void)rightSaveMeun
{
    [self updateData];
}

- (void)leftMeun
{
    if (!product) {
        [SVProgressHUD showErrorWithStatus:@"已取消"];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView* leftimg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 22-9, 18, 18)];
        [cell.contentView addSubview:leftimg];
        
        switch (indexPath.section) {
            case 0:{
                textf = [[UITextField alloc]initWithFrame:CGRectMake(40, 8, Main_Screen_Width-50, 30)];
                textf.placeholder = @"事件名称";
                textf.text = product.MName?product.MName:@"";
                [cell.contentView addSubview:textf];
                
                [leftimg setImage:[UIImage imageNamed:@"thingicon.png"]];
            }
                break;
            case 1:{
                leftButt = [UIButton buttonWithType:UIButtonTypeCustom];
                [leftButt setFrame:CGRectMake(40, 0, (Main_Screen_Width-90)/2, 44)];
                [leftButt setTitle:product.MDate?@"":@"开始时间" forState:UIControlStateNormal];
                [leftButt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [leftButt addTarget:self action:@selector(leftbutt:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:leftButt];
                
                leftLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftButt.frame.size.width, leftButt.frame.size.height/2)];
                [leftLab1 setText:product.MDate?[DateUtils stringFromMDate:product.MDate]:@""];
                leftLab1.font = [UIFont systemFontOfSize:12];
                [leftButt addSubview:leftLab1];
                mDate =product.MDate?product.MDate:@"";
                
                
                
                leftLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, leftButt.frame.size.height/2, leftButt.frame.size.width, leftButt.frame.size.height/2)];
                [leftLab2 setText:product.MSTIme?[DateUtils stringFromMTime:product.MSTIme]:@""];
                leftLab2.font = [UIFont systemFontOfSize:12];
                [leftButt addSubview:leftLab2];
                beginTime = product.MSTIme?product.MSTIme:@"";
                
                UIImageView * zhongimag = [[UIImageView alloc]initWithFrame:CGRectMake(leftButt.frame.origin.x+leftButt.frame.size.width+10, 8, 15, 28)];
                [zhongimag setImage:[UIImage imageNamed:@"timerarrow.png"]];
                [cell.contentView addSubview:zhongimag];
                
                rightButt = [UIButton buttonWithType:UIButtonTypeCustom];
                [rightButt setFrame:CGRectMake(zhongimag.frame.origin.x+zhongimag.frame.size.width+10, 0, (Main_Screen_Width-90)/2, 44)];
                //                [rightButt setBackgroundColor:[UIColor yellowColor]];
                [rightButt setTitle:product.MDate?@"":@"结束时间" forState:UIControlStateNormal];
                [rightButt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [rightButt addTarget:self action:@selector(rightButt:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:rightButt];
                
                rightLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rightButt.frame.size.width, rightButt.frame.size.height/2)];
                [rightLab1 setText:product.MDate?[DateUtils stringFromMDate:product.MDate]:@""];
                rightLab1.font = [UIFont systemFontOfSize:12];
                [rightButt addSubview:rightLab1];
                
                
                rightLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, rightButt.frame.size.height/2, rightButt.frame.size.width, rightButt.frame.size.height/2)];
                [rightLab2 setText:product.METime?[DateUtils stringFromMTime:product.METime]:@""];
                rightLab2.font = [UIFont systemFontOfSize:12];
                [rightButt addSubview:rightLab2];
                [leftimg setImage:[UIImage imageNamed:@"timeicon.png"]];
                endTime =product.METime?product.METime:@"";
                //NSLog(@"222 ==%@",endTime);
            }
                break;
            case 2:{
                textView = [[UITextView alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width-50, 80)];
                [textView setBackgroundColor:[UIColor clearColor]];
                textView.delegate = self;
                [cell.contentView addSubview:textView];
                
                
                textViewLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, textView.frame.size.width - 20, 20)];
                textViewLab.text = product.MNote?@"":@"添加备注";
                textViewLab.textColor = [UIColor lightGrayColor];
                [textView addSubview:textViewLab];
                [leftimg setImage:[UIImage imageNamed:@"personiconww.png"]];
                
                textView.text = product.MNote?product.MNote:@"";
                
                
            }
                break;
            case 3:
                if (indexPath.row == 0) {
                    
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"个人安排";
                    label.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:label];
                    
                    [leftimg setImage:[UIImage imageNamed:@"personicongreen.png"]];
                    
                }else{
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"闹铃设置";
                    label.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:label];
                    
                    
                    UILabel* rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(160, 5, 60, 30)];
                    rightLabel.text = @"默认设置";
                    rightLabel.font = [UIFont systemFontOfSize:12];
                    rightLabel.textColor = [UIColor lightGrayColor];
                    [cell.contentView addSubview:rightLabel];
                    
                    NSString* buttimage = isRemind?@"switch-on.png":@"switch-off.png";
                    UIButton* setButt = [UIButton buttonWithType:UIButtonTypeCustom];
                    [setButt setBackgroundImage:[UIImage imageNamed:buttimage] forState:UIControlStateNormal];
                    [setButt addTarget:self action:@selector(setButt:) forControlEvents:UIControlEventTouchUpInside];
                    [setButt setFrame:CGRectMake(Main_Screen_Width - 80, 7, 70, 30)];
                    [cell.contentView addSubview:setButt];
                    //                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    
                    [leftimg setImage:[UIImage imageNamed:@"alarmicon.png"]];
                    
                    
                }
                
                break;
                
            default:
                break;
        }
        
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section ==3) {
        return 2;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return 90;
    }else{
        return 44;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



- (void)leftbutt:(UIButton*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    //NSLog(@"左");
    datePicker.hidden = NO;
    datePicker.datePicker.tag = 10;
    
    NSDate *laterDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:laterDate];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [timeFormatter stringFromDate:laterDate];
    
    leftLab1.text = dateStr;
    leftLab2.text = timeStr;
    [leftButt setTitle:@"" forState:UIControlStateNormal];
    
    mDate = [dateFormatter stringFromDate:laterDate];
    
    beginTime = [self setTimeString:[timeFormatter stringFromDate:laterDate]];
}

- (void)rightButt:(UIButton*)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

    //NSLog(@"右");
    datePicker.hidden = NO;
    datePicker.datePicker.tag = 20;
    
    NSDate *laterDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:laterDate];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [timeFormatter stringFromDate:laterDate];
    
    rightLab1.text = dateStr;
    rightLab2.text = timeStr;
    [rightButt setTitle:@"" forState:UIControlStateNormal];
    
    endTime = [self setTimeString:[timeFormatter stringFromDate:laterDate]];
}

-(void)dateChanged:(UIDatePicker *)sender
{
    //比较，选取时间
    NSDate *laterDate = [sender.date laterDate:[NSDate date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:laterDate];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [timeFormatter stringFromDate:laterDate];
    
    if (sender.tag == 10) {
        leftLab1.text = dateStr;
        leftLab2.text = timeStr;
        [leftButt setTitle:@"" forState:UIControlStateNormal];
        
        mDate = [dateFormatter stringFromDate:laterDate];
        
        beginTime = [self setTimeString:[timeFormatter stringFromDate:laterDate]];
        
    }else if (sender.tag == 20){
        rightLab1.text = dateStr;
        rightLab2.text = timeStr;
        [rightButt setTitle:@"" forState:UIControlStateNormal];
        
        endTime = [self setTimeString:[timeFormatter stringFromDate:laterDate]];
        
    }
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textViewLab.text = @"";
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length == 0) {
        textViewLab.text = @"添加备注";
    }
}


- (void)setButt:(UIButton*)sender
{
    isRemind = !isRemind;
    
    NSString* buttimage = isRemind?@"switch-on.png":@"switch-off.png";
    [sender setBackgroundImage:[UIImage imageNamed:buttimage] forState:UIControlStateNormal];
    
}
-(void)saveData{
    
    if (textf.text == nil||[textf.text isEqualToString:@""]) {
        
         [SVProgressHUD showErrorWithStatus:@"请输入事件名称"];
     //   [self addAlertView:@"请输入事件名称"];
    }else if (leftLab1.text.length==0){
        
        [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
       // [self addAlertView:@"请选择开始时间"];
    }else if (rightLab1.text.length==0){
        
        [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
        //[self addAlertView:@"请选择结束时间"];
    }
    //    else if (textView.text == nil||[textView.text isEqualToString:@""]){
    //        [self addAlertView:@"请添加备注"];
    //    }
    else{
        if (textView.text == nil) {
            textView.text = @"";
        }
        
        NSMutableDictionary* muDic = [NSMutableDictionary dictionary];
        [muDic setObject:textf.text forKey:@"MName"];  //textf.text
        [muDic setObject:mDate forKey:@"MDate"];   // 会议日期
        [muDic setObject:beginTime forKey:@"MSTIme"];  // 会议开始时间
        [muDic setObject:endTime forKey:@"METime"];  // 会议结束时间
        [muDic setObject:textView.text forKey:@"MNote"]; // 会议备注
        [muDic setObject:isRemind?@"1":@"0" forKey:@"MRemind"];// 设置闹钟
        [muDic setObject:@"1" forKey:@"MPersonal"];// 个人添加
        
        [muDic setObject:[DateUtils stringFromDate:[NSDate date] withFormatter:@"yyyyMMddHHMMss"] forKey:@"MIdentifier"];//  唯一标识符
        
        
//        if (product!=nil) {
//            [self removeObjectFromArray:product];
//        }
        
        [addActivityMuArr addObject:muDic];
        NSString* jsonStr = [self toJSONData:addActivityMuArr];
        [UserDefaults setObject:jsonStr forKey:KEY_AddActivity];
        //NSLog(@"%@",jsonStr);
        
        if (isRemind) {
            [self notificationDate:mDate timeStr:beginTime Mname:textf.text];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }

    
}

- (void)updateData
{
    if (textf.text == nil||[textf.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请输入事件名称"];
    }else if (leftLab1.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
    }else if (rightLab1.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
    }
    
    else {
    
        product.MName = textf.text;
        product.MDate = mDate;
        product.MSTIme = beginTime;
        product.METime = endTime;
        product.MNote = textView.text;
        product.MRemind = isRemind ? @"1" : @"0";
        
        if (textView.text == nil) {
            textView.text = @"";
        }
        
        //判断开始时间和结束时间的先后
        NSString *beginStr = [DateUtils stringFromMTime:beginTime];
        NSString *endStr = [DateUtils stringFromMTime:endTime];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        
        NSDate *beginDate = [dateFormatter dateFromString:beginStr];
        NSDate *endDate = [dateFormatter dateFromString:endStr];
        
        if ([[endDate earlierDate:beginDate] isEqualToDate:endDate]) {
            [self changeTimeFontColor:[UIColor redColor]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"开始时间必须早于结束时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        } else {
            [self changeTimeFontColor:[UIColor blackColor]];
            //修改后的数据保存
            NSMutableDictionary* muDic = [NSMutableDictionary dictionary];
            [muDic setObject:textf.text forKey:@"MName"];  //textf.text
            [muDic setObject:mDate forKey:@"MDate"];   // 会议日期
            [muDic setObject:beginTime forKey:@"MSTIme"];  // 会议开始时间
            [muDic setObject:endTime forKey:@"METime"];  // 会议结束时间
            [muDic setObject:textView.text forKey:@"MNote"]; // 会议备注
            [muDic setObject:isRemind?@"1":@"0" forKey:@"MRemind"];// 设置闹钟
            [muDic setObject:@"1" forKey:@"MPersonal"];// 个人添加
            
            [muDic setObject:product.MIdentifier forKey:@"MIdentifier"];//  唯一标识符
            
            if (product!=nil) {
                [self removeObjectFromArray:product];
            }
            
            [addActivityMuArr addObject:muDic];
            NSString* jsonStr = [self toJSONData:addActivityMuArr];
            [UserDefaults setObject:jsonStr forKey:KEY_AddActivity];
            //NSLog(@"%@",jsonStr);
            
            if (isRemind) {
                [self notificationDate:mDate timeStr:beginTime Mname:textf.text];
            }
            
            DetailsMeetingViewController *dmvc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
            dmvc.product = nil;
            dmvc.product = self.product;
            [self.navigationController popToViewController:dmvc animated:YES];
        }
    }
    
}

- (void)changeTimeFontColor:(UIColor*)color
{
    leftLab1.textColor = color;
    leftLab2.textColor = color;
    rightLab1.textColor = color;
    rightLab2.textColor = color;
    
}

- (void)footButt:(UIButton*)sender
{
    if (textf.text == nil||[textf.text isEqualToString:@""]) {
        [self addAlertView:@"请输入事件名称"];
    }else if (leftLab1.text.length==0){
        [self addAlertView:@"请选择开始时间"];
    }else if (rightLab1.text.length==0){
        [self addAlertView:@"请选择结束时间"];
    }
//    else if (textView.text == nil||[textView.text isEqualToString:@""]){
//        [self addAlertView:@"请添加备注"];
//    }
    else{
        if (textView.text == nil) {
            textView.text = @"";
        }
        
        NSMutableDictionary* muDic = [NSMutableDictionary dictionary];
        [muDic setObject:textf.text forKey:@"MName"];  //textf.text
        [muDic setObject:mDate forKey:@"MDate"];   // 会议日期
        [muDic setObject:beginTime forKey:@"MSTIme"];  // 会议开始时间
        [muDic setObject:endTime forKey:@"METime"];  // 会议结束时间
        [muDic setObject:textView.text forKey:@"MNote"]; // 会议备注
        [muDic setObject:isRemind?@"1":@"0" forKey:@"MRemind"];// 设置闹钟
        [muDic setObject:@"1" forKey:@"MPersonal"];// 个人添加
        
        [muDic setObject:[DateUtils stringFromDate:[NSDate date] withFormatter:@"yyyyMMddHHMMss"] forKey:@"MIdentifier"];//  唯一标识符
        
        
        if (product!=nil) {
            [self removeObjectFromArray:product];
        }
        
        [addActivityMuArr addObject:muDic];
        NSString* jsonStr = [self toJSONData:addActivityMuArr];
        [UserDefaults setObject:jsonStr forKey:KEY_AddActivity];
        
        if (isRemind) {
            [self notificationDate:mDate timeStr:beginTime Mname:textf.text];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)notificationDate:(NSString*)DateStr timeStr:(NSString*)timeStr Mname:(NSString*)nameStr
{
    
    //    2014-11-25 22:23:06.296 chjapp[6576:1408716] DateStr == 2014-11-25
    //    2014-11-25 22:23:07.619 chjapp[6576:1408716] timeStr == PT22H28M
    //    2014-11-25 22:23:09.486 chjapp[6576:1408716] nameStr == 在聊啊
    
//    NSLog(@"DateStr == %@",DateStr);
//    NSLog(@"timeStr == %@",[DateUtils stringFromMTime:timeStr]);
//    NSLog(@"nameStr == %@",nameStr);
    
    NSDate* date = [DateUtils dateFromTimeString:[NSString stringWithFormat:@"%@ %@",DateStr,[DateUtils stringFromMTime:timeStr]]];
    
    //NSLog(@"%@, == %@",date, [NSDate date]);
    [NotificationUtils setNotificationDate:date alertBody:nameStr];
}


- (NSString *)toJSONData:(NSMutableArray*)theArr{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}

- (NSString*)setTimeString:(NSString*)string
{
    NSString* str = [NSString stringWithFormat:@"PT%@M",string];
    NSString *timeStr = [str stringByReplacingOccurrencesOfString:@":" withString:@"H"];
    return timeStr;
}


- (void)removeObjectFromArray:(Product*)prod
{
    
    //    NSMutableArray* array = [NSMutableArray arrayWithArray:[UserDefaults objectArrForKey:KEY_AddActivity]];
    
//    for (NSMutableDictionary* dict in addActivityMuArr) {
//        if ([[dict objectForKey:@"MIdentifier"] isEqualToString:prod.MIdentifier]) {
//            [addActivityMuArr removeObject:dict];
//            return;
//        }
//    }
    
    for (int i = 0; i < addActivityMuArr.count; i++) {
        NSMutableDictionary *dict = [addActivityMuArr objectAtIndex:i];
        if ([[dict objectForKey:@"MIdentifier"] isEqualToString:prod.MIdentifier]) {
            [addActivityMuArr removeObject:dict];
            return;
        }
    }
}


- (NSString*)weekdayFromDate:(NSString*)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    //    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
    
    NSString *timeString = [NSString stringWithFormat:@"%d-%d-%d 周%@",[components year],[components month], [components day],[self weekDay:[components weekday]]];
    //NSLog(@"timeString:%@",timeString);
    
    return timeString;
}


- (NSString*)weekDay:(int)day
{
    NSString*  weekStr;
    if (day == 1) {
        weekStr = @"日";
    }else if (day ==2){
        weekStr = @"一";
    }else if (day ==3){
        weekStr = @"二";
    }else if (day ==4){
        weekStr = @"三";
    }else if (day ==5){
        weekStr = @"四";
    }else if (day ==6){
        weekStr = @"五";
    }else if (day ==7){
        weekStr = @"六";
    }
    
    return weekStr;
    
}

- (void)addAlertView:(NSString*)string
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
