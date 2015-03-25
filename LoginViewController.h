//
//  LoginViewController.h
//  chjapp
//
//  Created by Chester on 14-11-24.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *passWordTF;
@property (copy,nonatomic) CommonBlock loginAction;
@property (nonatomic,retain) IBOutlet UIButton *btn;

- (IBAction)nameTextField_DidEndOnExit:(id)sender;
- (IBAction)passTextField_DidEndOnExit:(id)sender;

- (IBAction)loginBtn:(UIButton *)sender;
@end
