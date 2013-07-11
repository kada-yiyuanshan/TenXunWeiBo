//
//  Friends_Parse.h
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class Friends_Bean;
@class ErrorBean;
@interface Friends_Parse : NSObject
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error;
@end
