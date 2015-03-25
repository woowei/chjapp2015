//
//  MeetingDetailsViewController.m
//  chjapp
//
//  Created by susu on 14-11-12.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "MeetingDetailsViewController.h"
#import "GDataXMLNode.h"

@interface MeetingDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *meetTable;
    NSArray *imageArr;
    NSArray *lableArr;
    NSArray *keyArr;
    NSMutableArray * mutableArr;
}
@end

@implementation MeetingDetailsViewController
@synthesize DetailDic;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"会议详情"withAlignment:NavigationBarTitleViewAlignmentCenter];
    self.view.backgroundColor = [UIColor whiteColor];
    imageArr = [[NSArray alloc] initWithObjects:@"thingicon.png",@"timeicon.png",@"Lpersonicon.png",@"thingicon.png",@"roomicon.png" ,@"companyicon.png",@"alarmicon.png",nil];
    lableArr = [[NSArray alloc] initWithObjects:@"会议名称:", @"会议时间:",@"参与人及部门:",@"会议联系人:",@"会议地点:",nil];
    keyArr = [[NSArray alloc] initWithObjects:@"MName",@"MDate",@"MPeople",@"MLinkMan",@"MWhere", nil];
    mutableArr = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        NSString *str =[NSString stringWithFormat:@"%@%@",[lableArr objectAtIndex:i],[DetailDic objectForKey:[keyArr objectAtIndex:i]]];
        NSString *textP = [self removeSpaceAndNewline:str];
        [mutableArr addObject:textP];
    }

    self.automaticallyAdjustsScrollViewInsets =NO;
    
    meetTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64,Main_Screen_Width, Main_Screen_Height-64)style:UITableViewStyleGrouped];
    meetTable.delegate = self;
    meetTable.dataSource = self;
    [self.view addSubview:meetTable];
    UIBarButtonItem *shareBtn=[CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(back) withImage:@"backicon" withHighlightImage:@"backicon"];
    
    [self.navigationItem setLeftBarButtonItem:shareBtn];

}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }else{
        [cell removeFromSuperview];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:0]]];
    [cell.contentView addSubview:image];
    
  
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, Main_Screen_Width-40, 50)];
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.numberOfLines = 0;
    lable.font = [UIFont systemFontOfSize:16.];
    if(indexPath.section == 0)
    {
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:indexPath.row]]];
        if(indexPath.row ==0)
        {   //会议名称
            lable.text = [mutableArr objectAtIndex:indexPath.row];
            NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.],NSFontAttributeName,nil];
            CGSize  labelsize =[lable.text boundingRectWithSize:CGSizeMake(Main_Screen_Width-40,2000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
            float f = labelsize.height > 50? labelsize.height:50;
            lable.frame =CGRectMake(40, 0, Main_Screen_Width-40, f);
            
        }else
        {//先截取下时间
            NSString *str1 =[self time:indexPath.row];
            NSString *str2 = [self time:indexPath.row];
            NSString *strDate = [[DetailDic objectForKey:@"MDate"]substringToIndex:10];
            lable.text = [NSString stringWithFormat:@"%@  %@  %@→%@ ",[lableArr objectAtIndex:indexPath.row],strDate,str1,str2];
        }
        
    }else if(indexPath.section ==1)
    {
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:indexPath.row +2]]];

        lable.text = [mutableArr objectAtIndex:indexPath.row+2];
         NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.],NSFontAttributeName,nil];
        CGSize  labelsize =[lable.text boundingRectWithSize:CGSizeMake(Main_Screen_Width-40,2000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
        float f = labelsize.height > 50? labelsize.height:50;
        lable.frame =CGRectMake(40, 0, Main_Screen_Width-40,f+5);
    }
    else
    {
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:indexPath.row +5]]];

        if (indexPath.row ==0) {
             lable.text = @"公司工作安排";
        }else
        {
             lable.text = @"闹铃设置";
            //switch开关
        }
       
    }
    [cell.contentView addSubview:lable];
      return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 2;
    }else if(section ==1)
    {
        return 3;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *s =[[NSString alloc] init];
    //根据lable字数调整高度
    if (indexPath.section ==0 ) {
        s =[mutableArr objectAtIndex:indexPath.row];
    }else if(indexPath.section ==1 )
    {
        s =[mutableArr objectAtIndex:indexPath.row+2];
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16.],NSFontAttributeName,nil];
    CGSize  labelsize =[s boundingRectWithSize:CGSizeMake(Main_Screen_Width-40,2000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
   float f = labelsize.height > 50? labelsize.height:50;

//    NSLog(@"lablesie height =%f f =%f",labelsize.height,f);

    return f+5;
}

-(NSString *)time:(NSInteger)num
{
    
    NSString *String1 =[DetailDic objectForKey:@"MSTIme"];
    NSString *str;
    [String1 rangeOfString:@"PT"].location !=NSNotFound ?String1 =[String1 stringByReplacingOccurrencesOfString:@"PT" withString:@""] : NSLog(@"NO");
    
    [String1 rangeOfString:@"H"].location !=NSNotFound  ?String1 =[String1 stringByReplacingOccurrencesOfString:@"H" withString:@":"] : NSLog(@"NO");
    
    [String1 rangeOfString:@"M"].location !=NSNotFound  ?(String1 =[String1 stringByReplacingOccurrencesOfString:@"M" withString:@""] ,str =@""  ): (str = @"00");
    
    NSMutableString * rStr = [[NSMutableString alloc] initWithFormat:@"%@%@",String1,str];
    
    return rStr;
    
}
- (NSString *)removeSpaceAndNewline:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
