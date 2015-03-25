//
//  SetRemind_TableViewController.m
//  chjapp
//
//  Created by susu on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "SetRemind_TableViewController.h"

@interface SetRemind_TableViewController ()
{
    NSArray * nameArr;
    NSArray * timeArr;
    NSString *compareTime;
    NSMutableArray *imageArr;
    int timeFlag;
}
@end

@implementation SetRemind_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
    self.navigationItem.title = @"编辑选项";
    nameArr = [[NSArray alloc] initWithObjects:@"15分钟",@"30分钟",@"45分钟",@"1小时",@"2小时", nil];
    timeArr = [[NSArray alloc] initWithObjects:@"15",@"30",@"45",@"1",@"2", nil];
    imageArr  = [[NSMutableArray alloc] init];
    compareTime =  [[NSUserDefaults standardUserDefaults] objectForKey:@"allDayTime"];

    for (int i=0; i<timeArr.count; i++) {
        int com  =[[timeArr objectAtIndex:i] intValue];
        if ([compareTime intValue] == com) {
            timeFlag = i;
            return;
        }else{
            timeFlag =0;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return 5;
    
    return 1;
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
    
    if (indexPath.section ==0) {
        UIImageView * chooseImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width -40, 5, 30, 30)];
        [cell.contentView addSubview:chooseImage];
        [imageArr addObject:chooseImage];
        cell.textLabel.text = [nameArr objectAtIndex:indexPath.row];

        //先判断下是否有选择过，没有设置默认时间15分钟
        if (timeFlag == indexPath.row) {
            chooseImage.image = [UIImage imageNamed:@"okicon.png"];
        }
    }else{
        NSString *onStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"mainSwitch"];
        cell.selectionStyle = UITableViewCellEditingStyleNone;
        cell.textLabel.text =@"闹铃开启";
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(250, 5, 40, 30)];
        if ([onStr intValue]) {
             [switchButton setOn:YES];
        }else
        {
             [switchButton setOn:NO];
        }
       
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton];
    }
    
    return cell;
}

//选中Cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    if (indexPath.section ==0) {
        for (int i=0; i<imageArr.count; i++) {
            UIImageView *view = [imageArr objectAtIndex:i];
            if (i == indexPath.row) {
                view.image = [UIImage imageNamed:@"okicon.png"];
                [[NSUserDefaults standardUserDefaults] setObject:[timeArr objectAtIndex:i] forKey:@"allDayTime"];//当次时间提醒提前时间
            }else{
                view.image = Nil;
            }
        }
    }

}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
       //yes
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"mainSwitch"];
    }else {
        // no
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"mainSwitch"];
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 30)];
    if (section == 1) {
        headerLabel.text = @"";
    }else if(section == 0)
    {
        headerLabel.text = @"                                       默认事件提前时间";
    }
//    headerLabel.textAlignment =  NSTextAlignmentRight;
    [headerLabel setFont:[UIFont systemFontOfSize:16.0]];
    [headerLabel setTextColor:[UIColor blackColor]];
    headerLabel.alpha = 0.9;
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    return headerLabel;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"默认事件持续时间   ";
    
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 40.0 ;
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
