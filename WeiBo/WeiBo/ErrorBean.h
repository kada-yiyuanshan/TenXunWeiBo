//
//  ErrorBean.h
//  PaiGo
//
//  Created by perry on 12-11-12.
//  Copyright (c) 2012年 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorBean : NSObject
{
    NSString *status;
    NSString *errorMessage;
    NSInteger counts;
    NSInteger pages;
}

@property(retain,nonatomic) NSString *status;
@property(retain,nonatomic) NSString *errorMessage;
@property(assign,nonatomic) NSInteger counts;
@property(assign,nonatomic) NSInteger pages;

@end
