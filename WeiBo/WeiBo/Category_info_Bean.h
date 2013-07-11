//
//  Category_info_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category_info_Bean : NSObject
{
    NSString *count;
    NSString *from;
    NSString *head;
    NSString *head_id;
    NSString *pic_url;
    NSString *nick;
    NSString *origtext;
    NSString *pubtime;
}
@property(retain,nonatomic) NSString *count;
@property(retain,nonatomic) NSString *from;
@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *head_id;
@property(retain,nonatomic) NSString *pic_url;
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *origtext;
@property(retain,nonatomic) NSString *pubtime;

@end
