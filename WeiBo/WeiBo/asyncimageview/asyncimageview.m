//
//  AsyncImageView.m
//
//  Created by Zorro on 14/01/2011.
//  Copyright 2011 eHealthInsurance Services Inc. All rights reserved.
//
#define kDocument_Folder [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 
#import "AsyncImageView.h"
#import <CommonCrypto/CommonDigest.h>
#import <QuartzCore/QuartzCore.h>
@implementation AsyncImageView

//md5 endcode function
-(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (void)dealloc {
    NSLog(@"release the list");
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[activityIndicatorView release];
//	[data release];
	[_cacheFileName release];
	[super dealloc];
}


- (void)loadImageFromURL:(NSURL*)url land:(BOOL)land {
    @try{
        if (url == nil) {
            return;
        }
        land_model = land;
        
        if(connection!=nil) { [connection release]; } //in case we are downloading a 2nd image
        if (data!=nil) { [data release]; }
        if(_cacheFileName!=nil) { [_cacheFileName release]; }
        
        NSString *urlstr=[url absoluteString]; // 
        _cacheFileName= [NSString stringWithFormat:@"%@",[kDocument_Folder stringByAppendingPathComponent:
                                                     [NSString stringWithFormat:@"/%@.%@",[self md5:urlstr],[urlstr pathExtension]]
                                                     ]];
        [_cacheFileName retain];
        if([[NSFileManager defaultManager] fileExistsAtPath:_cacheFileName]) {
//            data=[NSData dataWithContentsOfFile:_cacheFileName];
            [self performSelector:@selector(addImageView)]; //display ImageView
        }
        else{
            activityIndicatorView =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-10.0f, self.frame.size.height/2-10.0f, 20.0f, 20.0f)];
            [activityIndicatorView  startAnimating];
            if(land){
                activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            }else{
                activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            }
            [activityIndicatorView  sizeToFit];
            [self addSubview:activityIndicatorView];
            NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
            connection= [[NSURLConnection alloc] initWithRequest:request delegate:self]; //notice how delegate set to self object
            //TODO error handling, what if connection is nil?
        }
    }@catch (NSException *exception) {
        NSLog(@"%@",[exception description]);
    }
}
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
	[activityIndicatorView stopAnimating];
}
- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response{
	if ([response respondsToSelector:@selector(statusCode)])
	{
		int statusCode = [((NSHTTPURLResponse *)response) statusCode];
		if (statusCode >= 400)
		{
			[theConnection cancel];  // stop connecting; no more delegate messages
			NSDictionary *errorInfo
			= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
												  NSLocalizedString(@"Server returned status code %d",@""),
												  statusCode]
										  forKey:NSLocalizedDescriptionKey];
			NSError *statusError
			= [NSError errorWithDomain:@"ErrorDomain"
								  code:statusCode
							  userInfo:errorInfo];
			[self connection:theConnection didFailWithError:statusError];
		}
	}
}
//the URL connection calls this repeatedly as data arrives
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//so self data now has the complete image 
	[connection release];
	connection=nil;
	if ([[self subviews] count]>0) {
		//then this must be another image, the old one is still in subviews
		[[[self subviews] objectAtIndex:0] removeFromSuperview]; //so remove it (releases it also)
	}
	
	[data writeToFile:[NSString stringWithFormat:@"%@",_cacheFileName] atomically:YES]; // write file into cache folder
//    [self addImageView];
	[self performSelector:@selector(addImageView)]; //display ImageView
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
}

-(void)addImageView
{
    
	if(activityIndicatorView){
		[activityIndicatorView stopAnimating];
	}
    
	//[activityIndicatorView removeFromSuperview];
	//make an image view for the image
    UIImage *_img = [[UIImage alloc] initWithContentsOfFile:_cacheFileName];
	UIImageView* imageView = [[UIImageView alloc] initWithImage:_img];
    [_img release];
	//make sizing choices based on your needs, experiment with these. maybe not all the calls below are needed.
//	
    if (land_model) {
        imageView.contentMode = UIViewContentModeTop;
        CALayer* imageLayer = imageView.layer;
        imageLayer.masksToBounds = YES;
        CGRect rect;
        //    if (inPortrait)
        //        rect = CGRectMake(0.0, 0.0, 0.5, 1.0); // half size
        //    else
        rect = CGRectMake(0.0, 0.1, 1.0, 1.0); // full size
        imageLayer.contentsRect = rect;
    }else{
        imageView.contentMode= UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask= ( UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    }
    

	[self addSubview:imageView];
	imageView.frame = self.bounds;
	[imageView setNeedsLayout];
	[self setNeedsLayout];
    [imageView release];
    
}


@end
