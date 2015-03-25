//
//  alertTableView.h
//  chjapp
//
//  Created by Chester on 14/12/14.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alertTableView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (copy,nonatomic)CommonBlock downAction;
@property (copy,nonatomic)CommonBlock cancelAction;
@property (strong,nonatomic)NSMutableArray *weeksArray;
+(id)loadNib;
-(void)setValueToView:(NSString*)date yearDate:(NSString*)year;
@end
