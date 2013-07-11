//
//  Friends_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Friends_Bean.h"

@implementation Friends_Bean
@synthesize head,nick;

-(void)dealloc
{
    [super dealloc];
    [head release];
    [nick release];
}
@end
