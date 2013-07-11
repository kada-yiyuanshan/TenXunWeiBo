//
//  Around_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Around_Bean.h"

@implementation Around_Bean
@synthesize head,timestamp,origtext,nick;

-(void)dealloc
{
    [super dealloc];
    [head release];
    [timestamp release];
    [origtext release];
    //[nick release];
}


@end
