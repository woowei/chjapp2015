//
//  RightViewCell.h
//  chjapp
//
//  Created by Gavin ican on 15/1/23.
//  Copyright (c) 2015年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface RightViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *thingLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

+ (id)loadNib;
- (void)setValueToViews: (Product*)product;

@end
