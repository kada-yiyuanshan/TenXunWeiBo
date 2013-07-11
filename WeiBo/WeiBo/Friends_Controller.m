//
//  Friends_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Friends_Controller.h"
#import "ErrorBean.h"
#import "Friends_Bean.h"
#import "Friends_Parse.h"
#import "asyncimageview.h"

@interface Friends_Controller ()

@end

@implementation Friends_Controller
@synthesize tableview;
@synthesize friends_array;
@synthesize database,databasehelp;
@synthesize token_array;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title=@"发现朋友";
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [tableview release];
    [friends_array release];
    [database release];
    [databasehelp release];
    [token_array release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self nav_Item];
    self.friends_array=[[NSMutableArray alloc] init];
    self.databasehelp =[[TokenDataBaseHelp alloc] init];
    self.database =[[TokenDataBase alloc] init];
    self.token_array =[[NSMutableArray alloc] init];
    [self.databasehelp queryTotable:self.token_array];
    self.database=[self.token_array objectAtIndex:0];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self friend_connection];
}
-(void)friend_connection
{
    [progressInd startAnimating];
    if (friends_url!=nil) {
        [friends_url release];
    }
    if (friends_data!=nil) {
        [friends_data release];
    }
    [databasehelp queryTotable:self.token_array];
    database=[self.token_array objectAtIndex:0];
    NSString *u_info_url = [NSString stringWithFormat:@"https://open.t.qq.com/api/other/kownperson?format=xml&reqnum=50&startindex=0&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    friends_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    friends_data =[[NSMutableData alloc] init];

}

#pragma MAKE TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    cell.backgroundColor=[UIColor whiteColor];
    if(cell==nil)
    {
        cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:TableSampleIdentifier] autorelease];
    }
    cell.imageView.backgroundColor=[UIColor redColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(15,5,50,50)];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(80,9,100,30)];
    view.layer.cornerRadius=8;
    view.layer.masksToBounds = YES;
    lable.font = [UIFont systemFontOfSize:15];
    lable.backgroundColor=[UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Friends_Bean *bean=[self.friends_array objectAtIndex:[indexPath section]];
    if ([bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [view addSubview:head];

        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [view addSubview:asyncimageview0];
        [asyncimageview0 release];
    }
    lable.text=bean.nick;

    [cell addSubview:view];
    [cell addSubview:lable];
    [view release];
    [lable release];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 60;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.friends_array count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}


#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    return [friends_data appendData:data];
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
    
    friends_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *near_returnString = [[NSString alloc] initWithData:friends_data encoding:NSUTF8StringEncoding];
   [Friends_Parse parseArrXML:near_returnString commentArr:listdata errorBean:error];
      //NSLog(@"retu=====>%@",near_returnString);
    self.friends_array=listdata;
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
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"广场" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    [u_info release];
}
-(IBAction)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
