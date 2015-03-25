//
//  MyActivityCell.h
//  chjapp
//
//  Created by 启年信息 on 14-11-11.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyActivityCell : UITableViewCell
@property (strong,nonatomic)UIView* leftView;
@property (strong,nonatomic)UIView* rightView;

- (void)tableViewCellDict:(NSMutableDictionary*)dict reverseArray:(NSArray*)array Index:(NSInteger)index;

@end
