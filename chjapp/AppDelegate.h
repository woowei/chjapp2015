//
//  AppDelegate.h
//  chjapp
//
//  Created by 启年信息 on 14-11-9.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMeunView.h"
#import "RightView.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftMeunView *LeftView;
@property (strong, nonatomic) RightView *rightView;

-(void)showLeftMenu;
-(void)hidedLeftView;
- (void)showRightView;
- (void)hidedRightView:(CGFloat)animationDuration;
@end
