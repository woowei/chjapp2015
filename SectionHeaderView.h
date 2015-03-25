//
//  SectionHeaderView.h
//  chjapp
//
//  Created by susu on 14-11-22.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (copy, nonatomic) ButtonActionBlock action;
@property (assign,nonatomic) BOOL selected;
+(id)loadNib;

@end
