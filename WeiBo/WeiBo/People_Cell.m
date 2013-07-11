//
//  People_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "People_Cell.h"

@interface People_Cell ()

@end

@implementation People_Cell
@synthesize head_view,origtext,time,sex,nick;

-(void)dealloc
{
    [super dealloc];
    [head_view release];
   // [origtext release];
   // [time release];
    //[sex release];
    [nick release];
}

@end
