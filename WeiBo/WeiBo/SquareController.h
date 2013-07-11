//
//  SquareController.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <CoreLocation/CoreLocation.h>

@interface SquareController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locatemanage;
    CLGeocoder *geocoder;//坐标转换为地址
    CLPlacemark *placemark;//地址标记
    NSString *latitude;//经度
    NSString *longitude;//纬度
    
    
    IBOutlet UIActivityIndicatorView *indicatorview;
    
    UIScrollView *scrollView;
    UIView *image_view;
    UIPageControl *pageControl;
    BOOL pageControlBeingUsed;
    UIView *page1_view;
    IBOutlet UIView *page1_view1;
    IBOutlet UIView *page1_view2;
    IBOutlet UIView *page1_view3;
    IBOutlet UIView *page1_view4;
    IBOutlet UIView *page1_view5;
    IBOutlet UIView *page1_view6;
    IBOutlet UIView *page1_view7;
    IBOutlet UIView *page1_view8;
    
    UIView *page2_view;
    IBOutlet UIView *page2_view1;
    IBOutlet UIView *page2_view2;
    IBOutlet UIView *page2_view3;
    IBOutlet UIView *page2_view4;
    IBOutlet UIView *page2_view5;
    IBOutlet UIView *page2_view6;
    IBOutlet UIView *page2_view7;
    IBOutlet UIView *page2_view8;
    BOOL state;
    
    UITableView *tableview;
    
    NSURLConnection *category_url;
    NSMutableArray *category_array;
    NSMutableData *category_data;
    
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *token_array;
    
}

@property(retain,nonatomic) NSString *latitude;
@property(retain,nonatomic) NSString *longitude;

@property(assign,nonatomic) BOOL state;
@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *category_array;

@property(retain,nonatomic) NSMutableArray *token_array;

@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UIPageControl *pageControl;
@property (retain,nonatomic) IBOutlet UITableView *tableview;

@property (retain,nonatomic) IBOutlet UIView *image_view;
@property (retain,nonatomic) IBOutlet UIView *page1_view;


@property (retain,nonatomic) IBOutlet UIView *page2_view;

-(IBAction)selectButton:(id)sender;
@end
