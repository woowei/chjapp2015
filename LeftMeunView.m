//
//  LeftMeunView.m
//  chjapp
//
//  Created by 小郁 on 14-11-11.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "LeftMeunView.h"

@implementation LeftMeunView
{
   
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.index=0;
        self.autoresizesSubviews=NO;
        UIImageView * iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 260, 50)];
        iconImage.image = [UIImage imageNamed:@"顶部logo.png"];
        [self addSubview:iconImage];
        _tableView=[[UITableView alloc]init];
        _tableView.frame=CGRectMake(0, 70, 265, Main_Screen_Height);
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:244/255.0 alpha:1]];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView .backgroundColor=[UIColor clearColor];
        [self addSubview:_tableView];
        _titles=[NSMutableArray arrayWithObjects:@"按月显示",@"按周显示",@"按日显示", nil];
    }
    return self;
}
#pragma mark - TableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    self.index=[[CommonDefine getStringFromUserDefaultsWithKey:@"index"] integerValue];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (self.index==indexPath.row)
    {
        cell.backgroundColor=S_GRAY_LINE;
    }else
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=[_titles objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}
#pragma mark - TableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_cellAction)
    {
        _cellAction([NSString stringWithFormat:@"%ld",(long)indexPath.row]);
    }
    [CommonDefine saveStringToUserDefaults:[NSString stringWithFormat:@"%ld",indexPath.row] WithKey:@"index"];
    [self.tableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 31)];
    lab.backgroundColor=[UIColor clearColor];
    lab.text=@"显示方式";
    lab.textAlignment =  NSTextAlignmentCenter;
    [lab setFont:[UIFont systemFontOfSize:14.0]];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(10, 30, lab.width-10, 1)];
    [line setBackgroundColor:S_GRAY_LINE];
    [lab addSubview:line];
    return lab;
}
@end
