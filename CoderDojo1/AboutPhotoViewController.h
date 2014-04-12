//
//  AboutPhotoViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface AboutPhotoViewController : UIViewController

@property (nonatomic, strong) FlickrPhoto *photo;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
