//
//  LoginViewController.m
//  chjapp
//
//  Created by Chester on 14-11-24.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "LoginViewController.h"
#import "SVProgressHUD.h"
#import "GDataXMLNode.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _userTF.text=[CommonDefine getStringFromUserDefaultsWithKey:@"name"];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)return:(id)sender {
}

- (IBAction)nameTextField_DidEndOnExit:(id)sender {
    // 将焦点移至下一个文本框.
    [self.passWordTF becomeFirstResponder];
}
- (IBAction)passTextField_DidEndOnExit:(id)sender {
    // 隐藏键盘.
    [sender resignFirstResponder];
    // 触发登陆按钮的点击事件.
    [self.btn sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)loginBtn:(UIButton *)sender
{
    if ((_userTF.text.length>0)&(_passWordTF.text.length>0))
    {
        [CommonDefine saveStringToUserDefaults:_userTF.text WithKey:@"name"];
        [self request];
    }
    else
    {
        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"账号、密码不能为空"];
    }
}

-(IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

-(void)request
{
    __block LoginViewController *vc=self;
    CHJRequestUrl *request=[CHJRequest loginRequestWithSoapBody:[NSString stringWithFormat:@"<GetModelByENameAndEPassword2 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                            "<EName>%@</EName>\n"
                            "<EPassword>%@</EPassword>\n"
                            "</GetModelByENameAndEPassword2>\n",_userTF.text,_passWordTF.text] soapUrl:@"GetModelByENameAndEPassword2"];
    
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
         NSString* request = (NSString*)result;
        [vc xmlString:request];
    } failure:^(NSError *error){
        
    }];
    [operation startWithHUD:@"登录" inView:self.view];
}
- (void)xmlString:(NSString*)xmlString
{
    
    //    [tableMuArr  removeAllObjects];
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:self.reciveData options:0 error:nil];
    
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetModelByENameAndEPassword2Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetModelByENameAndEPassword2Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"EName"].lastObject;
    NSString *name=[diffgram stringValue];
    if (name.length>0)
    {
        if (self.loginAction)
        {
            self.loginAction(nil);
        }
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        
        [SVProgressHUD show];
        [SVProgressHUD showErrorWithStatus:@"账号、密码错误!"];

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
