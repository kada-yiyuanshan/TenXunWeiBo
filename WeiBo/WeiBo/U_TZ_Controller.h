//
//  U_TZ_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>

@interface U_TZ_Controller : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    UITableView *tableview;
  
    NSInteger morecounts;
    NSInteger pages;
    
    NSMutableArray *token_arry;
    NSURLConnection *u_tz_url;
    NSMutableData *u_tz_data;
    NSMutableArray *u_tz_array;
    
    TokenDataBase *database;
    TokenDataBaseHelp *datahelp;
    
    UIActivityIndicatorView *progressInd;
}
@property(retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *datahelp;

@property(retain,nonatomic) NSMutableArray *u_tz_array;
@property(retain,nonatomic) NSMutableArray *token_arry;
@property(retain,nonatomic) NSMutableIndexSet *expandedSections;

@property(retain,nonatomic) IBOutlet UITableView *tableview;

@end
