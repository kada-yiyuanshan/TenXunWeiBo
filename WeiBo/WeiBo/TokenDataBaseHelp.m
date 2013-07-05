//
//  TokenDataBaseHelp.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "TokenDataBaseHelp.h"
#import "TokenDataBase.h"

#define DB_NAME @"Token.sqlite"
@implementation TokenDataBaseHelp

- (id)init
{
    self = [super init];
    if (self) {
        [self opendatabase];
    }
    
    return self;
}
- (NSString *)dataFilePath
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DB_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DB_NAME];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:
                   writableDBPath error:&error];
        if (!success) {
            
        }
    }
    return writableDBPath;
}
-(void)opendatabase
{
    
    int open=sqlite3_open([self.dataFilePath UTF8String], &database);
    //NSLog(@"open=%d",open);
    if ( open!= SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"open database error! ");
    }
}



-(void)insertTotable:(TokenDataBase *)info
{
    
    char *error;
    
    NSString *insertsql=[NSString stringWithFormat:@"insert into token (access_token,expires_in,openid,openkey,refresh_token,state,name,nick) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",info.access_token,info.expires_in,info.openid,info.openkey,info.refresh_token,info.state,info.name,info.nick];
    int insert=sqlite3_exec(database, [insertsql UTF8String], NULL, NULL, &error);
    //NSLog(@"insert=%d",insert);
    // NSLog(@"error=%s",error);
    if (insert!=SQLITE_OK) {
        NSLog(@"insert data error !");
        sqlite3_close(database);
        
    }
    else
    {
        //NSLog(@"insert data OK !");
    }
    
}

- (void)updateTotable:(TokenDataBase *)info
{
    char *error;
	NSString *sql = [NSString stringWithFormat:@"update token set access_token= '%@',expires_in= '%@',openid= '%@',openkey= '%@',refresh_token= '%@',state= '%@',name= '%@',nick= '%@'  where id = %d",info.access_token,info.expires_in,info.openid,info.openkey,info.refresh_token,info.state,info.name,info.nick,1];
    int updata=sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error) ;
	if (updata!= SQLITE_OK) {
        NSLog(@"update error");
		sqlite3_close(database);
	}
	
}

-(void)queryTotable:(NSMutableArray *)_arr
{
    
    sqlite3_stmt *statement=nil;
    NSString *sql = @"select * from token;";
    int get=sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil);
    // NSLog(@"get=%d",get);
    if (get==SQLITE_OK){
        while (sqlite3_step(statement)==SQLITE_ROW)
		{
            NSInteger _id=sqlite3_column_int(statement, 0);
			NSString *access_token=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *expires_in=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NSString *openid=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
            NSString *openkey=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 4) encoding:NSUTF8StringEncoding];
            NSString *refresh_token=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 5) encoding:NSUTF8StringEncoding];
            NSString *state=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 6) encoding:NSUTF8StringEncoding];
            NSString *name=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 7) encoding:NSUTF8StringEncoding];
            NSString *nick=[[NSString alloc] initWithCString:(char *)sqlite3_column_text(statement, 8) encoding:NSUTF8StringEncoding];
            TokenDataBase *tokendatabase=[[TokenDataBase alloc] init_id:_id access_token:access_token expires:expires_in open_id:openid open_key:openkey refresh_token:refresh_token state:state name:name nick:nick];
           [_arr addObject:tokendatabase];
            
            [access_token release];
            [expires_in release];
            [openid release];
            [openkey release];
            [state release];
            [name release];
            [refresh_token release];
            [nick release];
		}
		sqlite3_finalize(statement);
        statement = nil;
        
    } else
    {
        sqlite3_close(database);
    }
    [sql release];
}

@end
