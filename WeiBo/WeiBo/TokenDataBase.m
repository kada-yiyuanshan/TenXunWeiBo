//
//  TokenDataBase.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "TokenDataBase.h"

@implementation TokenDataBase
@synthesize  access_token,expires_in,refresh_token,openid,openkey,name,nick,state,_id;
-(void)dealloc
{
    [super dealloc];
    [access_token release];
    [expires_in release];
    [refresh_token release];
    [openid release];
    [openkey release];
    [nick release];
    [name release];
    [state release];
}
-(id)init_id:(NSInteger )u_id  access_token:(NSString *)_access_token expires:(NSString *)_expires_in open_id:(NSString *)_open_id  open_key:(NSString *)_open_key refresh_token:(NSString *)_refresh_token state:(NSString *)_state name:(NSString *)_name nick:(NSString *)_nick
{
    self=[super self];
    if (self) {
        self.access_token=_access_token;
        self.expires_in=_expires_in;
        self.refresh_token=_refresh_token;
        self.openid=_open_id;
        self.openkey=_open_key;
        self.nick=_nick;
        self.name=_name;
        self.state=_state;
        self._id=u_id;
    }
    return self;
}
@end
