//
//  SetAttention_TableViewController.m
//  chjapp
//
//  Created by susu on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "SetAttention_TableViewController.h"

@interface SetAttention_TableViewController ()
{
    UILabel * onOffLable;
}
@end

@implementation SetAttention_TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
    self.navigationItem.title = @"关注选项";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.text = @"                                  是否可以被其他人关注";
        cell.textLabel.alpha = 0.6;
        cell.textLabel.font = [UIFont systemFontOfSize:14.];
        
    }
    else
    {
        cell.textLabel.text = @"  关注选项";
        cell.textLabel.alpha = 0.9;
        cell.textLabel.font = [UIFont systemFontOfSize:18.];
        onOffLable = [[UILabel alloc] initWithFrame:CGRectMake(200, 7, 40, 30)];
        onOffLable.text = @"关闭";
        onOffLable.alpha = 0.5;
        onOffLable.font = [UIFont systemFontOfSize:13.];
        [cell.contentView addSubview:onOffLable];
        
        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(250, 5, 40, 30)];
        [switchButton setOn:NO];
        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:switchButton];
        
    }
    
    return cell;
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        onOffLable.text = @"开启";
    }else {
        onOffLable.text = @"关闭";
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 1.0 ;
   
}
-(CGFloat)tableView:(UITableView *)tableView  heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}


@end
