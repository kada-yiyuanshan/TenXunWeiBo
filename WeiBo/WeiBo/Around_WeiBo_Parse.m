//
//  Around_WeiBo_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Around_WeiBo_Parse.h"
#import "ErrorBean.h"
#import "Around_WeiBo_Bean.h"

@implementation Around_WeiBo_Parse
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
        if([cur_name isEqual:@"data"])
		{
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
            
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
                if([@"info" isEqual:cur2_name]){
                    Around_WeiBo_Bean *comment = [[Around_WeiBo_Bean alloc] init];
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"from" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.from =content;
                                
                            }else {
                                comment.from=@"";
                            }
                        }else if ([@"nick" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.nick =content;
                            }else {
                                comment.nick=@"";
                            }
                        }else if ([@"head" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.head =content;
                            }else {
                                comment.head=@"";
                            }
                        }else  if ([@"origtext" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.origtext =content;
                            }else {
                                comment.origtext=@"";
                            }
                        }
                        else if ([@"pic" isEqual:cur3_name]) {
                            xmlNodePtr c4_node =cur3_node->children;
                            xmlNodePtr cur4_node;
                            
                            for(cur4_node = c4_node;cur4_node;cur4_node=cur4_node->next)
                            {
                                NSString *cur4_name = [NSString stringWithUTF8String:(char *)cur4_node->name];
                                if ([@"info" isEqual:cur4_name]) {
                                    xmlNodePtr c5_node =cur4_node->children;
                                    xmlNodePtr cur5_node;
                                    
                                    for(cur5_node = c5_node;cur5_node;cur5_node=cur5_node->next)
                                    {
                                        NSString *cur5_name = [NSString stringWithUTF8String:(char *)cur5_node->name];
                                        if ([@"url" isEqual:cur5_name]) {
                                            if (cur5_node->children != nil)  {
                                                NSString * content = [NSString stringWithUTF8String:(char *)cur5_node->children->content];
                                                comment.pic_url =content;
                                                
                                            }else {
                                                comment.pic_url=@"";
                                            }
                                        }
                                    }
                                }
                            }
                        }else if ([@"timestamp" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.timestamp =content;
                            }else {
                                comment.timestamp=@"";
                            }
                        }else if ([@"count" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.count =content;
                            }else {
                                comment.count=@"";
                            }
                        }else {
                        }
                        
                    }
                    //NSLog(@"pic_url===>%@",comment.count);
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
