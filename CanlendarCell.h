//
//  CanlendarCell.h
//  chjapp
//
//  Created by Chester on 14-12-4.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@interface CanlendarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (assign,nonatomic) NSInteger type;
@property (copy,nonatomic) CommonBlock action;

+(id)loadNib;
-(void)setValueToViews:(Product*)dict;
@end
