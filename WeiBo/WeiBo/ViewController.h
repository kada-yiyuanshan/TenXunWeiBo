//
//  ViewController.h
//  WeiBo
//
//  Created by hcui on 13-6-26.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *webview;
}
@property(retain,nonatomic) IBOutlet UIWebView *webview;


@end
