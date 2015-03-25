//
//  DetailsMeetingViewController.m
//  chjapp
//
//  Created by 启年信息 on 14-11-15.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "DetailsMeetingViewController.h"
#import "AddActivity ViewController.h"

@interface DetailsMeetingViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //    QNCustomDatePickerView* datePicker;
    UITextField* textf;
    
    UIButton* leftButt;
    UILabel* leftLab1;
    UILabel* leftLab2;
    
    
    UIButton* rightButt;
    UILabel* rightLab1;
    UILabel* rightLab2;
    
    BOOL isRemind;
    
}
@end

@implementation DetailsMeetingViewController

@synthesize product;

- (void)viewWillAppear:(BOOL)animated
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initNavigationBar];
    [self addTableView];
    if (product.MID.length == 0) {
        //NSLog(@"Do Nothing");
        
    }else{
        isRemind = (BOOL)[[NSUserDefaults standardUserDefaults] objectForKey:product.MID];
    }

    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self addTableView];
    //  isRemind = (BOOL)[[NSUserDefaults standardUserDefaults] objectForKey:product.MID];
    //    [self datestring];
}


- (void)initNavigationBar
{
    if(product.MPeople){
        self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"会议详情"withAlignment:NavigationBarTitleViewAlignmentCenter];
    }else{
        self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"我的日程"withAlignment:NavigationBarTitleViewAlignmentCenter];
        self.navigationItem.rightBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(rightMeun) withTitle:@"编辑"];
    }
    
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(leftMeun) withTitle:@"返回"];
    
}

- (void)addTableView
{
    UITableView* myTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height-64)];
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [myTableView setBackgroundColor:RGBCOLOR(220, 220, 220)];
    if (product.MPeople) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor clearColor];
        [myTableView setTableFooterView:view];
    }else {
        [myTableView setTableFooterView:[self addTableFootView]];
    }
    [self.view addSubview:myTableView];
    
}


- (UIView*)addTableFootView
{
    UIView* footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 80)];
    
    UIButton* footButt = [UIButton buttonWithType:UIButtonTypeCustom];
    [footButt setFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    [footButt setCenter:CGPointMake(footView.frame.size.width/2, 40)];
    //[footButt setBackgroundImage:[UIImage imageNamed:@"savebtn.png"] forState:UIControlStateNormal];
    //[footButt setBackgroundImage:[UIImage imageNamed:@"savebtnx.png"] forState:UIControlStateHighlighted];
    [footButt setBackgroundColor:[UIColor whiteColor]];
    [footButt setTitle:@"删除日程" forState:UIControlStateNormal];
    [footButt setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [footButt addTarget:self action:@selector(deleteMyActivity:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:footButt];
    
    return footView;
    
}


- (void)leftMeun
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightMeun
{
    AddActivity_ViewController *aavc = [[AddActivity_ViewController alloc] init];
    aavc.product = self.product;
    [self.navigationController pushViewController:aavc animated:YES];
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
        
        
        
        
        //        cell setBackgroundColor:[UIColor ]
        switch (indexPath.section) {
            case 0:{
                UILabel* textL = [[UILabel alloc]initWithFrame:CGRectMake(40, 8, Main_Screen_Width-50, 30)];
                //textL.backgroundColor = [UIColor blueColor];
                textL.text = [NSString stringWithFormat:@"%@",product.MName];
                [cell.contentView addSubview:textL];
                textL.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:16];
                [leftimg setImage:[UIImage imageNamed:@"thingicon.png"]];
                
                
            }
                break;
            case 1:{
                leftButt = [UIButton buttonWithType:UIButtonTypeCustom];
                [leftButt setFrame:CGRectMake(40, 0, (Main_Screen_Width-90)/2, 44)];
                //               [leftButt setBackgroundColor:[UIColor yellowColor]];
                //                [leftButt setTitle:@"开始时间" forState:UIControlStateNormal];
                [leftButt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                //                [leftButt addTarget:self action:@selector(leftbutt:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:leftButt];
                
                leftLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, leftButt.frame.size.width, leftButt.frame.size.height/2)];
                [leftLab1 setText:[NSString stringWithFormat:@"%@",[DateUtils stringFromMDate:product.MDate]]];
                leftLab1.font = [UIFont systemFontOfSize:12];
                [leftButt addSubview:leftLab1];
                
                leftLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, leftButt.frame.size.height/2, leftButt.frame.size.width, leftButt.frame.size.height/2)];
                [leftLab2 setText:[NSString stringWithFormat:@"%@",[DateUtils stringFromMTime:product.MSTIme]]];
                leftLab2.font = [UIFont systemFontOfSize:12];
                [leftButt addSubview:leftLab2];
                
                UIImageView * zhongimag = [[UIImageView alloc]initWithFrame:CGRectMake(leftButt.frame.origin.x+leftButt.frame.size.width+10, 8, 15, 28)];
                [zhongimag setImage:[UIImage imageNamed:@"timerarrow.png"]];
                [cell.contentView addSubview:zhongimag];
                
                rightButt = [UIButton buttonWithType:UIButtonTypeCustom];
                [rightButt setFrame:CGRectMake(zhongimag.frame.origin.x+zhongimag.frame.size.width+10, 0, (Main_Screen_Width-90)/2, 44)];
                //                [rightButt setBackgroundColor:[UIColor yellowColor]];
                //                [rightButt setTitle:@"结束时间" forState:UIControlStateNormal];
                [rightButt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                //                [rightButt addTarget:self action:@selector(rightButt:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:rightButt];
                
                rightLab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, rightButt.frame.size.width, rightButt.frame.size.height/2)];
                [rightLab1 setText:[NSString stringWithFormat:@"%@",[DateUtils stringFromMDate:product.MDate]]];
                rightLab1.font = [UIFont systemFontOfSize:12];
                [rightButt addSubview:rightLab1];
                
                rightLab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, rightButt.frame.size.height/2, rightButt.frame.size.width, rightButt.frame.size.height/2)];
                [rightLab2 setText:[NSString stringWithFormat:@"%@",product.METime?[DateUtils stringFromMTime:product.METime]:@""]];
                rightLab2.font = [UIFont systemFontOfSize:12];
                [rightButt addSubview:rightLab2];
                
                
                
                [leftimg setImage:[UIImage imageNamed:@"timeicon.png"]];
                
            }
                break;
            case 2:{
                
                UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                //                label.textColor = [UIColor lightGrayColor];
                [cell.contentView addSubview:label];
                if (indexPath.row == 0 && product.MPeople) {
                    label.text = [NSString stringWithFormat:@"参与人及部门:%@ %@ %@",product.MPeople,product.Other1,product.Other2]; //Other1 Other2
                    label.font = [UIFont fontWithName:@"Arial" size:14.0];
                    label.numberOfLines =0;
                    label.lineBreakMode = NSLineBreakByWordWrapping;
                    [label setBackgroundColor:[UIColor whiteColor]];
                    CGSize strSize = [label.text sizeWithFont:[UIFont fontWithName:@"Arial" size:14.0] constrainedToSize:CGSizeMake(Main_Screen_Width - 50, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
                    [label setFrame:CGRectMake(40, 5,  Main_Screen_Width - 50, strSize.height)];
                    
                    
                    [leftimg setImage:[UIImage imageNamed:@"personiconww.png"]];
                }else if (indexPath.row ==1 && product.MLinkMan){
                    label.text = [NSString stringWithFormat:@"会议联系人:%@",product.MLinkMan];
                    label.font = [UIFont systemFontOfSize:14];
                    [leftimg setImage:[UIImage imageNamed:@"thingicon.png"]];
                }else if (indexPath.row ==2 && product.MWhere){
                    label.text = [NSString stringWithFormat:@"会议地点:%@",product.MWhere];
                    label.font = [UIFont systemFontOfSize:14];
                    [leftimg setImage:[UIImage imageNamed:@"roomiconxx.png"]];
                }else if (indexPath.row == 0 && !product.MPeople) {
                    label.text = [NSString stringWithFormat:@"备注:%@",product.MNote];
                    label.font = [UIFont systemFontOfSize:14];
                    [leftimg setImage:[UIImage imageNamed:@"thingicon.png"]];
                }
                
                
            }
                break;
            case 3:
                if (indexPath.row == 0 && product.MPeople) {
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"公司工作安排";
                    label.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:label];
                    label.font = [UIFont systemFontOfSize:14];
                    [leftimg setImage:[UIImage imageNamed:@"companyicongray.png"]];
                    
                }else if(indexPath.row == 1 ){
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"闹铃设置";
                    label.font = [UIFont systemFontOfSize:14];
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
                    
                }else if(indexPath.row == 0 && !product.MPeople){
                    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, Main_Screen_Width - 50, 30)];
                    label.text = @"个人安排";
                    label.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:label];
                    label.font = [UIFont systemFontOfSize:14];
                    [leftimg setImage:[UIImage imageNamed:@"personicongreen.png"]];
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
    if (section ==2) {
        return 3;
    }else if (section ==3) {
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
    if (indexPath.section == 2&&indexPath.row ==0) {
        NSString* string = [NSString stringWithFormat:@"参与人及部门:%@ %@ %@",product.MPeople,product.Other1,product.Other2];
        CGSize strSize = [string sizeWithFont:[UIFont fontWithName:@"Arial" size:14.0] constrainedToSize:CGSizeMake(Main_Screen_Width - 50, 20000.0f) lineBreakMode:NSLineBreakByWordWrapping];
        
        //NSLog(@"string == %@",string);
        if (strSize.height<44) {
            return 44;
        }else{
            return strSize.height+10;
            
        }
    }else{
        return 44;
    }
}

- (void)footButt:(UIButton*)sender
{
    if (isRemind) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:product.MID];
        [self notificationDate:[DateUtils stringFromMDate:product.MDate] timeStr:product.MSTIme Mname:product.MName];
        
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:product.MID];
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteMyActivity:(UIButton*)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"删除"
                                  otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[UserDefaults objectArrForKey:KEY_AddActivity]];
        
        for (int i = 0; i< tempArray.count; i++) {
            NSMutableDictionary *dict = [tempArray objectAtIndex:i];
            if ([[dict objectForKey:@"MIdentifier"] isEqualToString:product.MIdentifier]) {
                [tempArray removeObject:dict];
            }
        }
        NSString* jsonStr = [self toJSONData:tempArray];
        [UserDefaults setObject:jsonStr forKey:KEY_AddActivity];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if (buttonIndex == 1) {
        //NSLog(@"取消");
    }
}

- (NSString *)toJSONData:(NSMutableArray*)theArr{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
    
}

- (void)setButt:(UIButton*)sender
{
    isRemind = !isRemind;
    
    NSString* buttimage = isRemind?@"switch-on.png":@"switch-off.png";
    [sender setBackgroundImage:[UIImage imageNamed:buttimage] forState:UIControlStateNormal];
    
}


- (NSString*)weekdayFromDate:(NSString*)dateSteing
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateSteing];
    
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

- (void)notificationDate:(NSString*)DateStr timeStr:(NSString*)timeStr Mname:(NSString*)nameStr
{
    //    NSLog(@"DateStr == %@",DateStr);
    //    NSLog(@"timeStr == %@",[DateUtils stringFromMTime:timeStr]);
    //    NSLog(@"nameStr == %@",nameStr);
    
    NSDate* date = [DateUtils dateFromTimeString:[NSString stringWithFormat:@"%@ %@",DateStr,[DateUtils stringFromMTime:timeStr]]];
    
    //NSLog(@"%@, == %@",date, [NSDate date]);
    [NotificationUtils setNotificationDate:date alertBody:nameStr];
}


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
