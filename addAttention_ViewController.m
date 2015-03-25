//
//  addAttention_ViewController.m
//  chjapp
//
//  Created by susu on 14-12-7.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "addAttention_ViewController.h"
#import "MJRefresh.h"
#import "GDataXMLNode.h"
@interface addAttention_ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * allArr;
    NSMutableArray *addPAEID;
    NSMutableArray *cancelPAEID;

}
@property(nonatomic,strong)UITableView * addTableView;
@property (assign,nonatomic)    BOOL isYN;
@end

@implementation addAttention_ViewController
@synthesize addTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:238/255. green:238/255. blue:238/255. alpha:1.];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initTable];
    
    [self initNavigationBar];
    [self GetList:USER_NAME];
}

-(void)initTable
{
    addTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height -64-49)];
    addTableView.delegate =self;
    addTableView.dataSource =self;
    addTableView.backgroundColor = [UIColor clearColor];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [addTableView setTableFooterView:view];
    [self.view addSubview:addTableView];

}
- (void)initNavigationBar
{
    self.navigationItem.titleView = [CommonUI setNavigationTitleLabelWithTitle:@"添加关注人"withAlignment:NavigationBarTitleViewAlignmentCenter];
    self.navigationItem.leftBarButtonItem = [CommonUI setNavigationBarButtonItemWithTarget:self withSelector:@selector(back) withImage:@"backicon" withHighlightImage:@"backicon"];
}

- (void)GetList:(NSString*)eName
{

    NSString* urlString = [NSString stringWithFormat:@"<GetLoginNameAllowAttentionPeople2 xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<EName>%@</EName>\n"
                           "</GetLoginNameAllowAttentionPeople2>\n",eName];
    CHJRequestUrl *request=[CHJRequest GetMyAttentionPeopleMeetings2:urlString soapUrl:@"GetLoginNameAllowAttentionPeople2"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        
        NSString* request = (NSString*)result;
        //NSLog(@"request =%@",request);
        [self xmlString:request];
        
    } failure:^(NSError *error){

    }];
   
    [operation startWithHUD:@"请求成功" inView:self.view];
}

- (void)xmlString:(NSString*)xmlString
{
    //初始化xml文档
    GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:xmlString options:0 error:nil];
    //获取根节点
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点的子节点，通过节点的名称
    
    GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
    GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"GetLoginNameAllowAttentionPeople2Response"].lastObject;
    GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"GetLoginNameAllowAttentionPeople2Result"].lastObject;
    GDataXMLElement *diffgram = [GetListByPage2Result elementsForName:@"diffgr:diffgram"].lastObject;
    GDataXMLElement *NewDataSet = [diffgram elementsForName:@"NewDataSet"].lastObject;
    NSArray *ds = [NewDataSet elementsForName:@"Table1"];
    allArr = [[NSMutableArray alloc] init];
    addPAEID = [[NSMutableArray alloc] init];
    cancelPAEID = [[NSMutableArray alloc] init];
    for (GDataXMLElement * note in ds){
        
        NSString* EName = [[note elementsForName:@"EName"].lastObject stringValue];
        NSString* IsGZ = [[note elementsForName:@"IsGZ"].lastObject stringValue];
        NSString* EID = [[note elementsForName:@"EID"].lastObject stringValue];
        NSMutableDictionary* dicItem = [[NSMutableDictionary alloc] init];
        
        [dicItem setValue:EName forKey:@"EName"];
        [dicItem setValue:IsGZ forKey:@"IsGZ"];
        [dicItem setValue:EID forKey:@"EID"];
        if ([IsGZ isEqualToString:@"1"]) {
            [addPAEID addObject:EID];
        }else if([IsGZ isEqualToString:@"0"]){
            [cancelPAEID addObject:EID];
        }
        [allArr addObject:dicItem];
    }
   
    dispatch_sync(dispatch_get_main_queue(), ^{
        [addTableView reloadData];
    });
    
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return allArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableSampleIdentifier = @"TableSampleIdentifier";
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:tableSampleIdentifier];
    for (UIView *xx in cell.contentView.subviews)
    {
        if (xx!=[UILabel class])
        {
            [xx removeFromSuperview];
        }
    }
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableSampleIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary * dic = [allArr objectAtIndex:indexPath.section];
    NSString *onStr = [dic objectForKey:@"IsGZ"];
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(Main_Screen_Width-60, 5, 40, 30)];
    switchButton.tag = indexPath.section;
    if ([onStr intValue]) {
        [switchButton setOn:YES];
    }else
    {
        [switchButton setOn:NO];
    }
    
    [switchButton addTarget:self action:@selector(switchActionn:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switchButton];
    cell.textLabel.text = [dic objectForKey:@"EName"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 30;
    }
    return 20;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 30)];
    if(section == 0)
    {
        headerLabel.text = @"                                              您可关注的对象选择";
    }
    //    headerLabel.textAlignment =  NSTextAlignmentRight;
    [headerLabel setFont:[UIFont systemFontOfSize:14.0]];
    [headerLabel setTextColor:[UIColor blackColor]];
    headerLabel.alpha = 0.9;
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    return headerLabel;
}


-(void)addMyConttent:(NSInteger)tag
{
    NSDictionary * dic = [allArr objectAtIndex:tag];
    NSString *EID = [dic objectForKey:@"EID"];
    [addPAEID addObject:EID];
    NSString *eidStr = [addPAEID componentsJoinedByString:@","];
    NSString* urlString = [NSString stringWithFormat:@"<AddMyAttention xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<EName>%@</EName>\n"
                           "<PAEID>%@</PAEID>\n"
                           "</AddMyAttention>\n",USER_NAME,eidStr];
    CHJRequestUrl *request=[CHJRequest GetMyAttentionPeopleMeetings2:urlString soapUrl:@"AddMyAttention"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        NSString* request = (NSString*)result;
        GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:request options:0 error:nil];
        GDataXMLElement *rootElement = [document rootElement];
        GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
        GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"AddMyAttentionResponse"].lastObject;
        GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"AddMyAttentionResult"].lastObject;
        NSString *ds =[GetListByPage2Result stringValue] ;
        dispatch_sync(dispatch_get_main_queue(), ^{
        if ([ds isEqualToString:@"false"]) {
            
        }else if([ds isEqualToString:@"true"])
        {
             NSDictionary * dic = [allArr objectAtIndex:tag];
           [ dic setValue:@"1" forKey:@"IsGZ"];
            [self.addTableView reloadData];
        }
        });
    } failure:^(NSError *error){
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"add"];
    }];
   [operation startWithHUD:@"" inView:self.view];
}
-(void)cancelMyConttent:(NSInteger)tag
{
    NSDictionary * dic = [allArr objectAtIndex:tag];
    NSString *EID = [dic objectForKey:@"EID"];
    [cancelPAEID addObject:EID];
    NSString *eidStr = [cancelPAEID componentsJoinedByString:@","];
    NSString* urlString = [NSString stringWithFormat:@"<CancelMyAttention xmlns=\"http://oa.caohejing.com:8080/\">\n"
                           "<EName>%@</EName>\n"
                           "<PAEID>%@</PAEID>\n"
                           "</CancelMyAttention>\n",USER_NAME,eidStr];
    CHJRequestUrl *request=[CHJRequest GetMyAttentionPeopleMeetings2:urlString soapUrl:@"CancelMyAttention"];
    CHJRequestoperation *operation=[[CHJRequestoperation alloc]initWithRequest:request success:^(id result){
        NSString* request = (NSString*)result;
        GDataXMLDocument * document = [[GDataXMLDocument alloc]initWithXMLString:request options:0 error:nil];
        GDataXMLElement *rootElement = [document rootElement];
        GDataXMLElement *Body = [rootElement elementsForName:@"soap:Body"].lastObject;
        GDataXMLElement *GetModelByENameAndEPassword2Response = [Body elementsForName:@"CancelMyAttentionResponse"].lastObject;
        GDataXMLElement *GetListByPage2Result = [GetModelByENameAndEPassword2Response elementsForName:@"CancelMyAttentionResult"].lastObject;
        NSString *ds =[GetListByPage2Result stringValue] ;
        //NSLog(@"ds =%@",ds);
        dispatch_sync(dispatch_get_main_queue(), ^{
            if ([ds isEqualToString:@"false"]) {
                
            }else if([ds isEqualToString:@"true"])
            {
                NSDictionary * dic = [allArr objectAtIndex:tag];
                [ dic setValue:@"0" forKey:@"IsGZ"];
                [self.addTableView reloadData];
            }
        });
    } failure:^(NSError *error)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cancel"];
    }];
    
    [operation startWithHUD:@"" inView:self.view];
}

-(void)switchActionn:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        [self addMyConttent:switchButton.tag];
        
    }else {
        [self cancelMyConttent:switchButton.tag];
    }
 }

@end
