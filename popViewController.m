//
//  popViewController.m
//  chjapp
//
//  Created by Chester on 14-12-1.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "popViewController.h"

@interface popViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *dataArray;
@end

@implementation popViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)cancel:(UIButton *)sender
{
    [self hideView:NO];
}
- (IBAction)down:(UIButton *)sender
{
    [self hideView:YES];
}

-(void)hideView:(BOOL)bl
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha=0;
    } completion:^(BOOL bl){
        if (bl==YES)
        {
            if (_downAction)
            {
                _downAction(nil);
            }
        }
        
    }] ;
}
#pragma mark - UITableViewDelegate
#pragma mark - UITablevViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
