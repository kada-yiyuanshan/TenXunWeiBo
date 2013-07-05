//
//  U_Orig_Cell.h
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface U_Orig_Cell : UITableViewCell
{
    UIButton *u_nick_button;
    UILabel *origtext_lable;
    UILabel *origtextfrom_lable;
    UILabel *time_lable;
}
@property(retain,nonatomic) IBOutlet UIButton *u_nick_button;
@property(retain,nonatomic) IBOutlet UILabel *origtext_lable;
@property(retain,nonatomic) IBOutlet UILabel *origtextfrom_lable;
@property(retain,nonatomic) IBOutlet UILabel *time_lable;

-(float)User_nick:(NSString *)user_nick Origtext:(NSString *)origtext Origtextfrom:(NSString *)origtextfrom;
@end
