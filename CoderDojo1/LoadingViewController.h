//
//  LoadingViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 11/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController <UITabBarControllerDelegate>  {
    NSMutableData *flickrData;
    NSMutableArray *flickrCell;
    NSMutableArray *flickrCells;
    NSMutableDictionary *flickrPhotos;
}

@property (nonatomic, strong) NSURLConnection *flickrConnection;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)getFlickrPhotos;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)customizeAppearance;
- (void)loadTabs;


@end
