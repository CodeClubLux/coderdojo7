//
//  NewsParser.m
//  CoderDojo1
//
//  Created by Scott Parris on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsParser.h"

@implementation NewsParser

@synthesize items;

-(id)initWithURL:(NSURL *)url
{
    items = [[NSMutableArray alloc] init];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
        attributes:(NSDictionary *)attributeDict 
{
    if ([elementName isEqualToString:@"item"]) {
        currentItem = [[NewsItem alloc] init];
    } else {
        currentNodeValue = [[NSMutableString alloc] init];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentNodeValue) {
        currentNodeValue = [[NSMutableString alloc] initWithCapacity:50];
    }
    [currentNodeValue appendString:string];    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
        namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
    if ([elementName isEqualToString:@"title"]) {
        currentItem.title = currentNodeValue;
        currentNodeValue = nil;
    }
    if ([elementName isEqualToString:@"link"]) {
        currentItem.link = currentNodeValue;
        currentNodeValue = nil;
    }
    if ([elementName isEqualToString:@"pubDate"]) {
        currentItem.date = currentNodeValue;
        currentNodeValue = nil;
    }
    if ([elementName isEqualToString:@"description"]) {
        currentItem.description = currentNodeValue;
        currentNodeValue = nil;        
    }
    if ([elementName isEqualToString:@"item"]) {
        [items addObject:currentItem];
        currentItem = nil;
        return;
    }
    
    
}

@end
