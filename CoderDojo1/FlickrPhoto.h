//
//  FlickrPhoto.h
//  CoderDojo1
//
//  Created by Scott Parris on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *thumbNail;
@property (nonatomic, strong) NSURL *largeURL;

- (id)initWithTitle:(NSString *)_title thumbNail:(UIImage *)_thumbNail largeURL:(NSURL *)_largeURL;

@end
