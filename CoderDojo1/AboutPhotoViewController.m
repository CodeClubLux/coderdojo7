//
//  AboutPhotoViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutPhotoViewController.h"

@implementation AboutPhotoViewController

@synthesize photo, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [self.activityIndicator sizeToFit];
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
                                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        loadingView.target = self;
        self.navigationItem.rightBarButtonItem = loadingView;
        [self.activityIndicator startAnimating];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSData *imageData = [NSData dataWithContentsOfURL:photo.largeURL];
    UIImageView *fullsizeImage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
    
    // Center the image...
    int width = fullsizeImage.frame.size.width;
    int height = fullsizeImage.frame.size.height; 
    [fullsizeImage setFrame:CGRectMake(0, 0, width, height)];     
    fullsizeImage.userInteractionEnabled = YES;                                      
    [self.view addSubview:fullsizeImage];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 280.0, 310.0, 50.0)];
    title.backgroundColor = [UIColor blackColor];
    title.textColor = [UIColor lightTextColor];
    title.numberOfLines = 2;
    title.text = photo.title;
    title.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:title];
    [self.activityIndicator stopAnimating];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
