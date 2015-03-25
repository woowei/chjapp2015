//
//  CanlendarCell.m
//  chjapp
//
//  Created by Chester on 14-12-4.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "CanlendarCell.h"

@implementation CanlendarCell

+(id)loadNib
{
    CanlendarCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"CanlendarCell" owner:nil options:nil]lastObject];
    return cell;
}
-(void)tap:(UITapGestureRecognizer*)tap
{
    if (_action)
    {
        _action([NSString stringWithFormat:@"%ld",(long)self.tag]);
    }
}
-(void)setValueToViews:(Product*)dict
{
    
    
    if (_type==0)
    {
        _img.image=[UIImage imageNamed:@"thingboxicon1"];
    }
    else
    {
        _img.image=[UIImage imageNamed:@"thingboxicon2"];
    }
    if (dict.MName.length>0 && dict.MDate.length>0)
    {
        self.timeLab.text=[NSString stringWithFormat:@"%@ - %@",[DateUtils stringFromMTime:dict.MSTIme],[DateUtils stringFromMTime:dict.METime]];
        self.titleLab.frame=CGRectMake(125, 7, 184, 21);
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        self .userInteractionEnabled=YES;
        self.timeLab.hidden=NO;
    }else
    {
        self.timeLab.hidden=@"";
        self.titleLab.frame=CGRectMake(38, 7, 220, 21);
        self .userInteractionEnabled=NO;
        self.timeLab.hidden=YES;
    }
    
    self.titleLab.text=dict.MName;
    
}
@end
