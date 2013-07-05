//
//  Oauth_String.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Oauth_String.h"
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"

@implementation Oauth_String
@synthesize  access_token,expires_in,refresh_token,openid,openkey,name,nick,state;
@synthesize _array;
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
    [_array release];
}
-(void) initHtmlString:(NSString *)html
{
    NSString *access=@"access_token=";
    NSString *expires=@"expires_in=";
    NSString *open_id=@"openid=";
    NSString *open_key=@"openkey=";
    NSString *refresh=@"refresh_token=";
    NSString *u_state=@"state=";
    NSString *u_name=@"name=";
    NSString *u_nick=@"nick=";
    NSString *other=@"</script>";
    
    
    NSRange access_token_rang = [html rangeOfString:access];
    NSRange expires_in_rang = [html rangeOfString:expires];
    NSRange open_id_rang=[html rangeOfString:open_id];
    NSRange open_key_rang=[html rangeOfString:open_key];
    NSRange refresh_rang=[html rangeOfString:refresh];
    NSRange u_state_rang=[html rangeOfString:u_state];
    NSRange u_name_rang=[html rangeOfString:u_name];
    NSRange u_nick_rang=[html rangeOfString:u_nick];
    NSRange u_other_rang=[html rangeOfString:other];
    
    NSInteger access_tokenToexpires_in=expires_in_rang.location-access_token_rang.location;
    NSInteger expires_inToopen_id=open_id_rang.location-expires_in_rang.location;
    NSInteger open_idToopen_key=open_key_rang.location-open_id_rang.location;
    NSInteger open_keyTorefresh_token=refresh_rang.location-open_key_rang.location;
    NSInteger refreshTou_state=u_state_rang.location-refresh_rang.location;
    NSInteger u_stateTou_name=u_name_rang.location-u_state_rang.location;
    NSInteger u_nameTou_nick=u_nick_rang.location-u_name_rang.location;
    NSInteger u_nickToend=u_other_rang.location-u_nick_rang.location;
    
    NSRange access_rang = NSMakeRange(access_token_rang.location+access.length, access_tokenToexpires_in-access.length-1);
    NSRange expires_rang=NSMakeRange(expires_in_rang.location+expires.length,expires_inToopen_id-expires.length-1);
    NSRange open_rang_id=NSMakeRange(open_id_rang.location+open_id.length, open_idToopen_key-open_id.length-1);
    NSRange open_rang_key=NSMakeRange(open_key_rang.location+open_key.length,open_keyTorefresh_token-open_key.length-1);
    NSRange refreshrang=NSMakeRange(refresh_rang.location+refresh.length,refreshTou_state-refresh.length-1);
    NSRange state_rang=NSMakeRange(u_state_rang.location+u_state.length,u_stateTou_name-u_state.length-1);
    NSRange name_rang=NSMakeRange(u_name_rang.location+u_name.length,u_nameTou_nick-u_name.length-1);
    NSRange nick_rang=NSMakeRange(u_nick_rang.location+u_nick.length,u_nickToend-u_nick.length-1);
    
    self.access_token = [html substringWithRange:access_rang];
    self.expires_in=[html substringWithRange:expires_rang];
    self.openid=[html substringWithRange:open_rang_id];
    self.openkey=[html substringWithRange:open_rang_key];
    self.refresh_token=[html substringWithRange:refreshrang];
    self.state=[html substringWithRange:state_rang];
    self.name=[html substringWithRange:name_rang];
    self.nick=[html substringWithRange:nick_rang];
    
    self._array =[[NSMutableArray alloc]init];
    TokenDataBase *database=[[TokenDataBase alloc]init];
    TokenDataBaseHelp *datahelp=[[TokenDataBaseHelp alloc] init];
    [datahelp queryTotable:self._array];
    database.access_token=self.access_token;
    database.expires_in=self.expires_in;
    database.openid=self.openid;
    database.openkey=self.openkey;
    database.refresh_token=self.refresh_token;
    database.state=self.state;
    database.name=self.name;
    database.nick=self.nick;
    if ([self._array count]>0) {
        [datahelp updateTotable:database];
    }else{
        [datahelp insertTotable:database];
    }
    [database release];
    [datahelp release];
    
//    NSLog(@"access_token=>>>%@",access_token);
//    NSLog(@"expires_in=>>>%@",expires_in);
//    NSLog(@"open_id=>>>>%@",openid);
//    NSLog(@"open_key=>>>%@",openkey);
//    NSLog(@"refresh_token=>>>%@",refresh_token);
//    NSLog(@"state=>>>%@",state);
//    NSLog(@"name=>>>%@",name);
//    NSLog(@"nick=>>>%@",nick);

}
@end
