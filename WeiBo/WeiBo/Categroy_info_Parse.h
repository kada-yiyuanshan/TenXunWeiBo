//
//  Categroy_info_Parse.h
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class Category_Bean;
@class ErrorBean;
@interface Categroy_info_Parse : NSObject
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error;
@end
