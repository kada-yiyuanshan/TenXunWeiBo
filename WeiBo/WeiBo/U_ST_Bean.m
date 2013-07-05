//
//  U_ST_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_ST_Bean.h"

@implementation U_ST_Bean
@synthesize fansnum,head,name,nick,sex,isfans,isidol,openid;

-(void)dealloc
{
    [super dealloc];
    [fansnum release];
    // [head release];
    [name release];
    //[nick release];
    //[isfans release];
    //[isidol release];
    //[openid release];
}

@end
