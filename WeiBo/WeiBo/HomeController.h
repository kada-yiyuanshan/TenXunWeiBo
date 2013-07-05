//
//  HomeController.h
//  WeiBo
//
//  Created by hcui on 13-7-1.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeController : UIViewController<NSURLConnectionDelegate>
{
    NSURLConnection *h_info_url;
    NSMutableData *h_info_data;
}

@end
