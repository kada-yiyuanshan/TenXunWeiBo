//
//  U_DateController.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"

@interface U_DateController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    UIImageView *head_bg;
    UIView *head_view;
    UILabel *u_nick;
    UILabel *u_name;
    UILabel *tzh_nub;
    UILabel *gbo_nub;
    UILabel *sti_nub;
    UILabel *wxc_nub;
    UIButton *edit_bt;
    UIButton *gbo;
    UIButton *tzh;
    UIButton *sti;
    UIButton *wxc;
    UITableView *tableview;
    UITableViewCell *edit_tableviewcell;
    UITableViewCell *other_tableviewcell;
    NSMutableArray *token_arry;
    
    NSMutableArray *info_arry;
    NSMutableData *user_info_data;
    NSURLConnection *user_info_url;
    
    TokenDataBase *database;
    TokenDataBaseHelp *datahelp;
    
    UIActivityIndicatorView *progressInd;

}
@property (retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(retain,nonatomic) IBOutlet UITableView *tableview;
@property(retain,nonatomic) IBOutlet UITableViewCell *edit_tableviewcell;
@property(retain,nonatomic) IBOutlet UITableViewCell *other_tableviewcell;

@property(retain,nonatomic) NSMutableArray *token_arry;
@property(retain,nonatomic) NSMutableArray *info_arry;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *datahelp;

@property(retain,nonatomic) IBOutlet UIImageView *head_bg;
@property(retain,nonatomic) IBOutlet UIView *head_view;
@property(retain,nonatomic) IBOutlet UILabel *u_nick;
@property(retain,nonatomic) IBOutlet UILabel *u_name;
@property(retain,nonatomic) IBOutlet UILabel *tzh_nub;
@property(retain,nonatomic) IBOutlet UILabel *gbo_nub;
@property(retain,nonatomic) IBOutlet UILabel *sti_nub;
@property(retain,nonatomic) IBOutlet UILabel *wxc_nub;
@property(retain,nonatomic) IBOutlet UIButton *edit_bt;
@property(retain,nonatomic) IBOutlet UIButton *gbo;
@property(retain,nonatomic) IBOutlet UIButton *tzh;
@property(retain,nonatomic) IBOutlet UIButton *sti;
@property(retain,nonatomic) IBOutlet UIButton *wxc;

-(IBAction)edit_bt:(id)sender;
-(IBAction)gbo_bt:(id)sender;
-(IBAction)sti_bt:(id)sender;
-(IBAction)wxc_bt:(id)sender;
-(IBAction)tzh_bt:(id)sender;
@end
