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
#import "H_View_Cell.h"
#import "asyncimageview.h"
#import "Return_Bean.h"
#import "Return_Pares.h"
#import "H_Publish.h"

@interface HomeController ()

@end

@implementation HomeController
@synthesize database,database_array,databasehelp;
@synthesize tableview,h_array;
@synthesize return_string;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"主页", @"主页");
    }
    return self;
}
-(void)dealloc
{
    [super dealloc];
    [database release];
    [database_array release];
    [databasehelp release];
    [tableview release];
    [h_array release];
    [return_string release];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self set_item];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.databasehelp=[[TokenDataBaseHelp alloc] init];
    self.database=[[TokenDataBase alloc] init];
    self.database_array=[[NSMutableArray alloc] init];
    self.h_array =[[NSMutableArray alloc] init];
    
    [self.databasehelp queryTotable:self.database_array];
    self.database=[self.database_array objectAtIndex:0];
    [self url_connection:30];
   
}
-(void)url_connection:(NSInteger )num
{
    [indicatorview startAnimating];
    if (h_info_data!=nil) {
        [h_info_data release];
    }
    if (h_info_url!=nil) {
        [h_info_url release];
    }

    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/statuses/home_timeline?format=xml&pageflag=0&pagetime=0&reqnum=%d&type=0x1&contenttype=1&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",num,database.access_token,database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    h_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    h_info_data =[[NSMutableData alloc] init];
    //NSLog(@"url==>%@",url);
}
-(void)set_item
{
    UIBarButtonItem *u_info=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(publish:)];
    self.navigationItem.rightBarButtonItem=u_info;
    UIBarButtonItem *refresh=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.leftBarButtonItem=refresh;
    [u_info release];
    [refresh release];
}
-(IBAction)publish:(id)sender
{
    H_Publish *publish=[[H_Publish alloc] initWithNibName:@"H_Publish" bundle:nil];
    [self presentModalViewController:publish animated:YES];
    [publish release];
}
-(IBAction)refresh:(id)sender
{
    [self url_connection:20];
}
-(IBAction)repeat:(id)sender
{
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath * indexPath = [self.tableview indexPathForCell:cell];
    H_info_Bean *bean_=[self.h_array objectAtIndex:[indexPath row]];
    [self repest_String:@"测试" id_:bean_.orig_id];
}
-(void)repest_String:(NSString *)content id_:(NSString *)orig_id
{
    [indicatorview startAnimating];
    if (zf_info_data!=nil) {
        [zf_info_data release];
    }
    if (zf_info_url!=nil) {
        [zf_info_url release];
    }
    NSString *u_info_url=[NSString stringWithFormat:@"https://open.t.qq.com/api/t/re_add"];
    NSString *info_url=[NSString stringWithFormat:@"format=xml&content=%@&reid=%@&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",content,orig_id,database.access_token,database.openid];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:u_info_url]];
    [urlRequest setHTTPMethod:@"post"];
    [urlRequest setValue:@"PHP-SDK OAuth2.0" forHTTPHeaderField:@"User-Agent"];
    [urlRequest setHTTPBody:[info_url dataUsingEncoding:NSUTF8StringEncoding ]];
    zf_info_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    zf_info_data =[[NSMutableData alloc] init];
}

#pragma make TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int counts=[self.h_array count];
 
    return counts;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    
    H_View_Cell *cell=(H_View_Cell *)[tableView
                                  dequeueReusableCellWithIdentifier: TableSampleIdentifier];
    
    if(cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"H_View_Cell"
                                                     owner:self options:nil];
        for (id oneObject in nib)
            if ([oneObject isKindOfClass:[H_View_Cell class]])
                cell = (H_View_Cell *)oneObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self.h_array addObject:@"asd"];
    H_info_Bean *info_bean=[self.h_array  objectAtIndex:[indexPath row]];

    [cell.nick setTitle:info_bean.nick forState:UIControlStateNormal];
    cell.origtextfrom.text=[NSString stringWithFormat:@"来自 %@",info_bean.from];
    cell.origtext.text=info_bean.origtext;
    cell.time.text=[self Todate:info_bean.timestamp];
    if ([info_bean.head isEqualToString:@""]) {
        UIImageView *head=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"defaultThunmbnail.png" ]];
        [head setFrame:CGRectMake(0,0,50,50)];
        [cell.head addSubview:head];
        [head release];
    }else{
        AsyncImageView *asyncimageview0= [[AsyncImageView alloc] initWithFrame:CGRectMake(0,0,50.0, 50.0)];
        NSString *a=[NSString stringWithFormat:@"%@/50",info_bean.head];
        [asyncimageview0 loadImageFromURL:[NSURL URLWithString:a] land:NO];
        [cell.head addSubview:asyncimageview0];
        cell.head.layer.cornerRadius=8;
        cell.head.layer.masksToBounds = YES;
        [asyncimageview0 release];
    }
    [cell.repeat addTarget:self action:@selector(repeat:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
-(NSString *)Todate:(NSString *)data
{
    NSString *someday;
    NSTimeInterval time=[data doubleValue];
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *outputFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *before_time = [outputFormatter stringFromDate:detaildate];
    NSString *before = [before_time substringToIndex:12];
    someday=before_time;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSString *datetime = [formatter stringFromDate:[NSDate date]];
    [formatter release];
    NSString *now_time = [[NSString stringWithFormat:@"%@",datetime] retain];
   // NSLog(@"nowtime===>%@",nowTime);
    NSString *now=[now_time substringToIndex:12];
    if ([before isEqualToString:now]) {
        NSLog(@"今天");
    }else
    {
        NSRange beforerang = NSMakeRange(8, 10);
        NSString * beforeRang = [before_time substringWithRange:beforerang];
        NSString * nowRang = [now_time substringWithRange:beforerang];
        [outputFormatter setDateFormat:@"HH:mm"];
        NSString *ang=[outputFormatter stringFromDate:detaildate];
        if ([nowRang integerValue]-[beforeRang integerValue]==1) {
            someday=[NSString stringWithFormat:@"昨天 %@",ang];
        }else if ([nowRang integerValue]-[beforeRang integerValue]==2) {
            someday=[NSString stringWithFormat:@"前天 %@",ang];
        }else
        {
            [outputFormatter setDateFormat:@"MM月dd日"];
            NSString *ang=[outputFormatter stringFromDate:detaildate];
            someday=ang;
        }
    }
    
    return someday;
}

#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==h_info_url) {
    return [h_info_data appendData:data];
    }
    if (connection==zf_info_url) {
        return [zf_info_data appendData:data];
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
    
    h_info_url = nil;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    ErrorBean *error=[[ErrorBean alloc] init];
    Return_Bean *return_bean=[[Return_Bean alloc] init];
     if (connection==h_info_url) {
    
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *returnString = [[NSString alloc] initWithData:h_info_data encoding:NSUTF8StringEncoding];
    [H_info_Parse parseArrXML:returnString commentArr:listdata errorBean:error];
   // NSLog(@"return_string==>%@",returnString);
    self.h_array =listdata;
    [self.tableview reloadData];
    [listdata release];
    }
    if (connection==zf_info_url) {
        NSMutableArray *return_data=[[NSMutableArray alloc] init];
        NSString *return_str= [[NSString alloc] initWithData:h_info_data encoding:NSUTF8StringEncoding];
        [Return_Pares parseArrXML:return_str commentArr:return_data return_bean:return_bean];
        self.return_string=return_bean.state;
        if ([self.return_string isEqualToString:@"ok"]) {
            [self handlereturn:@"转发成功"];
        }else
        {
            [self handlereturn:@"转发失败"];
        }
        [return_data release];
    }
    [error release];
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

//将图片变成圆角
//static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
//                                 float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) {
//        CGContextAddRect(context, rect);
//        return;
//    }
//    
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
//    CGContextScaleCTM(context, ovalWidth, ovalHeight);
//    fw = CGRectGetWidth(rect) / ovalWidth;
//    fh = CGRectGetHeight(rect) / ovalHeight;
//    
//    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
//    
//    CGContextClosePath(context);
//    CGContextRestoreGState(context);
//}
//
//
//+ (id) createRoundedRectImage:(UIImage*)image size:(CGSize)size
//{
//    // the size of CGContextRef
//    int w = size.width;
//    int h = size.height;
//    
//    UIImage *img = image;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGRect rect = CGRectMake(0, 0, w, h);
//    
//    CGContextBeginPath(context);
//    addRoundedRectToPath(context, rect, 10, 10);
//    CGContextClosePath(context);
//    CGContextClip(context);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//}
@end
