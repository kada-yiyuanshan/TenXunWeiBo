//
//  Friends_Controller.h
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"
#import <QuartzCore/QuartzCore.h>

@interface Friends_Controller : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UIActivityIndicatorView *progressInd;
    UITableView *tableview;

    NSURLConnection *friends_url;
    NSMutableArray *friends_array;
    NSMutableData *friends_data;
    
    TokenDataBase *database;
    TokenDataBaseHelp *databasehelp;
    NSMutableArray *token_array;
}

@property(retain,nonatomic) NSMutableArray *friends_array;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *databasehelp;
@property(retain,nonatomic) NSMutableArray *token_array;

@property(retain,nonatomic) IBOutlet UITableView *tableview;

@end
