//
//  SquareController.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "SquareController.h"
#import "Return_Bean.h"
#import "Category_Bean.h"
#import "Category_Parse.h"
#import "Category_Controller.h"
#import "Ground_People_Controller.h"
#import "Around_WeBo_Controller.h"
#import "Friends_Controller.h"

@interface SquareController ()

@end

@implementation SquareController
@synthesize scrollView;
@synthesize image_view;
@synthesize pageControl;
@synthesize page1_view;
@synthesize page2_view;
@synthesize tableview;
@synthesize category_array;
@synthesize database,databasehelp;
@synthesize token_array;
@synthesize state;
@synthesize latitude,longitude;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"广场", @"广场");
        self.state=NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addRoundedRect];
    [self addsubview];
    [self marklocationmanage];
    self.category_array =[[NSMutableArray alloc] init];
    self.databasehelp =[[TokenDataBaseHelp alloc] init];
    self.database =[[TokenDataBase alloc] init];
    self.token_array =[[NSMutableArray alloc] init];
    [self.databasehelp queryTotable:self.token_array];
    self.database=[self.token_array objectAtIndex:0];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self category_connection];
    self.state=NO;
}
-(void)category_connection
{
    [indicatorview startAnimating];
    if (category_url!=nil) {
        [category_url release];
    }
    if (category_data!=nil) {
        [category_data release];
    }
    NSString *url=[NSString stringWithFormat:@"https://open.t.qq.com/api/channel/level_info?format=xml&name=&id=&oauth_consumer_key=801357018&access_token=%@&openid=%@&clientip=122.193.29.102&oauth_version=2.a&scope=all",self.database.access_token,self.database.openid];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    category_url = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    category_data=[[NSMutableData alloc] init];
  //  NSLog(@"url====>%@",url);
}
#pragma MAKE TABLEVIEW
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if(section==1){
        return 3;
    }else if(section==2){
        return 1;
    }
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
    UIImageView *imageview=[[UIImageView alloc] initWithFrame:CGRectMake(15,5,26,32)];
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(65,6,100,30)];
    lable.font = [UIFont systemFontOfSize:15];
    lable.backgroundColor=[UIColor clearColor];
    int sec=[indexPath section];
    if (sec==0) {
        int ind=[indexPath row];
        if (ind==0) {
            lable.text=@"吹一吹";
            imageview.image=[UIImage imageNamed:@"wb_square_icon_lbs.png"];
            
            
        }else if(ind==1)
        {
            
            lable.text=@"每日街景";
            imageview.image=[UIImage imageNamed:@"wb_square_icon_streetview.png"];
        }
    }else if (sec==1) {
        int ind=[indexPath row];
        if (ind==0) {
            lable.text=@"身边的微博";

            imageview.image=[UIImage imageNamed:@"wb_square_icon_weibo.png"];
        }else if(ind==1)
        {
            lable.text=@"身边的人";

            imageview.image=[UIImage imageNamed:@"wb_square_icon_people.png"];
        }else if(ind==2)
        {
            lable.text=@"身边的图片墙";
            imageview.image=[UIImage imageNamed:@"wb_square_icon_wall.png"];
        }
    }else if (sec==2) {
        int ind=[indexPath row];
        if (ind==0) {
            lable.text=@"发现朋友";
            imageview.image=[UIImage imageNamed:@"wb_square_icon_find.png"];
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:imageview];
    [cell addSubview:lable];
    [imageview release];
    [lable release];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger e=[indexPath section];
    if (e==0 ) {
        return 40;
    }else if(e==1)
    {
        return 50;
    }else if(e==2){
        return 40;
    }
    return 40;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int sec=[indexPath section];
    if (sec==0) {
        int ind=[indexPath row];
        if (ind==0) {

            
            
        }else if(ind==1)
        {
            

        }
    }else if (sec==1) {
        int ind=[indexPath row];
        if (ind==0) {
            Around_WeBo_Controller *around=[[Around_WeBo_Controller alloc] initWithNibName:@"Around_WeBo_Controller" bundle:nil];
            around.hidesBottomBarWhenPushed=YES;
            around.longitude=self.longitude;
            around.latitude=self.latitude;
            [self.navigationController pushViewController:around animated:YES];
            [around release];
        }else if(ind==1)
        {
            Ground_People_Controller *ground=[[Ground_People_Controller alloc] initWithNibName:@"Ground_People_Controller" bundle:nil];
            ground.hidesBottomBarWhenPushed=YES;
            ground.longitude=self.longitude;
            ground.latitude=self.latitude;
            [self.navigationController pushViewController:ground animated:YES];
            [ground release];
        }else if(ind==2)
        {

        }
    }else if (sec==2) {
        int ind=[indexPath row];
        if (ind==0) {
            Friends_Controller *friend=[[Friends_Controller alloc] initWithNibName:@"Friends_Controller" bundle:nil];
            friend.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:friend animated:YES];
        }
    }

}

-(void)addsubview
{
    NSArray *colors = [NSArray arrayWithObjects:self.page1_view,self.page2_view, nil];
    for (int i = 0; i < colors.count; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        [subview addSubview:[colors objectAtIndex:i]];
        [self.scrollView addSubview:subview];
        self.pageControl.numberOfPages=colors.count;
        [subview release];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
    
}

-(IBAction)selectButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    Category_Controller *category=[[Category_Controller alloc] initWithNibName:@"Category_Controller" bundle:nil];
    
    switch (button.tag) {
        case 1:
            category.child_id=@"1985";
            category.child_name=@"";
            self.state=YES;
           break;
        case 2:
            category.child_id=@"43";
            category.child_name=@"美女";
            self.state=YES;
            break;
        case 4:
            category.child_id=@"";
            category.child_name=@"明星";
            self.state=YES;
            break;
        default:
            break;
    }
    if (self.state==YES) {
        category.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:category animated:YES];
    }else
    {
    
    }
     
   
    [category release];

}
#pragma make NSURLCONNECTION
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==category_url) {
        return [category_data appendData:data];
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
    
    category_url = nil;

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    Return_Bean *return_bean_=[[Return_Bean alloc] init];
    if (connection==category_url) {
    NSMutableArray *listdata=[[NSMutableArray alloc] init];
    NSString *returnString = [[NSString alloc] initWithData:category_data encoding:NSUTF8StringEncoding];
    [Category_Parse parseArrXML:returnString commentArr:listdata return_bean:return_bean_];
    //NSLog(@"retu=====>%@",returnString);
    
    [listdata release];
    }
    [indicatorview stopAnimating];
    indicatorview.hidden=YES;
    [return_bean_ release];
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
#pragma mark -LOCATIONMANAGE
-(void)marklocationmanage
{
    locatemanage = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locatemanage.delegate = self;
    locatemanage.desiredAccuracy = kCLLocationAccuracyBest;
    locatemanage.distanceFilter = 5.0;
    [locatemanage startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
    
    if(error.code == kCLErrorLocationUnknown){
        NSLog(@"当前无法获取到位置信息。");
    } else if (error.code == kCLErrorNetwork) {
        NSLog(@"网络异常 - 无法获取到位置信息。");
    } else if (error.code == kCLErrorDenied) {
        NSLog(@"您的移动设备禁用了获取位置的服务。");
        [locatemanage stopUpdatingLocation];
    }
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"错误提醒"
                               message:@"获取位置信息失败！"
                               delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [errorAlert show];
}
//更新位置，以及经纬度数据与详细地理位置进行转换
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocation *currentLocation = newLocation;
    
    if(currentLocation != nil){
        self.latitude=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        self.longitude=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    }
   // NSLog(@"lat===>%@,long===>%@",self.latitude,self.longitude);
    // 停止location manager
    [locatemanage stopUpdatingLocation];
    
}


-(void)addRoundedRect
{
    page1_view1.layer.cornerRadius=8;
    page1_view2.layer.cornerRadius=8;
    page1_view3.layer.cornerRadius=8;
    page1_view4.layer.cornerRadius=8;
    page1_view5.layer.cornerRadius=8;
    page1_view6.layer.cornerRadius=8;
    page1_view7.layer.cornerRadius=8;
    page1_view8.layer.cornerRadius=8;
    
    page2_view1.layer.cornerRadius=8;
    page2_view2.layer.cornerRadius=8;
    page2_view3.layer.cornerRadius=8;
    page2_view4.layer.cornerRadius=8;
    page2_view5.layer.cornerRadius=8;
    page2_view6.layer.cornerRadius=8;
    page2_view7.layer.cornerRadius=8;
    page2_view8.layer.cornerRadius=8;
    
    page1_view1.layer.masksToBounds = YES;
    page1_view2.layer.masksToBounds = YES;
    page1_view3.layer.masksToBounds = YES;
    page1_view4.layer.masksToBounds = YES;
    page1_view5.layer.masksToBounds = YES;
    page1_view6.layer.masksToBounds = YES;
    page1_view7.layer.masksToBounds = YES;
    page1_view8.layer.masksToBounds = YES;
    
    page2_view1.layer.masksToBounds = YES;
    page2_view2.layer.masksToBounds = YES;
    page2_view3.layer.masksToBounds = YES;
    page2_view4.layer.masksToBounds = YES;
    page2_view5.layer.masksToBounds = YES;
    page2_view6.layer.masksToBounds = YES;
    page2_view7.layer.masksToBounds = YES;
    page2_view8.layer.masksToBounds = YES;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
   //NSLog(@"pagenum====>%d",self.pageControl.currentPage);
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlBeingUsed = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)dealloc
{

    [super dealloc];
    [scrollView release];
    [image_view release];
    [pageControl release];
    [page1_view release];
    [page2_view release];
    [tableview release];
    [category_array release];
    [database release];
    [databasehelp release];
    [token_array release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
