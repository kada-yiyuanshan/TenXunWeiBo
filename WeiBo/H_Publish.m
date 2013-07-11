//
//  H_Publish.m
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "H_Publish.h"
#import "Return_Bean.h"
#import "Return_Pares.h"
@interface H_Publish ()

@end

@implementation H_Publish
@synthesize publish_text;
@synthesize publish_array;
@synthesize token_array;
@synthesize database;
@synthesize database_help;
@synthesize return_string;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
    [publish_text release];
    [database release];
    [database_help release];
    [publish_array release];
    [token_array release];
    [return_string release];
}
-(IBAction)bg:(id)sender
{
    [publish_text resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self set_item];
    self.token_array=[[NSMutableArray alloc] init ];
    self.publish_array=[[NSMutableArray alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.database_help=[[TokenDataBaseHelp alloc]init];
    [self.database_help queryTotable:self.token_array];
    self.database=[self.token_array objectAtIndex:0];
}
-(void)send_publish
{
    [indicatorview startAnimating];
    if (publish_data!=nil) {
        [publish_data release];
    }
    if (publish_url!=nil) {
        [publish_url release];
    }
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/t/add"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&content=%@&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",self.publish_text.text,database.access_token,database.openid];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"PHP-SDK OAuth2.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    publish_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    publish_data =[[NSMutableData alloc] init];
}

-(void)set_item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonSystemItemSave target:self action:@selector(send_publish)];
    item.rightBarButtonItem=u_info;
    UIBarButtonItem *refresh=[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonSystemItemSave  target:self action:@selector(cancel:)];
    item.leftBarButtonItem=refresh;
    [u_info release];
    [refresh release];
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==publish_url) {
        return [publish_data appendData:data];
    }
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
    
    publish_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    Return_Bean *return_bean=[[Return_Bean alloc] init];
    if (connection==publish_url) {
        NSMutableArray *return_data=[[NSMutableArray alloc] init];
        NSString *return_str= [[NSString alloc] initWithData:publish_data encoding:NSUTF8StringEncoding];
//        NSLog(@"return_str=====>%@",return_str);
        [Return_Pares parseArrXML:return_str commentArr:return_data return_bean:return_bean];
        self.return_string=return_bean.state;
        if ([self.return_string isEqualToString:@"ok"]) {
            self.publish_text.text=@"";
            [self handlereturn:@"发表成功"];
        }else
        {
            [self handlereturn:@"发表失败"];
        }

        [return_data release];
    }
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
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
- (void)handlereturn:(NSString *)Message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
														message:Message
													   delegate:nil
											  cancelButtonTitle:@"确定"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

-(IBAction)cancel:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
