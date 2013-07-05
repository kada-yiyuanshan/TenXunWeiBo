//
//  AsyncImageView.h
//
//  Created by Zorro on 14/01/2011.
//  Copyright 2011 eHealthInsurance Services Inc. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface AsyncImageView : UIView {
	//could instead be a subclass of UIImageView instead of UIView, depending on what other features you want to 
	// to build into this class?
	
	NSURLConnection* connection; //keep a reference to the connection so we can cancel download in dealloc
	NSMutableData* data; //keep reference to the data so we can collect it as it downloads
	NSString *_cacheFileName;
	
	UIActivityIndicatorView *activityIndicatorView;
    BOOL land_model;
}   

- (void)loadImageFromURL:(NSURL *)url land:(BOOL)land;
-(void)addImageView;

@end
