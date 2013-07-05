//
//  ViewController.m
//  WeiBo
//
//  Created by hcui on 13-6-26.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "ViewController.h"
#import "Oauth_String.h"
#import "Su_HomeController.h"

#define APPKEY "801357018"
#define APPSECRET "2beafa718157ce31481cb55ddbc86db3"
#define APPURL "http://www.tencent.com/zh-cn/"
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
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    Oauth_String *oauth=[[Oauth_String alloc]init];
    static int a=0;
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *js = @"document.documentElement.innerHTML";
    NSString *html = [self.webview stringByEvaluatingJavaScriptFromString:js];

    if ([html isEqualToString:@""]) {
    }else if(![html isEqualToString:@""]){
        if (a==1) {
            [oauth initHtmlString:html];
            Su_HomeController *home=[[Su_HomeController alloc] initWithNibName:@"Su_HomeController" bundle:nil];
            [self presentViewController:home animated:YES completion:nil];
            [home release];
        }
        a++;
    }
    [oauth release];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	NSString* errorString = [NSString stringWithFormat:
							 @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
							 error.localizedDescription];
	[self.webview loadHTMLString:errorString baseURL:nil];
}

@end
