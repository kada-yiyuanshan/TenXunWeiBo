//
//  Oauth_String.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Oauth_String : NSObject
{
    NSString *access_token;
    NSString *expires_in;
    NSString *openid;
    NSString *openkey;
    NSString *refresh_token;
    NSString *state;
    NSString *name;
    NSString *nick;
    NSMutableArray *_array;
}
@property(retain,nonatomic) NSMutableArray *_array;
@property(retain,nonatomic) NSString *access_token;
@property(retain,nonatomic) NSString *expires_in;
@property(retain,nonatomic) NSString *openid;
@property(retain,nonatomic) NSString *openkey;
@property(retain,nonatomic) NSString *refresh_token;
@property(retain,nonatomic) NSString *state;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *nick;
-(void) initHtmlString:(NSString *)html;
@end
