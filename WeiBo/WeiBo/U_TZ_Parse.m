//
//  U_TZ_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-4.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_TZ_Parse.h"
#import "ErrorBean.h"
#import "U_TZ_Bean.h"

@implementation U_TZ_Parse

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
                if ([@"curnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        _error.counts=[content integerValue];
                    }
                }else if ([@"hasnext" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        _error.pages=[content integerValue];
                    }
                }else if([@"info" isEqual:cur2_name]){
                    U_TZ_Bean *comment = [[U_TZ_Bean alloc] init];
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"fansnum" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.fansnum =content;
                                
                            }else {
                                comment.fansnum=@"";
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
                        }else if ([@"isfans" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.isfans =content;
                            }else {
                                comment.isfans=@"";
                            }
                        }
                        else if ([@"name" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.name =content;
                            }else {
                                comment.name=@"";
                            }
                        }
                        else if ([@"sex" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.sex =[content integerValue];
                            }else {
                                comment.sex=0;
                            }
                        }else if ([@"isidol" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.isidol =content;
                            }else {
                                comment.isidol=@"";
                            }
                        }else if ([@"openid" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.openid =[content integerValue];
                            }else {
                                comment.openid=0;
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
