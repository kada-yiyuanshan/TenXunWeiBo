//
//  U_info_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface U_info_Bean : NSObject
{
    NSString *idolnum;
    NSString *fansnum;
    NSString *tweetnum;
    NSString *favnum;
    NSString *u_name;
    NSString *u_nick;
    NSString *u_head;
    NSString *introduction;
    NSString *sex;
    NSString *birth_day;
    NSString *birth_month;
    NSString *birth_year;
    NSString *city_code;
    NSString *country_code;
    NSString *province_code;
}

@property(retain,nonatomic) NSString *u_head;
@property(retain,nonatomic) NSString *idolnum;
@property(retain,nonatomic) NSString *fansnum;
@property(retain,nonatomic) NSString *tweetnum;
@property(retain,nonatomic) NSString *favnum;
@property(retain,nonatomic) NSString *u_name;
@property(retain,nonatomic) NSString *u_nick;
@property(retain,nonatomic) NSString *introduction;
@property(retain,nonatomic) NSString *sex;
@property(retain,nonatomic) NSString *birth_day;
@property(retain,nonatomic) NSString *birth_month;
@property(retain,nonatomic) NSString *birth_year;
@property(retain,nonatomic) NSString *city_code;
@property(retain,nonatomic) NSString *country_code;
@property(retain,nonatomic) NSString *province_code;

@end
