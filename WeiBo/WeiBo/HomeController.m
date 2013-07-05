//
//  HomeController.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "HomeController.h"
#import "Oauth_String.h"
#import "H_info_Bean.h"
#import "H_info_Parse.h"
#import "ErrorBean.h"

@interface HomeController ()

@end

@implementation HomeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"主页", @"主页");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self set_item];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self url_connection];
}
-(void)url_connection
{
    NSString *url=[NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/home_timeline?format=xml&pageflag=0&pagetime=0&reqnum=4&type=0&contenttype=0&oauth_consumer_key=801058005&access_token=92b9cbc29f59ba3c089183dd3c5c0566&openid=68FE75C680FE853EB327F420F3DE8F3C&clientip=192.168.1.6&oauth_version=2.a&scope=all"];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    h_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    h_info_data =[[NSMutableData alloc] init];
}
-(void)set_item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    self.navigationItem.rightBarButtonItem=u_info;
    [u_info release];
}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [h_info_data appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        [self handleError:error];
    }
    
    h_info_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *returnString = [[NSString alloc] initWithData:h_info_data encoding:NSUTF8StringEncoding];
    [H_info_Parse parseArrXML:returnString commentArr:listdata errorBean:error];
    //NSLog(@"return_string==>%@",returnString);
    [listdata release];
    [error release];
}
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"网络连接异常"
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end
