//
//  QNCustomDatePickerView.m
//  Quan
//
//  Created by 启年信息 on 14-7-4.
//  Copyright (c) 2014年 启年信息. All rights reserved.
//

#import "QNCustomDatePickerView.h"

@implementation QNCustomDatePickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        UIView *backView = [[UIView alloc] initWithFrame:self.frame];
        backView.backgroundColor = [UIColor grayColor];
        backView.alpha = 0.6;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPicker:)];
        [backView addGestureRecognizer:tap];
        [self addSubview:backView];
        
        UIView *pickerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, Main_Screen_Width, 216)];
        [pickerView setCenter:self.center];
        [pickerView setBackgroundColor:[UIColor redColor]];
        [self addSubview:pickerView];
        
         self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0,0, Main_Screen_Width, 216)];
        self.datePicker.backgroundColor = [UIColor whiteColor];
//        [self.datePicker setDatePickerMode:UIDatePickerModeDate];
//        self.datePicker.date = [NSDate date];
        self.datePicker.tag = self.tag;
        [pickerView addSubview:self.datePicker];
        
        
    }
    return self;
}




- (void)tapPicker:(UITapGestureRecognizer*)sender
{
    self.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
