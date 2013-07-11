//
//  Category_Parse.m
//  WeiBo
//
//  Created by hcui on 13-7-10.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "Category_Parse.h"
#import "Category_Bean.h"

@implementation Category_Parse
+(BOOL) parseArrXML:(NSString *)xml commentArr:(NSMutableArray*)_commentArr return_bean:(Return_Bean*)_return_bean
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
                    Category_Bean *comment = [[Category_Bean alloc] init];
                    xmlNodePtr c3_node =cur2_node->children;
                    xmlNodePtr cur3_node;
                    for(cur3_node = c3_node;cur3_node;cur3_node=cur3_node->next)
                    {
                        NSString *cur3_name = [NSString stringWithUTF8String:(char *)cur3_node->name];
                        if ([@"child_id" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.child_id =[content integerValue];
                                
                            }else {
                                comment.child_id=0;
                            }
                        }else if ([@"child_name" isEqual:cur3_name]) {
                            if (cur3_node->children != nil)  {
                                NSString * content = [NSString stringWithUTF8String:(char *)cur3_node->children->content];
                                comment.child_name =content;
                            }else {
                                comment.child_name=@"";
                            }
                        }else
                        {
                        }
                        
                    }
                     // NSLog(@"origfrom===>%@，id===>%d",comment.child_name,comment.child_id);
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
