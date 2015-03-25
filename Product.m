//
//  Product.m
//  chjapp
//
//  Created by 小郁 on 14-11-10.
//  Copyright (c) 2014年 chj. All rights reserved.
//

#import "Product.h"

@implementation Product

+(id)meetingModelWithXml:(GDataXMLElement*)xmlElement
{
    
    
    return [[self alloc]initWithXml:xmlElement];;
}


- (id)initWithXml:(GDataXMLElement*)xmlElement
{
    if (self == [super init]) {
        self.MID = [[xmlElement elementsForName:@"MID"].lastObject stringValue];
        self.MName = [[xmlElement elementsForName:@"MName"].lastObject stringValue];
        self.MDate = [[xmlElement elementsForName:@"MDate"].lastObject stringValue];
        self.MSTIme = [[xmlElement elementsForName:@"MSTIme"].lastObject stringValue];
        self.MPeople = [[xmlElement elementsForName:@"MPeople"].lastObject stringValue];
        self.MLinkMan = [[xmlElement elementsForName:@"MLinkMan"].lastObject stringValue];
        self.MWhere = [[xmlElement elementsForName:@"MWhere"].lastObject stringValue];
        self.METime = [[xmlElement elementsForName:@"METime"].lastObject stringValue];
        self.Other1 = [[xmlElement elementsForName:@"Other1"].lastObject stringValue];
        self.Other2 = [[xmlElement elementsForName:@"Other2"].lastObject stringValue];
    }
    
    return self;
}

@end
