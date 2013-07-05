//
//  U_TZ_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_TZ_Bean.h"

@implementation U_TZ_Bean
@synthesize fansnum,head,name,nick,sex,isfans,isidol,openid;

-(void)dealloc
{
    [super dealloc];
    [fansnum release];
   // [head release];
    [name release];
    [nick release];
    [isfans release];
   // [isidol release];
}

@end
