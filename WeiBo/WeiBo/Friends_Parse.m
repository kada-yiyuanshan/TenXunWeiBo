//
//  Friends_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-11.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Friends_Parse.h"
#import "Friends_Bean.h"

@implementation Friends_Parse
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
            Friends_Bean *comment = [[Friends_Bean alloc] init];
			xmlNodePtr c2_node =cur_node->children;
			xmlNodePtr cur2_node;
            
			for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
			{
				NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
                    if ([@"nick" isEqual:cur2_name]) {
                        if (cur2_node->children != nil)  {
                            NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                            comment.nick =content;
                            
                        }else {
                            comment.nick=@"";
                        }
                    }else if ([@"head" isEqual:cur2_name]) {
                        if (cur2_node->children != nil)  {
                            NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                            comment.head =content;
                        }else {
                            comment.head=@"";
                        }
                    }else
                    {
                    }
		    }
            //NSLog(@"nick====>%@",comment.nick);
            [_commentArr addObject:comment];
            [comment release];
        }
    }
    xmlFreeDoc(doc);
    return YES;
}

@end
