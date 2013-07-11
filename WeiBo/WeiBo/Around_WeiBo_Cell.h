//
//  Around_WeiBo_Cell.h
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Around_WeiBo_Cell : UITableViewCell
{
    UIView *head_view;
    UIButton *nick;
    UILabel *from;
    UILabel *time;
    UILabel *number;
    UILabel *origtext;
    UIView *orig_pic;
}

@property(retain,nonatomic) IBOutlet UIView *head_view;
@property(retain,nonatomic) IBOutlet UIButton *nick;
@property(retain,nonatomic) IBOutlet UILabel *from;
@property(retain,nonatomic) IBOutlet UILabel *time;
@property(retain,nonatomic) IBOutlet UILabel *number;
@property(retain,nonatomic) IBOutlet UILabel *origtext;
@property(retain,nonatomic) IBOutlet UIView *orig_pic;
@end
