//
//  H_info_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "H_info_Bean.h"

@implementation H_info_Bean
@synthesize from,nick,head,origtext,timestamp;
@synthesize source_image,source_nick,source_origtext,source_head;

-(void)dealloc
{
    [super dealloc];
    [from release];
    [nick release];
    [head release];
    [origtext release];
    [timestamp release];
    [source_nick release];
    [source_image release];
    [source_origtext release];
    [source_head release];
}

@end
