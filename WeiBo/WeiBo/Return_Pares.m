//
//  Return_Pares.m
//  WeiBo
//
//  Created by hcui on 13-7-8.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Return_Pares.h"
#import "Return_Bean.h"

@implementation Return_Pares
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr return_bean:(Return_Bean*)_return_bean;
{
	
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"image xml error"];
	}
	xmlNodePtr root = xmlDocGetRootElement(doc);
	
	xmlNodePtr node = root->children;
	
	xmlNodePtr cur_node;
	
	//LoginBean *loginBean = [[LoginBean alloc] init];
	
	for(cur_node = node;cur_node;cur_node = cur_node->next)
	{
		
		NSString *cur_name = [NSString stringWithUTF8String:(char *)cur_node->name];
        if([cur_name isEqual:@"msg"])
        {
            NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
            _return_bean.state= content;
        }
    }
    xmlFreeDoc(doc);
    return YES;
}

@end
