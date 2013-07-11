//
//  U_ST_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>

@interface U_ST_Controller : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tableview;
    NSInteger morecounts;
    NSInteger pages;
    
    NSMutableArray *token_arry;
    NSURLConnection *u_st_url;
    NSMutableData *u_st_data;
    NSMutableArray *u_st_array;
    
    //取消收听
    NSURLConnection *cancel_st_url;
    NSMutableData *cancel_st_data;
    NSInteger objectindex;
    
    TokenDataBase *database;
    TokenDataBaseHelp *datahelp;
    
    UIActivityIndicatorView *progressInd;
}
@property(retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *datahelp;

@property(retain,nonatomic) NSMutableArray *u_st_array;
@property(retain,nonatomic) NSMutableArray *token_arry;
@property(retain,nonatomic) IBOutlet UITableView *tableview;

@property(retain,nonatomic) NSMutableIndexSet *expandedSections;

-(IBAction)cancle:(id)sender;
@end
