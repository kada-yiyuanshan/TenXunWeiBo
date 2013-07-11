//
//  Category_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>

@interface Category_Controller : UIViewController<NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIActivityIndicatorView *indicatorview;
    
    UITableView *tableview;
    
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *token_array;
    
    NSURLConnection *category_info_url;
    NSMutableArray *category_info_array;
    NSMutableData *category_info_data;
    
    NSString *child_id;
    NSString *child_name;
    
    NSMutableArray *row_array;
    
    NSMutableArray *refresh;

}
@property(retain,nonatomic) NSMutableArray *refresh;

@property(retain,nonatomic) NSMutableArray *row_array;

@property(retain,nonatomic) IBOutlet UITableView *tableview;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *category_info_array;

@property(retain,nonatomic) NSMutableArray *token_array;

@property(retain,nonatomic) NSString *child_id;
@property(retain,nonatomic) NSString *child_name;

-(IBAction)refresh:(id)sender;

@end
