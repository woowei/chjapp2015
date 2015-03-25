//
//  CHJRequestoperation.m
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "CHJRequestoperation.h"

@implementation CHJRequestoperation

- (id)initWithRequest:(CHJRequestUrl *)request
              success:(SuccessdCompletion)success
              failure:(FailedCompletion)failure
{
    if (self = [super init]) {
        _request = request;
        _success = success;
        _failure = failure;
    }
    return self;
}
- (void)startWithHUD:(NSString *)title inView:(UIView *)view
{
    if (![title isEqualToString:@""])
    {
         [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"正在%@",title]];
    }
    NSString *soapMsg =[NSString stringWithFormat:@"%@"
                        "</MySoapHeader>\n"
                        "</soap:Header>\n"
                        "<soap:Body>\n"
                        "%@"
                        "</soap:Body>\n"
                        "</soap:Envelope>\n",[self soapHeader],_request.soapBody];
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",BASE_URL,_request.requestURL];
   // DLog(@"URL---==%@",urlStr);
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSString *msgLength = [NSString stringWithFormat:@"%ld", (unsigned long)[soapMsg length]];
    
    [req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    
    [req addValue:[NSString stringWithFormat:@"%@%@",_request.baseURL,_request.soapUrl] forHTTPHeaderField:@"SOAPAction"];
    
    [req setHTTPMethod:_request.httpMethod];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse *respone, NSData *data, NSError *error)
     {
       
         if ([data length]>0 && error==nil)
         {
             NSString *html=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             //DLog(@"result===%@",html);
        if (![title isEqualToString:@""])
        {
             [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@成功",title]
                                         duration:1.5];
        }
             if (self.success) {
                 self.success( html);
             }
             
         }else
         {
             if (![title isEqualToString:@""])
             {
                  [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@失败",title] duration:1.0] ;
             }
             if (self.failure) {
                 self.failure(error);
             }
         }
     }];
}
//"<GetModelByENameAndEPassword2 xmlns=\"http://www.woowei.cn/\">\n"
//"<EName>方银儿</EName>\n"
//"<EPassword>123456</EPassword>\n"
//"</GetModelByENameAndEPassword2>\n"
- (void)cancel
{
    [self.operation cancel];
}
-(NSString*)soapHeader
{
    return @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
    "<soap:Header>\n"
    "<MySoapHeader xmlns=\"http://oa.caohejing.com:8080/\">\n"
    "<UserName>CHJwsUName</UserName>\n"
    "<PassWord>PwdCHJ201501</PassWord>\n""";
}
@end
