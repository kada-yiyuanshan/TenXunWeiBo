//
//  Su_HomeController.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Su_HomeController : UIViewController<UINavigationControllerDelegate,UITabBarControllerDelegate,UITabBarDelegate,UINavigationBarDelegate>
{
    UITabBarController *tabbarcontroller;
}
@property (retain,nonatomic) UITabBarController *tabbarcontroller;

@end
