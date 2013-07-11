//
//  Ground_People_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Ground_People_Controller.h"
#import "People_Cell.h"
#import "ErrorBean.h"
#import "Around_Bean.h"
#import "Around_Parse.h"
#import "asyncimageview.h"

@interface Ground_People_Controller ()

@end

@implementation Ground_People_Controller
@synthesize tableview;
@synthesize latitude,longitude;
@synthesize around_array;
@synthesize database,databasehelp;
@synthesize token_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [tableview release];
    [latitude release];
    [longitude release];
    [database release];
    [databasehelp release];
    [token_array release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self nav_Item];
    
    
    self.around_array=[[NSMutableArray alloc] init];
    self.databasehelp =[[TokenDataBaseHelp alloc] init];
    self.database =[[TokenDataBase alloc] init];
    self.token_array =[[NSMutableArray alloc] init];
    [self.databasehelp queryTotable:self.token_array];
    self.database=[self.token_array objectAtIndex:0];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self around_people_connection:self.latitude longitude:self.longitude gender:0 req_num:25];
}
-(IBAction)refresh:(id)sender
{
    [self around_people_connection:self.latitude longitude:self.longitude gender:0 req_num:50];
}
-(void)around_people_connection:(NSString *)lat longitude:(NSString *)longit gender:(NSInteger )sex req_num:(NSInteger )num
{
    [indicatorview startAnimating];
    if (around_data!=nil) {
        [around_data release];
    }
    if (around_url!=nil) {
        [around_url release];
    }
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/lbs/get_around_people"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&longitude=%@&latitude=%@&pageinfo=&pagesize=%d&gender=%d&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",longit,lat,num,sex,database.access_token,database.openid];
   // NSLog(@"url===>%@",info_url);
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"PHP-SDK OAuth2.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    around_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    around_data =[[NSMutableData alloc] init];
}
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma make TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.around_array count];
   // NSLog(@"count====>%d",counts);
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    People_Cell *cell=(People_Cell *)[tableView
                                      dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"People_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[People_Cell class]])
                cell = (People_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Around_Bean *bean=[self.around_array objectAtIndex:[indexPath row]];
    if ([bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.head_view addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.head_view addSubview:asyncimageview0];
        cell.head_view.layer.cornerRadius=8;
        cell.head_view.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
    cell.nick.text=bean.nick;
    cell.origtext.text=bean.origtext;
    NSString *str=bean.timestamp;
    NSTimeInterval time=[str doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM月dd日"];
    NSString *day_data = [outputFormatter stringFromDate:detaildate];
    cell.time.text=day_data;

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(connection==around_url)
    {
        return [around_data appendData:data];
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
    
    around_url=nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    
    
    if(connection==around_url)
    {
        NSMutableArray *listdata=[[NSMutableArray alloc] init];
        NSString *return_info_String = [[NSString alloc] initWithData:around_data encoding:NSUTF8StringEncoding];
        [Around_Parse parseArrXML:return_info_String commentArr:listdata errorBean:error];
       //  NSLog(@"retu=====>%@",return_info_String);
        self.around_array=listdata;
        [self.tableview reloadData];
        [listdata release];
    }
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"广场" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    UIBarButtonItem *refresh_=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem=refresh_;
    [u_info release];
    [refresh_ release];
}


@end
