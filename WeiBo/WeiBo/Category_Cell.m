//
//  Category_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Category_Cell.h"

@interface Category_Cell ()

@end

@implementation Category_Cell
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
}

@end
