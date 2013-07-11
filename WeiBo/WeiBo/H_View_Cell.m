//
//  H_View_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "H_View_Cell.h"

@interface H_View_Cell ()

@end

@implementation H_View_Cell

@synthesize head,origtext,origtextfrom,time,repeat,nick;

-(void)dealloc
{
    [super dealloc];
    [head release];
    //[origtext release];
    //[origtextfrom release];
    //[time release];
    //[repeat release];
    //[nick release];
}
@end
