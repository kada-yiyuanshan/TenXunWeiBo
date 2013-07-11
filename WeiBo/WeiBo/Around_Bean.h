//
//  Around_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Around_Bean : NSObject
{
    NSString *head;
    NSString *nick;
    NSString *origtext;
    NSString *timestamp;
}
@property(retain,nonatomic) NSString *head;
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *origtext;
@property(retain,nonatomic) NSString *timestamp;


@end
