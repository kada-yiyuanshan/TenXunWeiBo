//
//  ViewController.m
//  WeiBo
//
//  Created by hcui on 13-6-26.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "ViewController.h"

#define APPKEY "801357018"
#define APPSECRET "2beafa718157ce31481cb55ddbc86db3"
#define APPURL "http://www.tencent.com/zh-cn/index.shtml"
@interface ViewController ()

@end

@implementation ViewController
@synthesize webview;

-(void)dealloc
{
    [super dealloc];
    [webview release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *product_url = [NSString stringWithFormat:@"https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=%s&response_type=token&redirect_uri=%s?wap=2",APPKEY,APPURL];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:product_url]]];
}

@end
