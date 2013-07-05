//
//  U_OrigText_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface U_OrigText_Bean : NSObject
{
    NSString *nick;
    NSString *origtext;
    NSString *origimage;
    NSString *origtime;
    NSString *origfrom;
}
@property(retain,nonatomic) NSString *nick;
@property(retain,nonatomic) NSString *origtext;
@property(retain,nonatomic) NSString *origimage;
@property(retain,nonatomic) NSString *origtime;
@property(retain,nonatomic) NSString *origfrom;


@end
