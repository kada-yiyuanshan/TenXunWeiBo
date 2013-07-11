//
//  U_DateController.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_DateController.h"

#import "ErrorBean.h"
#import "U_info_Parse.h"
#import "U_info_Bean.h"
#import "asyncimageview.h"
#import "U_infoController.h"
#import "U_GB_Controller.h"
#import "U_TZ_Controller.h"
#import "U_ST_Controller.h"

#define APPKEY "801357018"
#define APPSECRET "2beafa718157ce31481cb55ddbc86db3"
#define APPURL "http://www.tencent.com/zh-cn/"
@interface U_DateController ()

@end

@implementation U_DateController
@synthesize head_bg,head_view;
@synthesize tableview,edit_tableviewcell,other_tableviewcell;
@synthesize u_name,u_nick;
@synthesize edit_bt,gbo,tzh,sti,wxc;
@synthesize tzh_nub,sti_nub,gbo_nub,wxc_nub;
@synthesize token_arry,info_arry;
@synthesize database,datahelp;
@synthesize progressInd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"资料", @"资料");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.head_view.layer.cornerRadius=8;
    self.head_view.layer.masksToBounds = YES;
    self.datahelp =[[TokenDataBaseHelp alloc]init];
    self.database =[[TokenDataBase alloc] init];
    self.token_arry=[[NSMutableArray alloc] init];
    self.info_arry=[[NSMutableArray alloc] init];
    UIBarButtonItem *setting=[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.rightBarButtonItem=setting;
    [setting release];
    
    [self button_bg];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self have_Token];
}
-(void)have_Token
{
    [self.progressInd startAnimating];
    if (user_info_url!=nil) {
        [user_info_url release];
    }
    if (user_info_data!=nil) {
        [user_info_data release];
    }
    [datahelp queryTotable:self.token_arry];
    database=[self.token_arry objectAtIndex:0];
    NSString *u_info_url = [NSString stringWithFormat:@"https://open.t.qq.com/api/user/info?format=xml&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=170.1.1.1&oauth_version=2.a&scope=all",database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    user_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    user_info_data =[[NSMutableData alloc] init];
}
-(void)button_bg
{
    [self.edit_bt setImage:[UIImage imageNamed:@"wb_bg_chute.png"] forState:UIControlStateSelected];
    [self.gbo setImage:[UIImage imageNamed:@"wb_box_information_press01.png"] forState:UIControlStateSelected];
    [self.tzh setImage:[UIImage imageNamed:@"wb_box_information_press03.png"] forState:UIControlStateSelected];
    [self.sti setImage:[UIImage imageNamed:@"wb_box_information_press04.png"] forState:UIControlStateSelected];
    [self.wxc setImage:[UIImage imageNamed:@"wb_box_information_press02.png"] forState:UIControlStateSelected];

}
-(IBAction)edit_bt:(id)sender
{
    U_infoController *info=[[U_infoController alloc] initWithNibName:@"U_infoController" bundle:nil];
    info.info_arry=self.info_arry;
    info.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:info animated:YES];
    [info release];
}
-(IBAction)gbo_bt:(id)sender
{
    U_GB_Controller *u_gb=[[U_GB_Controller alloc] initWithNibName:@"U_GB_Controller" bundle:nil];
    
    u_gb.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:u_gb animated:YES];
    [u_gb release];
}

-(IBAction)sti_bt:(id)sender
{
    U_ST_Controller *u_st=[[U_ST_Controller alloc] initWithNibName:@"U_ST_Controller" bundle:nil];
    u_st.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:u_st animated:YES];
    [u_st release];
}

-(IBAction)wxc_bt:(id)sender
{

}

-(IBAction)tzh_bt:(id)sender
{
    U_TZ_Controller *info=[[U_TZ_Controller alloc] initWithNibName:@"U_TZ_Controller" bundle:nil];
    info.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:info animated:YES];
    [info release];
}

#pragma mark -
#pragma mark Table Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 1;
    }else if(section==2){
        return 2;
    }else if(section==3){
        return 2;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    NSInteger ind= [indexPath section];
    NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    cell.backgroundColor=[UIColor whiteColor];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:TableSampleIdentifier] autorelease];
    }
    if (ind==0) {
        if ([info_arry count]>0) {
            U_info_Bean *bean=[self.info_arry objectAtIndex:0];
            self.u_nick.text=bean.u_nick;
            self.u_name.text=[NSString stringWithFormat:@"(@%@)",bean.u_name];
            if ([bean.u_head isEqualToString:@""]) {
                UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
                [head setFrame:CGRectMake(0,0,69,69)];
                [self.head_view addSubview:head];
                [head release];
            }else{

            AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,69.0, 66.0)];
            asyncimageview0.layer.cornerRadius=8;
            NSString *a=[NSString stringWithFormat:@"%@/50",bean.u_head];
            [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
            [self.head_view addSubview:asyncimageview0];
            [asyncimageview0 release];
            }
        }
        edit_tableviewcell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell=edit_tableviewcell;
    }else if(ind==1)
    {
        if ([info_arry count]>0) {
            U_info_Bean *bean=[self.info_arry objectAtIndex:0];
            self.gbo_nub.text=bean.tweetnum;
            self.tzh_nub.text=bean.fansnum;
            self.sti_nub.text=bean.idolnum;
            self.wxc_nub.text=bean.favnum;
        }
        cell=other_tableviewcell;
    }else{
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger e=[indexPath section];
    if (e==0 ) {
        return 30;
    }else if(e==1)
    {
        return 60;
    }else if(e==2){
        return 30;
    }
    return 30;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [user_info_data appendData:data];
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
    
    user_info_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
     NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *near_returnString = [[NSString alloc] initWithData:user_info_data encoding:NSUTF8StringEncoding];
    [U_info_Parse parseArrXML:near_returnString commentArr:listdata errorBean:error];
   
    self.info_arry=listdata;
    [self.tableview reloadData];
     [progressInd stopAnimating];
     progressInd.hidden=YES;
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


-(void)dealloc
{
    [super dealloc];
    [head_view release];
    [head_bg release];
    [tableview release];
    [edit_tableviewcell release];
    [other_tableviewcell release];
    [u_name release];
    [u_nick release];
    [edit_bt release];
    [gbo_nub release];
    [gbo release];
    [tzh_nub release];
    [tzh release];
    [sti_nub release];
    [sti release];
    [wxc_nub release];
    [wxc release];
    [token_arry release];
    [info_arry release];
    [database release];
    [datahelp release];
    [progressInd release];
}

@end
