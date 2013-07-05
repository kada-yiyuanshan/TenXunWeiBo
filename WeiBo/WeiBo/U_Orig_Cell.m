//
//  U_Orig_Cell.m
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_Orig_Cell.h"

@interface U_Orig_Cell ()

@end

@implementation U_Orig_Cell
@synthesize u_nick_button,origtext_lable,origtextfrom_lable,time_lable;


-(float)User_nick:(NSString *)user_nick Origtext:(NSString *)origtext Origtextfrom:(NSString *)origtextfrom
{
    float height;
    CGSize size = CGSizeMake(300.0, 1000);
    CGSize labelSizetitle = [user_nick sizeWithFont:u_nick_button.titleLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    u_nick_button.titleLabel.frame = CGRectMake(13, 5,u_nick_button.titleLabel.frame.size.width, labelSizetitle.height+5);

    CGSize labelSizeorigtext = [origtext sizeWithFont:origtext_lable.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    origtext_lable.frame = CGRectMake(origtext_lable.frame.origin.x, u_nick_button.titleLabel.frame.origin.y+5+labelSizetitle.height,origtext_lable.frame.size.width, labelSizeorigtext.height+10);
    
    CGSize labelSizeorigtextfrom = [origtextfrom sizeWithFont:origtextfrom_lable.font constrainedToSize:size lineBreakMode:UILineBreakModeClip];
    origtextfrom_lable.frame = CGRectMake(origtextfrom_lable.frame.origin.x, origtext_lable.frame.origin.y,origtextfrom_lable.frame.size.width, labelSizeorigtextfrom.height+50);
    height=origtextfrom_lable.frame.origin.y+labelSizeorigtextfrom.height+35;
    return height;
}

-(void)dealloc
{
    [super dealloc];
    [origtext_lable release];
    [origtextfrom_lable release];
   // [time_lable release];
    [u_nick_button release];
}
@end
