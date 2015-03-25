//
//  SetAlock_ViewController.m
//  chjapp
//
//  Created by susu on 14-11-27.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "SetAlock_ViewController.h"

@interface SetAlock_ViewController ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,AVAudioPlayerDelegate>
{
    NSArray * nameArr;
    NSMutableArray *imageArr;
    NSString * time;
    UIView *lockView ;
    UITableView *lockTableView;
    NSArray *lockArr;
    int lockFlag;
    NSMutableArray *roundArr;
    UILabel *musicLable;
    SystemSoundID soundID;
    AVAudioPlayer *_player;
    UISwitch * swLock;
    UISwitch * swZhendong;
}

@end

@implementation SetAlock_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
    self.navigationItem.title = @"闹铃选项";
    nameArr = [[NSArray alloc] initWithObjects:@"事件闹钟提前提醒",@"全天事件提醒时间",@"全天事件提醒闹钟",@"铃声提醒",@"振动提醒", nil];
    imageArr = [[NSMutableArray alloc] init];
    roundArr = [[NSMutableArray alloc] init];
    time = @"8:00 AM";
    lockArr = [[NSArray alloc] initWithObjects:@"短信01",@"短信02",@"短信03",@"短信04",@"短信05",@"短信06",@"短信07",@"短信08",@"短信09",@"短信10",@"短信11",@"短信12", nil];
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"lockFlag"];
    lockFlag  = [str intValue];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height -64-49)style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.tag = 0;
    [self.view addSubview:self.tableView];
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initView
{
    lockView  = [[UIView alloc] initWithFrame:CGRectMake(10,66, Main_Screen_Width-20, Main_Screen_Height-64-53)];
    lockView.backgroundColor = [UIColor colorWithRed:31/255. green:31/255. blue:31/255. alpha:1.];
    
    UILabel *l =[[UILabel alloc] initWithFrame:CGRectMake(10,5, lockView.frame.size.width-20, 30)];
    l.text = @"设置会议提醒铃声";
    l.font = [UIFont systemFontOfSize:16.];
    l.textColor = [UIColor colorWithRed:46/255. green:167/255. blue:184/255. alpha:1.];
    [lockView addSubview:l];
    
    lockTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, lockView.frame.size.width,lockView.frame.size.height -110)style:UITableViewStylePlain];
    lockTableView.tag = 1 ;
    lockTableView.delegate = self;
    lockTableView.dataSource = self;
    lockTableView.backgroundColor = [UIColor clearColor];
    [lockTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [lockView addSubview:lockTableView];
    // 底部 确定 和取消 按钮
    
    UIButton *left =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [left setFrame:CGRectMake(lockView.frame.size.width/2-140,lockView.frame.size.height-50,120,40)];
    [left setTitle:@"取消" forState:UIControlStateNormal];
    [left setTitle:@"取消" forState:UIControlStateSelected];
    [left setBackgroundColor:[UIColor colorWithRed:70/255. green:70/255. blue:70/255. alpha:1.]];
    [left setTintColor:[UIColor whiteColor]];
    left.tag = 101;
    [left.layer setCornerRadius:11.0];
    left.titleLabel.font = [UIFont systemFontOfSize:14.];
    [left addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [lockView addSubview:left];
    
    
    UIButton *commit =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [commit setFrame:CGRectMake(lockView.frame.size.width/2+10,lockView.frame.size.height -50,120,40)];
    [commit setTitle:@"确定" forState:UIControlStateNormal];
    [commit setTitle:@"确定" forState:UIControlStateSelected];
    [commit setBackgroundColor:[UIColor colorWithRed:70/255. green:70/255. blue:70/255. alpha:1.]];
    [commit setTintColor:[UIColor whiteColor]];
    [commit.layer setCornerRadius:11.0];
    commit.tag =102;
    commit.titleLabel.font = [UIFont systemFontOfSize:14.];
    [commit addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
    [lockView addSubview:commit];
    
    
}
-(void)choose:(UIButton *)sender
{
    if (sender.tag ==101) {
        
    }else if(sender.tag ==102)
    {
        [_player pause];
        [_player stop];
        _player=nil;
        [[NSUserDefaults standardUserDefaults] setObject:[lockArr objectAtIndex:lockFlag] forKey:@"ring"];
        musicLable.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ring"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",lockFlag] forKey:@"lockFlag"];

    }
    [lockView removeFromSuperview];
}

#pragma mark - play


-(void)viewWillDisappear:(BOOL)animated
{
    [_player pause];
    [_player stop];
    _player=nil;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag ==0) {
        return 3;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag ==0) {
        if (section ==0) {
            return 1;
        }
        return 2;
    }
    return lockArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tableSampleIdentifier = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    else
    {
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    if (tableView.tag ==0) {
        
        switch (indexPath.section) {
            case 0:
            {
                UISwitch *switchButton1 = [[UISwitch alloc] initWithFrame:CGRectMake(Main_Screen_Width-60, 5, 40, 30)];
                [switchButton1 setOn:NO];
                switchButton1.tag =1;
                [switchButton1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:switchButton1];

                cell.textLabel.text = [nameArr objectAtIndex:indexPath.row];
                NSString * str0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"oneTime"];
                if ([str0 intValue]) {
                  [switchButton1 setOn:YES];
                }
            }
                break;
            case 1:
            {
                time = [[NSUserDefaults standardUserDefaults] objectForKey:@"oneDayOnceTime"];
                cell.textLabel.text = [nameArr objectAtIndex:(indexPath.row + 1)];
                if (indexPath.row ==0) {///显示时间
                    UILabel * blueLable = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 5, 100, 30) ];
                    blueLable.textAlignment = NSTextAlignmentRight;
                    blueLable.text = time;
                    blueLable.textColor = [UIColor blueColor];
                    [cell.contentView addSubview:blueLable];
                }else
                {
                    UISwitch *switchButton2 = [[UISwitch alloc] initWithFrame:CGRectMake(Main_Screen_Width-60, 5, 40, 30)];
                    [switchButton2 setOn:NO];
                    switchButton2.tag =2;
                    [switchButton2 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                    [cell.contentView addSubview:switchButton2];
                    NSString * str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"allDay"];
                    if ([str1 intValue]) {
                        if (indexPath.row ==1) {
                            [switchButton2 setOn:YES];
                        }
                    }
                }
            }
                break;
                
            case 2:
            {
                //铃音提醒
                if (indexPath.row ==0) {
                    swLock = [[UISwitch alloc] initWithFrame:CGRectMake(Main_Screen_Width-60, 5, 40, 30)];
                    [swLock setOn:NO];
                    swLock.tag =3+indexPath.row;
                    [swLock addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                    [cell.contentView addSubview:swLock];

                    musicLable = [[UILabel alloc] initWithFrame:CGRectMake(Main_Screen_Width/2+30, 5, Main_Screen_Width/2 -70 , 30)];
                    musicLable.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ring"];
                    [cell.contentView addSubview:musicLable];
                }
                else
                {
                    swZhendong = [[UISwitch alloc] initWithFrame:CGRectMake(Main_Screen_Width-60, 5, 40, 30)];
                    [swZhendong setOn:NO];
                    swZhendong.tag =3+indexPath.row;
                    [swZhendong addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
                    [cell.contentView addSubview:swZhendong];

                }
                cell.textLabel.text= [nameArr objectAtIndex:(indexPath.row + 3)];
                NSString * str2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"zhenDong"];
                if ([str2 intValue]) {
                    if (indexPath.row == 1) {
                        [swZhendong setOn:YES];
//                        musicLable.text =@"";
                    }
                    
                }else{
                    if (indexPath.row ==0) {
                        [swLock setOn:YES];
                        musicLable.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ring"];
                    }
                }
                
            }
                break;
                
            default:
                break;
        }
        
        return cell;
    }else {
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = [lockArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIImageView * roundView = [[UIImageView alloc] initWithFrame:CGRectMake(lockView.frame.size.width-40, 5, 30, 30)];
        roundView.backgroundColor = [UIColor colorWithRed:67/255. green:67/255. blue:67/255. alpha:1.];
        roundView.layer.cornerRadius = 15;
        roundView.layer.masksToBounds = YES;
        [cell.contentView addSubview:roundView];
        [roundArr addObject:roundView];
        if(indexPath.row ==lockFlag) {
            roundView.backgroundColor = [UIColor colorWithRed:21/255. green:130/255. blue:172/255. alpha:1.];
        }
    }
 
    return cell;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag ==0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
        switch (indexPath.section) {
            case 1:
                if (indexPath.row ==0) {
          //                //调用日期显示
                    UIDatePicker * datePicker = [[UIDatePicker alloc] init];
                    datePicker.tag = 101;
                    datePicker.datePickerMode = UIDatePickerModeTime;
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                                                                   message:nil
                                                                            preferredStyle:UIAlertControllerStyleActionSheet];
                    [alert.view addSubview:datePicker];
                    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        formatter.dateFormat = @" h:mm a";
                        time = [formatter stringFromDate:datePicker.date];
                        [[NSUserDefaults standardUserDefaults] setObject:time forKey:@"oneDayOnceTime"];//全天事件提醒时间
                        
                        //显示时间的变量
                        //一个cell刷新
                        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:1];
                        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                        
                    }];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { }];
                    [alert addAction:ok];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
                break;
            case 2:
            {
                if (indexPath.row ==0) {
                    [self.view addSubview:lockView];
                }
            }
                break;
        }
    }
    else{
        for (int j=0; j<roundArr.count; j++) {
            UIImageView *view = [roundArr objectAtIndex:j];
            if (j== indexPath.row) {
                view.backgroundColor = [UIColor colorWithRed:21/255. green:130/255. blue:172/255. alpha:1.];
            }
            else{
                view.backgroundColor = [UIColor colorWithRed:67/255. green:67/255. blue:67/255. alpha:1.];
            }
        }
        
        [_player pause];
        [_player stop];
        _player=nil;
        lockFlag = indexPath.row ;
        //播放音频
        [self playAudioFile:[lockArr objectAtIndex:indexPath.row]];
    }
}
- (void)playAudioFile:(NSString *)soundFileName{
    
    NSString *path=[[NSBundle mainBundle] pathForResource:soundFileName ofType:@"caf"];
    if (!_player)
    {
        _player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
        _player.delegate=self;
    }
    [_player play];
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag

{
    //播放结束时执行的动作
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;

{
    //解码错误执行的动
}
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player;

{
    //处理中断的代码
}
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player

{
    
    [_player play];
    
}
-(void)switchAction:(UISwitch*)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (sender.tag ==1) {
        if (isButtonOn) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"oneTime"];//1为当次事件提醒开启 0关闭
        }else {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"oneTime"];//
        }
    }else if(sender.tag ==2)
    {
        if (isButtonOn) {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"allDay"];//1为全天事件提醒开启  0关闭
        }else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"allDay"];//1为全天事件提醒
        }
        
    }else if (sender.tag ==3)
    {
        if (isButtonOn) {
            [swLock setOn:YES];
            [swZhendong setOn:NO];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"zhenDong"];//1 为震动 0 为铃音
             musicLable.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ring"];
            
        }else
        {
//            musicLable.text =@"";
            [swLock setOn:NO];
            [swZhendong setOn:YES];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"zhenDong"];//1 为震动 0 为铃音
            
        }
    }else if(sender.tag ==4)
    {
        if (isButtonOn) {
//            musicLable.text =@"";
            [swLock setOn:NO];
            [swZhendong setOn:YES];
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"zhenDong"];//1 为震动 0 为铃音
        }else
        {    musicLable.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"ring"];
            [swLock setOn:YES];
            [swZhendong setOn:NO];
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"zhenDong"];//1 为震动 0 为铃音
            
        }
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    if (section == 1) {
        headerLabel.text = @"                                     全天事件默认提醒";
    }else if(section == 0)
    {
        headerLabel.text = @"                                            事件默认提醒";
    }
    [headerLabel setFont:[UIFont systemFontOfSize:16.0]];
    [headerLabel setTextColor:[UIColor blackColor]];
    headerLabel.alpha = 0.8;
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    return headerLabel;
}


- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    if(tableView.tag ==0)
    {
        return 40.0 ;
        if (section ==2) {
            return 10.0;
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView  heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
    
}

@end

