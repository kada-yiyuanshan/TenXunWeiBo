//
//  U_TZ_Controller.m
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_TZ_Controller.h"
#import "U_TZ_Cell.h"

#import "U_TZ_Parse.h"
#import "ErrorBean.h"
#import "U_TZ_Bean.h"
#import "asyncimageview.h"

@interface U_TZ_Controller ()

@end

@implementation U_TZ_Controller
@synthesize tableview;
@synthesize u_tz_array;
@synthesize token_arry;
@synthesize expandedSections;
@synthesize database,datahelp;
@synthesize progressInd;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    [self urlconnection:20];
    [self nav_Item];
}
-(void)urlconnection:(NSInteger )number
{
    [self.progressInd startAnimating];
    if (u_tz_data!=nil) {
        [u_tz_data release];
    }
    if (u_tz_url!=nil) {
        [u_tz_url release];
    }
    self.u_tz_array=[[NSMutableArray alloc] init];
    u_tz_data =[[NSMutableData alloc] init];
    self.token_arry=[[NSMutableArray alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.datahelp=[[TokenDataBaseHelp alloc]init];
    [self.datahelp queryTotable:self.token_arry];
    self.database=[self.token_arry objectAtIndex:0];
    NSString *u_info_url=[NSString stringWithFormat:@"http://open.t.qq.com/api/friends/fanslist_s?format=xml&reqnum=%d&startindex=0&install=0&mode=0&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",number,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    u_tz_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];

}
-(void)nav_Item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithTitle:@"资料" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
    item.leftBarButtonItem =u_info;
    [u_info release];
}
-(IBAction)back:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
#pragma tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.u_tz_array count];
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
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row]==[self.u_tz_array count]) {
        return 40;
    }
    return 72;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    U_TZ_Cell *cell=(U_TZ_Cell *)[tableView
                                      dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"U_TZ_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[U_TZ_Cell class]])
                cell = (U_TZ_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self.u_tz_array addObject:@"asd"];
    U_TZ_Bean *bean_=[self.u_tz_array objectAtIndex:[indexPath row]];
    if ([indexPath row]!=morecounts)
    {
        cell.f_nick.text=bean_.name;
        cell.f_zt.text=bean_.fansnum;
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
            [asyncimageview0 release];
        }
        if ([bean_.isidol isEqualToString:@"true"]) {
            [cell.f_st setTitle:@"已收听" forState:UIControlStateNormal];
            cell.f_st.userInteractionEnabled=NO;
            UIImage *tepImage = [UIImage imageNamed:@"personaldetailbg.png"];
            UIImage *normalImage = [tepImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
            [cell.f_st setBackgroundImage:normalImage forState:UIControlStateNormal];
        }else
        {
            [cell.f_st setTitle:@"+ 收听" forState:UIControlStateNormal];
            //[cell.f_st setSelected:NO];
        }
        if (bean_.sex==1) {
            [cell.f_sex setImage:[UIImage imageNamed:@"male.png"]];
        }else if(bean_.sex==2)
        {
            [cell.f_sex setImage:[UIImage imageNamed:@"female.png"]];
        }else if(bean_.sex!=1&&bean_.sex!=2)
        {
            [cell.f_sex setImage:[UIImage imageNamed:@"maleorfemale.png"]];
        }
        [cell.f_name setTitle:bean_.nick forState:UIControlStateNormal];
    }
    if ([indexPath row]==morecounts) {
        cell.f_nick.hidden=YES;
        cell.f_zt.hidden=YES;
        cell.f_head.hidden=YES;
        cell.f_sex.hidden=YES;
        cell.f_name.hidden=YES;
        cell.f_st.hidden=YES;
        cell.other_view.hidden=YES;
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
    return cell;
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
    return [u_tz_data appendData:data];
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
    
    u_tz_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *near_returnString = [[NSString alloc] initWithData:u_tz_data encoding:NSUTF8StringEncoding];
    [U_TZ_Parse parseArrXML:near_returnString commentArr:listdata errorBean:error];
    self.u_tz_array=listdata;
    morecounts=error.counts;
    pages=error.pages;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [super dealloc];
    [tableview release];
    [u_tz_array release];
    [token_arry release];
    //[expandedSections release];
    [database release];
    [datahelp release];
    [progressInd release];
}

@end
