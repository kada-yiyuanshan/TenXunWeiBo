//
//  Category_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Category_Bean.h"

@implementation Category_Bean
@synthesize child_id,child_name;

-(void)dealloc
{
    [super dealloc];
    [child_name release];
}
@end
