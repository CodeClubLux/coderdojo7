//
//  NewsItem.h
//  CoderDojo1
//
//  Created by Scott Parris on 6/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *description;

@end
