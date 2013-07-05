//
//  U_ST_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_ST_Cell.h"

@interface U_ST_Cell ()

@end

@implementation U_ST_Cell
@synthesize f_head,f_name,f_nick,f_st;

-(void)dealloc
{
    [super dealloc];
    [f_nick release];
    [f_name release];
    [f_st release];
    [f_head release];
}
@end
