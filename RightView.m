//
//  RightView.m
//  chjapp
//
//  Created by Gavin ican on 15/1/19.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "RightView.h"
#import "RightViewCell.h"
#import "DetailsMeetingViewController.h"
#import "SVPullToRefresh.h"

@implementation RightView
{
    NSMutableArray *dataArray;
    //加载刷新开始
    NSInteger starIndex;
    //加载刷新结束
    NSInteger endIndex;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.autoresizesSubviews=NO;
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:frame];
        bgImageView.image = [UIImage imageNamed:@"newbk.png"];
        [self addSubview:bgImageView];
            
        [self loadWeather];
            
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 130, 245, Main_Screen_Height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        
        _dataSource = [NSMutableArray array];
        dataArray = [NSMutableArray array];
        
        __weak RightView *right = self;
        //注册上拉刷新
//        [_tableView addPullToRefreshWithActionHandler:^{
//            [right insertRowAtBottom];
//        }];
        //注册下拉刷新
        [_tableView addPullToRefreshWithActionHandler:^{
            [right insertRowAtTop];
        }];
        
        starIndex = 0;
        endIndex = 10;
        
    }
    return self;
    
}

//天气预报
- (void)loadWeather
{
    UIView *weatherView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 245, 100)];
    weatherView.layer.contents = (id)[UIImage imageNamed:@"weatherbk.png"].CGImage;
    
    UIWebView *weatherWeb = [[UIWebView alloc] initWithFrame:CGRectMake(40, 0, 200, 100)];
    weatherWeb.backgroundColor = [UIColor clearColor];
    NSURL *url = [NSURL URLWithString:@"http://i.tianqi.com/index.php?c=code&id=19&icon=1&num=1"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [weatherWeb loadRequest:request];
    [weatherWeb setUserInteractionEnabled:NO];
    
    [weatherView addSubview:weatherWeb];
    [self addSubview:weatherView];
}

- (void)loadData:(NSArray *)array
{
    dataArray = [NSMutableArray arrayWithArray:array];
    if (dataArray.count > 10) {
        for (int i = 0; i < 10; i++) {
            [_dataSource addObject:[dataArray objectAtIndex:i]];
        }
    } else {
        [_dataSource addObjectsFromArray:dataArray];
    }
}

//上拉刷新
- (void)insertRowAtBottom
{
    __weak RightView *right = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [right.tableView beginUpdates];
        [right.dataSource addObject:[dataArray lastObject]];
        [right.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:right.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [right.tableView endUpdates];
        
        [right.tableView.infiniteScrollingView stopAnimating];
    });
}

//下拉刷新
- (void)insertRowAtTop
{
    __weak RightView *right = self;
    
    int64_t delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [right.tableView beginUpdates];
        //一次加载10条
        for (int i = starIndex; i < endIndex; i++) {
            [right.dataSource insertObject:[dataArray objectAtIndex:i] atIndex:i];
            [right.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        }
        [right.tableView endUpdates];
        [right.tableView.pullToRefreshView stopAnimating];
    });
    
    if (endIndex < dataArray.count) {
        starIndex = starIndex + 10;
        endIndex = endIndex + 10;
    }
}

#pragma mark - TableViewDataSourc
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdetify = @"rightCell";
    RightViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    if (cell == nil){
        cell = [RightViewCell loadNib];
        [cell setValueToViews:[_dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_cellAction){
        _cellAction([_dataSource objectAtIndex:indexPath.row]);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 1.0f;
    return 55;
}

//隐藏tableview的title
- (NSString*) tableView:(UITableView *) tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    } else {
        return @"";
    }
}

@end
