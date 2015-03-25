//
//  MyActivityCell.m
//  chjapp
//
//  Created by 启年信息 on 14-11-11.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "MyActivityCell.h"
#import "Product.h"

@implementation MyActivityCell
{
    UILabel* leftTopLab;
    UILabel* leftDownLab;
    UILabel* rightLab;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 75, 50)];
        [self.leftView setBackgroundColor:[UIColor whiteColor]];
        self.leftView.layer.borderWidth = 1;  // 给图层添加一个有色边框
        self.leftView.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:self.leftView];
        
        
        leftTopLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, self.leftView.frame.size.width, self.leftView.frame.size.height/2-3)];
        //        leftTopLab.text = @"11 -11 周二";
        leftTopLab.font = [UIFont systemFontOfSize:12];
        [leftTopLab setTextAlignment:NSTextAlignmentCenter];
        [self.leftView addSubview:leftTopLab];
        
        
        leftDownLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.leftView.frame.size.height/2-3, self.leftView.frame.size.width, self.leftView.frame.size.height/2-3)];
        //        leftDownLab.text = @"11:12-12.30";
        leftDownLab.font = [UIFont systemFontOfSize:10];
        [leftDownLab setTextAlignment:NSTextAlignmentCenter];
        [leftDownLab setTextColor:[UIColor blueColor]];
        [self.leftView addSubview:leftDownLab];
        
        
        
        
        
        
        
        
        CGFloat rightFloat = self.frame.size.width -self.leftView.frame.origin.x-self.leftView.frame.size.width-20;
        
        self.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.leftView.frame.size.width+20, 10, rightFloat, 50)];
        [self.rightView setBackgroundColor:[UIColor whiteColor]];
        self.rightView.layer.borderWidth = 1;  // 给图层添加一个有色边框
        self.rightView.layer.borderColor = [UIColor redColor].CGColor;
        [self addSubview:self.rightView];
        
        rightLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.rightView.frame.size.width-20, self.rightView.frame.size.height)];
        //        rightLab.text = @"agagsghdshdf";
        rightLab.font = [UIFont systemFontOfSize:10];
        //        [rightLab setTextAlignment:NSTextAlignmentCenter];
        rightLab.numberOfLines = 0;
        [rightLab setTextColor:[UIColor blueColor]];
        [self.rightView addSubview:rightLab];
        
    }
    return self;
}


- (void)tableViewCellDict:(NSMutableDictionary*)dict reverseArray:(NSArray*)array Index:(NSInteger)index
{
    
    //    NSMutableDictionary* muDict = [ArrayUtils dictFromArray:array];
    //    NSArray* keyArr = [[muDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    //    NSArray* reversedArray = [[keyArr reverseObjectEnumerator] allObjects];
    //
    
    NSString* keyString = [array objectAtIndex:index];
    
    Product* model = [dict objectForKey:keyString];
    
    NSString* nowDtaeStr = [DateUtils stringFromDate:[NSDate date] withFormatter:@"yyyy-MM-dd"];
    
    long currentTime = [self dateFromDateString:nowDtaeStr];
    long mDateTime = [self dateFromDateString:[DateUtils stringFromMDate:model.MDate]];
    
    
    
    
    if (mDateTime>currentTime) {
        self.leftView.layer.borderColor = [UIColor blackColor].CGColor;
        self.rightView.layer.borderColor = [UIColor blackColor].CGColor;
        
    }else if (mDateTime==currentTime){
        self.leftView.layer.borderColor = [UIColor redColor].CGColor;
        self.rightView.layer.borderColor = [UIColor redColor].CGColor;
    }else{
        self.leftView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.rightView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    leftTopLab.text =  [DateUtils stringFromMDate:model.MDate]; //model.MDate;
    leftDownLab.text = [NSString stringWithFormat:@"%@-%@",[DateUtils stringFromMTime:model.MSTIme],[DateUtils stringFromMTime:model.METime]];
    rightLab.text = model.MName;
    
}


// string 转date
-(long)dateFromDateString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateString];
    long dateLong = [date timeIntervalSince1970];
    return dateLong;
}


- (void)awakeFromNib
{
    // Initialization code
    
    
    //    if ((BOOL)[model.MPersonal integerValue]&&![nowDtaeStr isEqualToString:[DateUtils stringFromMDate:model.MDate]]) {
    //        self.leftView.layer.borderColor = [UIColor orangeColor].CGColor;
    //        self.rightView.layer.borderColor = [UIColor orangeColor].CGColor;
    //
    //    }else if ([nowDtaeStr isEqualToString:[DateUtils stringFromMDate:model.MDate]]){
    //        self.leftView.layer.borderColor = [UIColor redColor].CGColor;
    //        self.rightView.layer.borderColor = [UIColor redColor].CGColor;
    //    }else{
    //        self.leftView.layer.borderColor = [UIColor grayColor].CGColor;
    //        self.rightView.layer.borderColor = [UIColor grayColor].CGColor;
    //        
    //    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
