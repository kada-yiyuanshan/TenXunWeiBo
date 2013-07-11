//
//  Return_Pares.h
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml/xmlreader.h>
#import <libxml/xmlmemory.h>

@class Return_Bean;
@interface Return_Pares : NSObject
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr return_bean:(Return_Bean*)_return_bean;
@end
