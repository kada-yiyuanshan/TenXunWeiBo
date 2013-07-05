//
//  TokenDataBase.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenDataBase : NSObject
{
    NSString *access_token;
    NSString *expires_in;
    NSString *openid;
    NSString *openkey;
    NSString *refresh_token;
    NSString *state;
    NSString *name;
    NSString *nick;
    NSInteger _id;
}
@property(retain,nonatomic) NSString *access_token;
@property(retain,nonatomic) NSString *expires_in;
@property(retain,nonatomic) NSString *openid;
@property(retain,nonatomic) NSString *openkey;
@property(retain,nonatomic) NSString *refresh_token;
@property(retain,nonatomic) NSString *state;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *nick;
@property(assign,nonatomic) NSInteger _id;

-(id)init_id:(NSInteger )u_id  access_token:(NSString *)_access_token expires:(NSString *)_expires_in open_id:(NSString *)_open_id  open_key:(NSString *)_open_key refresh_token:(NSString *)_refresh_token state:(NSString *)_state name:(NSString *)_name nick:(NSString *)_nick;
@end
