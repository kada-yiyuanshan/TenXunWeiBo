//
//  H_info_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-5.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface H_info_Bean : NSObject
{
    NSString *from;
    NSString *nick;
    NSString *head;
    NSString *origtext;
    NSString *source_head;
    NSString *source_image;
    NSString *source_nick;
    NSString *source_origtext;
    NSString *timestamp;
    
}
@property(retain,nonatomic) NSString *from;
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *origtext;
@property(retain,nonatomic) NSString *source_head;
@property(retain,nonatomic) NSString *source_image;
@property(retain,nonatomic) NSString *source_nick;
@property(retain,nonatomic) NSString *source_origtext;
@property(retain,nonatomic) NSString *timestamp;



@end
