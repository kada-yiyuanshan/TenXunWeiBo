//
//  Around_WeiBo_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Around_WeiBo_Cell.h"

@interface Around_WeiBo_Cell ()

@end

@implementation Around_WeiBo_Cell

@synthesize head_view,orig_pic,origtext,time,nick,from,number;

-(void)dealloc
{
    [super dealloc];
    [head_view release];
    //  [orig_pic release];
    //[origtext release];
    //[time release];
    // [nick release];
    // [from release];
    // [number release];
}@end
