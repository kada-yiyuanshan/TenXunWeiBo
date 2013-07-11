//
//  U_ST_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_ST_Controller.h"
#import "ErrorBean.h"
#import "U_ST_Cell.h"
#import "U_ST_Parse.h"
#import "U_ST_Bean.h"
#import "asyncimageview.h"

@interface U_ST_Controller ()

@end

@implementation U_ST_Controller

@synthesize tableview;
@synthesize u_st_array,token_arry;
@synthesize database,datahelp;
@synthesize expandedSections;
@synthesize progressInd;


-(void)dealloc
{
    [super dealloc];
    [tableview release];
    [database release];
    [datahelp release];
    [u_st_array release];
    [token_arry release];
    [progressInd release];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title=@"收听";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }

    [self nav_Item];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self urlconnection:20];
}
-(void)urlconnection:(NSInteger )number
{
    [self.progressInd startAnimating];
    if (u_st_data!=nil) {
        [u_st_data release];
    }
    if (u_st_url!=nil) {
        [u_st_url release];
    }
    self.token_arry=[[NSMutableArray alloc] init];
    self.u_st_array=[[NSMutableArray alloc] init];
    u_st_data=[[NSMutableData alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.datahelp=[[TokenDataBaseHelp alloc]init];
    [self.datahelp queryTotable:self.token_arry];
    self.database=[self.token_arry objectAtIndex:0];
    NSString *u_info_url=[NSString stringWithFormat:@"http://open.t.qq.com/api/friends/idollist_s?format=xml&reqnum=%d&startindex=0&install=0&mode=0&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",number,database.access_token,database.openid];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    u_st_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"资料" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem =u_info;
    [u_info release];
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.u_st_array count];
    if (counts!=morecounts) {
        return  counts;
    }
    if (counts==morecounts) {
        return counts+1;
    }
    if(pages==1)
    {
        return counts;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==[self.u_st_array count]) {
        return 40;
    }
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    U_ST_Cell *cell=(U_ST_Cell *)[tableView
                                  dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"U_ST_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[U_ST_Cell class]])
                cell = (U_ST_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self.u_st_array addObject:@"asd"];
    U_ST_Bean *bean_=[self.u_st_array objectAtIndex:[indexPath row]];
   
    if ([indexPath row]!=morecounts)
    {
        
        //[cell.f_name.titleLabel setText:bean_.nick];
        cell.f_nick.text=bean_.name;
        if ([bean_.head isEqualToString:@""]) {
            UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
            [head setFrame:CGRectMake(0,0,50,50)];
            [cell.f_head addSubview:head];
            [head release];
        }else{
            AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
            NSString *a=[NSString stringWithFormat:@"%@/50",bean_.head];
            [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
            [cell.f_head addSubview:asyncimageview0];
            cell.f_head.layer.cornerRadius=8;
            cell.f_head.layer.masksToBounds = YES;
            [asyncimageview0 release];
        }
        if ([bean_.isidol isEqualToString:@"true"]) {
            [cell.f_st setTitle:@"- 取消" forState:UIControlStateNormal];
        }else
        {
            [cell.f_st setTitle:@"已收听" forState:UIControlStateNormal];
            cell.f_st.userInteractionEnabled=NO;
            UIImage *tepImage = [UIImage imageNamed:@"personaldetailbg.png"];
            UIImage *normalImage = [tepImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
            [cell.f_st setBackgroundImage:normalImage forState:UIControlStateNormal];
        }
        [cell.f_name setTitle:bean_.nick forState:UIControlStateNormal];
    }
    if ([indexPath row]==morecounts) {
        cell.f_nick.hidden=YES;
        cell.f_head.hidden=YES;
        cell.f_name.hidden=YES;
        cell.f_st.hidden=YES;
        if (pages!=1) {
            cell.textLabel.text=@"                             加载更多";
        }else if(pages==1)
        {
            cell.textLabel.text=@"                        用户已经加载完成";
        }
        
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    [cell.f_st addTarget:self action:@selector(cancle:) forControlEvents:UIControlEventTouchUpInside];
    cell.f_st.tag=[indexPath row];
   return cell;
}
-(IBAction)cancle:(id)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableview indexPathForCell:cell];
    U_ST_Bean *bean_=[self.u_st_array objectAtIndex:[indexPath row]];
    [self cancel_openid:bean_.openid];
    [self urlconnection:20];
}
-(void)cancel_openid:(NSString *)u_id
{
    [self.progressInd startAnimating];
    if (cancel_st_url!=nil) {
        [cancel_st_url release];
    }
    if (cancel_st_data!=nil) {
        [cancel_st_data release];
    }
    
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/friends/del"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&fopenid=%@&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",u_id,database.access_token,database.openid];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"xxxxx" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    cancel_st_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    cancel_st_data =[[NSMutableData alloc] init];
    [self urlconnection:20];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    if (indexPath.row == morecounts) {
        [expandedSections addIndex:[indexPath section]];
        cell.textLabel.text=@"                          正在加载...";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self urlconnection:morecounts+20];
    }
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (u_st_url==connection) {
        
    return [u_st_data appendData:data];
    }
    
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
    
    u_st_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    if (u_st_url==connection) {
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *near_returnString = [[NSString alloc] initWithData:u_st_data encoding:NSUTF8StringEncoding];
    
    [U_ST_Parse parseArrXML:near_returnString commentArr:listdata errorBean:error];
    self.u_st_array=listdata;
    morecounts=error.counts;
    pages=error.pages;
    [self.tableview reloadData];
    [listdata release];
    [error release];
    }
    [self.progressInd stopAnimating];
    self.progressInd.hidden=YES;
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

@end
