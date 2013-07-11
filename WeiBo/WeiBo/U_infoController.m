//
//  U_infoController.m
//  WeiBo
//
//  Created by hcui on 13-7-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_infoController.h"
#import "U_info_Bean.h"
#import "asyncimageview.h"
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import "ErrorBean.h"

@interface U_infoController ()

@end

@implementation U_infoController


@synthesize im_bg;
@synthesize nick,introduction;
@synthesize info_arry;
@synthesize updata_info_arry;
@synthesize token_arry;
//@synthesize progressInd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"修改资料";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    head_view.layer.cornerRadius=8;
    head_view.layer.masksToBounds = YES;
    [self setBarItem];
    [self info_data];
    [self introduction_text_hi];
    updata_info_arry=[[NSMutableArray alloc] init];
}
-(void)info_data
{
    U_info_Bean *infos=[self.info_arry objectAtIndex:0];
    self.nick.text=infos.u_nick;
    self.introduction.text=infos.introduction;
    if ([infos.u_head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,62,62)];
        [head_view addSubview:head];
        [head release];
    }else{
    AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,69.0, 66.0)];
    
    NSString *a=[NSString stringWithFormat:@"%@/50",infos.u_head];
    [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
    [head_view addSubview:asyncimageview0];
    [asyncimageview0 release];
    }
}
-(void)setBarItem
{
    self.im_bg.layer.cornerRadius=8;
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"资料" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    UIBarButtonItem *save=[[UIBarButtonItem alloc] initWithTitle:@"保存 " style:UIBarButtonItemStyleBordered target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem =save;
    [u_info release];
    [save release];
}
-(IBAction)save:(id)sender
{
    NSString *user_nick;
    NSString *user_intro;
    TokenDataBase *database=[[TokenDataBase alloc] init];
    TokenDataBaseHelp *datahelp=[[TokenDataBaseHelp alloc]init];
    self.token_arry=[[NSMutableArray alloc] init];
    [datahelp queryTotable:self.token_arry];
    database=[self.token_arry objectAtIndex:0];
    U_info_Bean *infos=[self.info_arry objectAtIndex:0];
    if ([nick.text isEqualToString:@""]) {
        user_nick=infos.u_nick;
        user_intro=infos.introduction;
    }else
    {
        user_nick=nick.text;
        user_intro=introduction.text;
    }
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/user/update"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&nick=%@&sex=%@&year=%@&month=%@&day=%@&countrycode=%@&provincecode=%@&citycode=%@&introduction=%@&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",user_nick,infos.sex,infos.birth_year,infos.birth_month,infos.birth_day ,infos.country_code,infos.province_code,infos.city_code,user_intro,database.access_token,database.openid];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"PHP-SDK OAuth2.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    updata_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    updata_info_data =[[NSMutableData alloc] init];
    [database release];
    [datahelp release];
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)introduction_text_hi
{
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetext3 = [introduction.text sizeWithFont:introduction.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    introduction.frame=CGRectMake(introduction.frame.origin.x, introduction.frame.origin.y,280, labelSizetext3.height+40);
}
-(IBAction)Textview_edit_bg:(id)sender
{
    [self.nick resignFirstResponder];
    [self.introduction resignFirstResponder];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self introduction_text_hi];
    [self moveView:textView leaveView:NO];
}
-(void)textViewDidChange:(UITextView *)textView
{
    [self introduction_text_hi];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self introduction_text_hi];
    [self moveView:textView leaveView:YES];
}
#pragma make  keyboard

- (void)moveView:(UITextView *)textField leaveView:(BOOL)leave
{
    float screenHeight = 480; //screen size
    float keyboardHeight = 216; //keyboard size
    float statusBarHeight,NavBarHeight,textFieldOriginY,textFieldFromButtomHeigth;
    int margin;
    statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    NavBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    CGRect fieldFrame=[self.view convertRect:textField.frame fromView:self.view];
    textFieldOriginY = fieldFrame.origin.y;
    
    textFieldFromButtomHeigth = screenHeight - statusBarHeight-50 - textFieldOriginY;
    
    if(!leave) {
        if(textFieldFromButtomHeigth < keyboardHeight) {
            margin = keyboardHeight - textFieldFromButtomHeigth;
            keyBoardMargin_ = margin;
        } else {
            margin= 0;
            keyBoardMargin_ = 0;
        }
    }
    const float movementDuration = 0.4f;
    
    int movement = (leave ? keyBoardMargin_ : -margin);

    [UIView beginAnimations: @"textFieldAnim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [updata_info_data appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
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
    
    updata_info_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//         [self.progressInd stopAnimating];
//          self.progressInd.hidden=YES;
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
-(void)dealloc
{
    [super dealloc];
    [im_bg release];
    [nick release];
    [introduction release];
    [updata_info_arry release];
    [token_arry release];
//    [progressInd release];
    
}
@end
