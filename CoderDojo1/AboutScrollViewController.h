//
//  AboutScrollViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutScrollViewController : UIViewController <UIScrollViewDelegate> {
    NSArray *flickrCells;
    NSDictionary *flickrPhotos;
    NSMutableArray *photos;
}

@property (nonatomic, strong) UIScrollView *scrollView;

- (id)initWithFlickrCells:(NSArray *)_flickrCells FlickrPhotos:(NSDictionary *)_flickrPhotos;
- (IBAction)buttonPressed:(id)sender;

@end
