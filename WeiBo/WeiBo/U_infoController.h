//
//  U_infoController.h
//  WeiBo
//
//  Created by hcui on 13-7-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface U_infoController : UIViewController<UITextViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    UIImageView *im_bg;
    UITextView *nick;
    UITextView *introduction;
    NSMutableArray *info_arry;
    IBOutlet UIView *head_view;
    int keyBoardMargin_;
    NSMutableArray *token_arry;
    
    NSMutableArray *updata_info_arry;
    NSMutableData *updata_info_data;
    NSURLConnection *updata_info_url;
//    UIActivityIndicatorView *progressInd;
}

//@property(retain,nonatomic) IBOutlet UIActivityIndicatorView *progressInd;
@property(retain,nonatomic) IBOutlet UIImageView *im_bg;
@property(retain,nonatomic) IBOutlet UITextView *nick;
@property(retain,nonatomic) IBOutlet UITextView *introduction;
@property(retain,nonatomic) NSMutableArray *info_arry;
@property(retain,nonatomic) NSMutableArray *updata_info_arry;
@property(retain,nonatomic) NSMutableArray *token_arry;


-(IBAction)Textview_edit_bg:(id)sender;
@end
