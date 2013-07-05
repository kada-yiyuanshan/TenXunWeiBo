//
//  ErrorBean.m
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import "ErrorBean.h"

@implementation ErrorBean

@synthesize status,errorMessage;
@synthesize counts,pages;

-(void)dealloc
{
    [status release];
    [errorMessage release];
    [super dealloc];
}
@end
