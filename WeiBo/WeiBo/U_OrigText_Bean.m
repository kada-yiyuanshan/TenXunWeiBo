//
//  U_OrigText_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_OrigText_Bean.h"

@implementation U_OrigText_Bean
@synthesize nick,origfrom,origimage,origtext,origtime;

-(void)dealloc
{
    [super dealloc];
    [nick release];
    //[origtext release];
    [origfrom release];
    [origimage release];
    [origtime release];
}
@end
