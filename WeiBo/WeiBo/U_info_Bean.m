//
//  U_info_Bean.m
//  WeiBo
//
//  Created by hcui on 13-7-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_info_Bean.h"

@implementation U_info_Bean
@synthesize idolnum,fansnum,favnum,u_name,u_nick,tweetnum,u_head,introduction;
@synthesize sex,birth_day,birth_month,birth_year,city_code,country_code,province_code;
-(void)dealloc
{
    [super dealloc];
    [idolnum release];
   // [fansnum release];
    [favnum release];
    [u_name release];
    [u_nick release];
    [tweetnum release];
    [u_head release];
    [introduction release];
    [sex release];
    [birth_day release];
    [birth_month release];
    [birth_year release];
    [city_code release];
    [country_code release];
   // [province_code release];
}
@end
