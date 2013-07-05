//
//  U_ST_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface U_ST_Bean : NSObject
{
    NSString *fansnum;
    NSString *head;
    NSString *name;
    NSString *nick;
    NSInteger sex;
    NSString *isfans;
    NSString *isidol;
    NSString *openid;
}
@property(retain,nonatomic) NSString *fansnum;
@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *isfans;
@property(assign,nonatomic) NSInteger sex;
@property(retain,nonatomic) NSString *isidol;
@property(retain,nonatomic) NSString *openid;
@end
