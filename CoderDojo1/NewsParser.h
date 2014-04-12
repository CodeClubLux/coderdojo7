//
//  NewsParser.h
//  CoderDojo1
//
//  Created by Scott Parris on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsItem.h"

@interface NewsParser : NSObject <NSXMLParserDelegate> {
    NSMutableString *currentNodeValue;
    NewsItem *currentItem;
    NSXMLParser *parser;
}

@property (nonatomic, strong) NSMutableArray *items;

-(id) initWithURL:(NSURL *)url;

@end
