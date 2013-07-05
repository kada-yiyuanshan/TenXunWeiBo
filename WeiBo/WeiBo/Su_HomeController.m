//
//  Su_HomeController.m
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Su_HomeController.h"
#import "HomeController.h"
#import "MessageController.h"
#import "SquareController.h"
#import "U_DateController.h"
#import "Oauth_String.h"

@interface Su_HomeController ()

@end

@implementation Su_HomeController
//@synthesize tabbar;
//@synthesize home,message,square,data;
@synthesize tabbarcontroller;

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
    [tabbarcontroller release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    HomeController *homepage=[[HomeController alloc]initWithNibName:@"HomeController" bundle:nil];
     UINavigationController *home_NV=[[[UINavigationController alloc] initWithRootViewController:homepage] autorelease];
    [[home_NV navigationBar ] setBackgroundImage:[UIImage imageNamed:@"BackgroundOfTopBar.png" ] forBarMetrics:UIBarMetricsDefault];
     home_NV.tabBarItem =[[[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"HomePageIconOfTabBarForPressed.png"] tag:0] autorelease] ;
    
    MessageController *message=[[MessageController alloc]initWithNibName:@"MessageController" bundle:nil];
    UINavigationController *message_NV=[[[UINavigationController alloc] initWithRootViewController:message] autorelease];
    [[message_NV navigationBar ] setBackgroundImage:[UIImage imageNamed:@"BackgroundOfTopBar.png" ] forBarMetrics:UIBarMetricsDefault];
     message_NV.tabBarItem =[[[UITabBarItem alloc] initWithTitle:@"消息" image:[UIImage imageNamed:@"HomePageIconOfTabBarForPressed.png"] tag:0] autorelease] ;
    
    SquareController *square=[[SquareController alloc]initWithNibName:@"SquareController" bundle:nil];
    UINavigationController *square_NV=[[[UINavigationController alloc] initWithRootViewController:square] autorelease];
    [[square_NV navigationBar ] setBackgroundImage:[UIImage imageNamed:@"BackgroundOfTopBar.png" ] forBarMetrics:UIBarMetricsDefault];
     square_NV.tabBarItem =[[[UITabBarItem alloc] initWithTitle:@"广场" image:[UIImage imageNamed:@"HomePageIconOfTabBarForPressed.png"] tag:0] autorelease] ;
    
    U_DateController *u_date=[[U_DateController alloc]initWithNibName:@"U_DateController" bundle:nil];
    UINavigationController *u_date_NV=[[[UINavigationController alloc] initWithRootViewController:u_date] autorelease];
    [[u_date_NV navigationBar ] setBackgroundImage:[UIImage imageNamed:@"BackgroundOfTopBar.png" ] forBarMetrics:UIBarMetricsDefault];
     u_date_NV.tabBarItem =[[[UITabBarItem alloc] initWithTitle:@"资料" image:[UIImage imageNamed:@"HomePageIconOfTabBarForPressed.png"] tag:0] autorelease] ;
    
    self.tabbarcontroller=[[UITabBarController alloc] init];
    [[self.tabbarcontroller tabBar]setBackgroundImage:[[UIImage imageNamed:@"BackgroundOfBottomTabBar.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor colorWithRed:177 green:215 blue:251 alpha:1.0f] }forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor whiteColor] }forState:UIControlStateHighlighted];

    self.tabbarcontroller.viewControllers=@[home_NV,message_NV,square_NV,u_date_NV];
    [self.view addSubview:self.tabbarcontroller.view];

}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    switch (item.tag) {
      case 0:
            
            break;
            
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
