//
//  Category_Bean.h
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category_Bean : NSObject
{
    NSString *child_name;
    NSInteger child_id;
}
@property(retain,nonatomic) NSString *child_name;
@property(assign,nonatomic) NSInteger child_id;
@end
