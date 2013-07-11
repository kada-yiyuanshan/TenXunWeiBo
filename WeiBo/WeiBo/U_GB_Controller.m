//
//  U_GB_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_GB_Controller.h"

#import "ErrorBean.h"
#import "U_OrigText_Parse.h"
#import "U_Orig_Cell.h"
#import "U_OrigText_Bean.h"

#define APPKEY "801357018"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface U_GB_Controller ()

@end

@implementation U_GB_Controller
@synthesize tableview;
@synthesize tableviewcell;
@synthesize orig_info_arry,token_arry;
@synthesize database,datahelp;
@synthesize progressInd;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"我的广播";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"资料" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    [u_info release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.progressInd startAnimating];
    if (orig_info_url!=nil) {
        [orig_info_url release];
    }
    if (orig_info_data!=nil) {
        [orig_info_data release];
    }
    self.token_arry=[[NSMutableArray alloc] init];
    self.orig_info_arry=[[NSMutableArray alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.datahelp=[[TokenDataBaseHelp alloc]init];
    [datahelp queryTotable:self.token_arry];
    database=[self.token_arry objectAtIndex:0];
    NSString *u_info_url = [NSString stringWithFormat:@"http://open.t.qq.com/api/statuses/broadcast_timeline?format=xml&pageflag=0&pagetime=0&reqnum=20&lastid=0&type=0x1&contenttype=0&oauth_consumer_key=%s&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",APPKEY,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    orig_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    orig_info_data =[[NSMutableData alloc] init];
}

#pragma tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orig_info_arry count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    U_Orig_Cell *cell=(U_Orig_Cell *)[tableView
                                    dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"U_Orig_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[U_Orig_Cell class]])
                cell = (U_Orig_Cell *)oneObject;
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    U_OrigText_Bean *_bean=[self.orig_info_arry objectAtIndex:[indexPath row]];
    [cell.u_nick_button setTitle:_bean.nick forState:UIControlStateNormal];
    U_Orig_Cell *_cell=[[U_Orig_Cell alloc] init];
    [_cell User_nick:_bean.nick Origtext:_bean.origtext Origtextfrom:[NSString  stringWithFormat:@"来自 %@",_bean.origfrom]];
    NSString *str=_bean.origtime;
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM月dd日"];
    NSString *day_data = [outputFormatter stringFromDate:detaildate];
    cell.time_lable.text=day_data;
    cell.origtextfrom_lable.text=[NSString  stringWithFormat:@"来自 %@",_bean.origfrom];
    cell.origtext_lable.text=_bean.origtext;
   return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [orig_info_data appendData:data];
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
    
    orig_info_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *near_returnString = [[NSString alloc] initWithData:orig_info_data encoding:NSUTF8StringEncoding];
    [U_OrigText_Parse parseArrXML:near_returnString commentArr:listdata errorBean:error];
    self.orig_info_arry=listdata;
    [self.tableview reloadData];
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
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


-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc
{
    [super dealloc];
    [tableview release];
    [tableviewcell release];
    [orig_info_arry release];
    [token_arry release];
    [database release];
    [datahelp release];
    //[progressInd release];
}
@end
