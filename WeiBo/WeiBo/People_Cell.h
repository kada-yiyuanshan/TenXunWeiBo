//
//  People_Cell.h
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface People_Cell : UITableViewCell
{
    UIView *head_view;
    UIImageView *sex;
    UILabel *nick;
    UILabel *origtext;
    UILabel *time;
}
@property(retain,nonatomic) IBOutlet UIView *head_view;
@property(retain,nonatomic) IBOutlet UIImageView *sex;
@property(retain,nonatomic) IBOutlet UILabel *nick;
@property(retain,nonatomic) IBOutlet UILabel *origtext;
@property(retain,nonatomic) IBOutlet UILabel *time;

@end
