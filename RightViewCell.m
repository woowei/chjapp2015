//
//  RightViewCell.m
//  chjapp
//
//  Created by Gavin ican on 15/1/23.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import "RightViewCell.h"

@implementation RightViewCell

+ (id)loadNib
{
    RightViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"RightViewCell" owner:nil options:nil]lastObject];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thingbk.png"]];
    return cell;
}

- (void)setValueToViews:(Product *)product
{
    self.thingLabel.text = [NSString stringWithFormat:@"%@",product.MName];
    self.thingLabel.font = [UIFont systemFontOfSize:14];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ %@",[product.MDate substringToIndex:10],[DateUtils stringFromMTime:product.MSTIme]];
    self.timeLabel.font = [UIFont systemFontOfSize:14];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
