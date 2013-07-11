//
//  H_View_Cell.h
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface H_View_Cell : UITableViewCell
{
    UIView *head;
    UIButton *nick;
    UIButton *repeat;
    UILabel *origtext;
    UILabel *origtextfrom;
    UILabel *time;
}

@property(retain,nonatomic) IBOutlet UIView *head;
@property(retain,nonatomic) IBOutlet UIButton *nick;
@property(retain,nonatomic) IBOutlet UIButton *repeat;
@property(retain,nonatomic) IBOutlet UILabel *origtext;
@property(retain,nonatomic) IBOutlet UILabel *origtextfrom;
@property(retain,nonatomic) IBOutlet UILabel *time;

@end
