//
//  U_OrigText_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-3.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_OrigText_Parse.h"
#import "U_OrigText_Bean.h"
#import "ErrorBean.h"

@implementation U_OrigText_Parse
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error
{
	
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
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
//		if([cur_name isEqual:@"status"])
//		{
//			NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
//			_error.status= content;
//		}else if([cur_name isEqual:@"message"])
//		{
//			if (cur_node->children != nil)  {
//				NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
//				_error.errorMessage= content;
//			}else {
//				_error.errorMessage = @"";
//			}
//		}
//		else
        if([cur_name isEqual:@"data"])
		{
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
    
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
				if([@"info" isEqual:cur2_name]){
                    U_OrigText_Bean *comment = [[U_OrigText_Bean alloc] init];
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"from" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.origfrom =content;
                                
                            }else {
                                comment.origfrom=@"";
                            }
                        }else if ([@"nick" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.nick =content;
                            }else {
                                comment.nick=@"";
                            }
                        }else if ([@"origtext" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.origtext =content;
                            }else {
                                comment.origtext=@"";
                            }
                        }else if ([@"timestamp" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.origtime =content;
                            }else {
                                comment.origtime=@"";
                            }
                        }else {
                        }
                        
                    }
                    [_commentArr addObject:comment];
                    [comment release];
                }
		    }
        }
    }
    xmlFreeDoc(doc);
    return YES;
}
@end
