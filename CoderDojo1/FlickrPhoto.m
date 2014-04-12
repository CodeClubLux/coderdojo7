//
//  FlickrPhoto.m
//  CoderDojo1
//
//  Created by Scott Parris on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

@synthesize title, thumbNail, largeURL;

- (id)initWithTitle:(NSString *)_title thumbNail:(UIImage *)_thumbNail largeURL:(NSURL *)_largeURL 
{
	if ((self = [super init])) {
		self.title = _title;
        self.thumbNail = _thumbNail;
        self.largeURL = _largeURL;
	}
	return self;    
}

@end
