//
//  SectionHeaderView.m
//  chjapp
//
//  Created by susu on 14-11-22.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "SectionHeaderView.h"


@implementation SectionHeaderView
{
   
}

+(id)loadNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SectionHeaderView" owner:nil options:nil]lastObject];
}

- (IBAction)btnAction:(UIButton *)sender
{
    if (_selected==1)
    {
        _selected=0;
    }
    else
    {
        _selected=1;
    }
    if (_action)
    {
        _action(sender,[NSString stringWithFormat:@"%d",_selected]);
    }
}

@end
