//
//  H_Publish.h
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenDataBase.h"
#import "TokenDataBaseHelp.h"

@interface H_Publish : UIViewController<UINavigationBarDelegate,UITextViewDelegate,NSURLConnectionDelegate>
{
    IBOutlet UINavigationItem *item;
    UITextView *publish_text;
    
    TokenDataBase *database;
    TokenDataBaseHelp *database_help;
    NSMutableArray *token_array;
    
    NSURLConnection *publish_url;
    NSMutableArray *publish_array;
    NSMutableData *publish_data;
    
    NSString *return_string;
    IBOutlet UIActivityIndicatorView *indicatorview;
}
@property(retain,nonatomic) IBOutlet UITextView *publish_text;

@property(retain,nonatomic) TokenDataBase *database;
@property(retain,nonatomic) TokenDataBaseHelp *database_help;
@property(retain,nonatomic) NSMutableArray *token_array;
@property(retain,nonatomic) NSMutableArray *publish_array;
@property(retain,nonatomic) NSString *return_string;

-(IBAction)cancel:(id)sender;
-(IBAction)bg:(id)sender;
@end
