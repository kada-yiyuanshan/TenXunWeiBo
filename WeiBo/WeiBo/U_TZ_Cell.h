//
//  U_TZ_Cell.h
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface U_TZ_Cell : UITableViewCell
{
    UIView *f_head;
    UIButton *f_name;
    UILabel *f_nick;
    UIButton *f_st;
    UIImageView *other_view;
    UILabel *f_zt;
    
    UIImageView *f_sex;
}
@property(retain,nonatomic) IBOutlet UIView *f_head;
@property(retain,nonatomic) IBOutlet UIButton *f_name;
@property(retain,nonatomic) IBOutlet UILabel *f_nick;
@property(retain,nonatomic) IBOutlet UIButton *f_st;
@property(retain,nonatomic) IBOutlet UIImageView *other_view;
@property(retain,nonatomic) IBOutlet UILabel *f_zt;

@property(retain,nonatomic) IBOutlet UIImageView *f_sex;

@end
