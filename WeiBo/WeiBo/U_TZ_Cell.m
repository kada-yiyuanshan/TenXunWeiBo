//
//  U_TZ_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_TZ_Cell.h"

@interface U_TZ_Cell ()

@end

@implementation U_TZ_Cell
@synthesize f_head,f_name,f_nick,f_st,f_zt,other_view,f_sex;


-(void)dealloc
{
    [super dealloc];
    [f_nick release];
    [f_name release];
    [f_st release];
    [other_view release];
    [f_zt release];
    [f_head release];
    [f_sex release];
}
@end
