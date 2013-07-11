//
//  Category_info_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Category_info_Bean.h"

@implementation Category_info_Bean
@synthesize count,from,head,head_id,pic_url,nick,origtext,pubtime;

-(void)dealloc
{
    [super dealloc];
    [count release];
   // [from release];
    [head_id release];
    [head release];
    [pic_url release];
    [nick release];
    [origtext release];
    [pubtime release];
}
@end
