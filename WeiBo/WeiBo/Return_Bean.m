//
//  Return_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Return_Bean.h"

@implementation Return_Bean
@synthesize state;

-(void)dealloc
{
    [super dealloc];
    [state release];
}
@end
