//
//  U_info_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "U_info_Parse.h"
#import "ErrorBean.h"
#import "U_info_Bean.h"

@implementation U_info_Parse
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr errorBean:(ErrorBean*)_error
{
	
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	xmlDocPtr doc = xmlParseMemory([xml UTF8String], [xml lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
	if(doc ==nil)
	{
		[NSException raise:NSGenericException format:@"xml error"];
	}
	xmlNodePtr root = xmlDocGetRootElement(doc);
	
	xmlNodePtr node = root->children;
	
	xmlNodePtr cur_node;
	
	//LoginBean *loginBean = [[LoginBean alloc] init];
	
	for(cur_node = node;cur_node;cur_node = cur_node->next)
	{
		
		NSString *cur_name = [NSString stringWithUTF8String:(char *)cur_node->name];
//		if([cur_name isEqual:@"root"])
//		{
//			NSString *content = [NSString stringWithUTF8String:(char *)cur_node->children->content];
//			_error.status= content;
//		}else
        if([@"data" isEqual:cur_name])
        {
            U_info_Bean *comment = [[U_info_Bean alloc] init];
            xmlNodePtr c2_node =cur_node->children;
            xmlNodePtr cur2_node;
            for(cur2_node = c2_node;cur2_node;cur2_node=cur2_node->next)
            {
                NSString *cur2_name = [NSString stringWithUTF8String:(char *)cur2_node->name];
                if ([@"fansnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.fansnum =content;
                        
                    }else {
                        comment.fansnum=@"";
                    }
                }else if ([@"favnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.favnum =content;
                    }else {
                        comment.favnum=@"";
                    }
                }else if ([@"head" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.u_head =content;
                    }else {
                        comment.u_head=@"";
                    }
                }else if ([@"idolnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.idolnum =content;
                    }else {
                        comment.idolnum=@"";
                    }
                }else if ([@"tweetnum" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.tweetnum =content;
                    }else {
                        comment.tweetnum=@"";
                    }
                }else if ([@"name" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.u_name =content;
                    }else {
                        comment.u_name=@"";
                    }
                }else if ([@"nick" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.u_nick =content;
                    }else {
                        comment.u_nick=@"";
                    }
                }else if ([@"introduction" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.introduction =content;
                    }else {
                        comment.introduction=@"";
                    }
                }
                else if ([@"birth_day" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.birth_day =content;
                    }else {
                        comment.birth_day=@"";
                    }
                }
                else if ([@"birth_month" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.birth_month =content;
                    }else {
                        comment.birth_month=@"";
                    }
                }
                else if ([@"city_code" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.city_code =content;
                    }else {
                        comment.city_code=@"";
                    }
                }
                else if ([@"country_code" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.country_code =content;
                    }else {
                        comment.country_code=@"";
                    }
                }
                else if ([@"province_code" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.province_code =content;
                    }else {
                        comment.province_code=@"";
                    }
                }
                else if ([@"sex" isEqual:cur2_name]) {
                    if (cur2_node->children != nil)  {
                        NSString * content = [NSString stringWithUTF8String:(char *)cur2_node->children->content];
                        comment.sex =content;
                    }else {
                        comment.sex=@"";
                    }
                }else {
                }
            }
            [_commentArr addObject:comment];
            [comment release];
        }
    }
    xmlFreeDoc(doc);
    return YES;
}
@end
