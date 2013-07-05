//
//  TokenDataBaseHelp.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TokenDataBase.h"
@interface TokenDataBaseHelp : NSObject
{
    sqlite3 *database;
}

-(void)opendatabase;
-(void)insertTotable:(TokenDataBase *)info;
-(void)updateTotable:(TokenDataBase *)info ;
//-(void)deleteTotable:(TokenDataBase *)info;
-(void)queryTotable:(NSMutableArray *)_arr;
@end
