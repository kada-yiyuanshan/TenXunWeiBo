//
//  Around_WeiBo_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Around_WeiBo_Bean : NSObject
{
    NSString *head;
    NSString *from;
    NSString *nick;
    NSString *pic_url;
    NSString *origtext;
    NSString *timestamp;
    NSString *count;
}

@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *from;
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *pic_url;
@property(retain,nonatomic) NSString *origtext;
@property(retain,nonatomic) NSString *timestamp;
@property(retain,nonatomic) NSString *count;

@end
