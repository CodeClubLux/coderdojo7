//
//  AboutScrollViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutScrollViewController.h"
#import "AboutPhotoViewController.h"
#import "FlickrPhoto.h"

@implementation AboutScrollViewController

@synthesize scrollView;

- (id)initWithFlickrCells:(NSArray *)_flickrCells FlickrPhotos:(NSDictionary *)_flickrPhotos
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"About", @"About");
        self.tabBarItem.image = [UIImage imageNamed:@"about"];
        flickrPhotos = _flickrPhotos;
        flickrCells = _flickrCells;
        photos = [[NSMutableArray alloc] init];
        UILabel *label = [[UILabel alloc] init];
        self.navigationItem.titleView = label;
        label.text = @"";    
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(IBAction)buttonPressed:(id)sender
{
    int tag = [sender tag];
	// NSLog(@"...item = %i", tag);
    FlickrPhoto *zoomPhoto = [photos objectAtIndex:tag];
    AboutPhotoViewController *photoView = [[AboutPhotoViewController alloc] init];
    photoView.photo = zoomPhoto;
    [photoView.activityIndicator startAnimating];
    [self.navigationController pushViewController:photoView animated:YES];
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIScreen *screen = [UIScreen mainScreen];
    float pageWidth = screen.bounds.size.width;
    float pageHeight = screen.bounds.size.height;    

    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, pageWidth, pageHeight)];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [scrollView setAutoresizingMask:UIViewAutoresizingNone];
    [scrollView setContentSize:CGSizeMake(pageWidth, 1230.0)];
    scrollView.showsVerticalScrollIndicator = YES;
    [self.view insertSubview:scrollView atIndex:0];
    UIImageView *cdBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pageWidth, 118.0)];
    cdBanner.image = [UIImage imageNamed:@"dojo_class_banner.jpg"];
    [scrollView addSubview:cdBanner];
    UITextView *aboutText = [[UITextView alloc] initWithFrame:CGRectMake(0, 118.0, pageWidth, 98.0)];
    aboutText.editable = NO;
    aboutText.text = @"CoderDojo is a free coding club where kids around the world learn how to express themselves with digital tools, make cool stuff, have fun and share with the community.";
    [aboutText setFont:[UIFont systemFontOfSize:14]];
    aboutText.textColor = [UIColor blackColor];
    aboutText.backgroundColor = [UIColor whiteColor];    
    [scrollView addSubview:aboutText];
    int i = 0;
    int yy = 225;
    NSArray* reversedFlickrCells = [[flickrCells reverseObjectEnumerator] allObjects];

    for (NSArray *arr in reversedFlickrCells) {
        int xx = 0;
        for (NSString *fid in arr) {
            FlickrPhoto *photo = [flickrPhotos objectForKey:fid];
            CGRect rect = CGRectMake(xx, yy, 150, 150);
            xx = 161;
            
			UIButton *button = [[UIButton alloc] initWithFrame:rect];
			[button setFrame:rect];
			UIImage *buttonImageNormal = photo.thumbNail;
			[button setBackgroundImage:buttonImageNormal forState:UIControlStateNormal];
			[button setContentMode:UIViewContentModeCenter]; 
            button.tag = i;
            [photos addObject:photo];
            i += 1;
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:button];    
        }
        yy += 161;
    }
    UITextView *disclaimerText = [[UITextView alloc] initWithFrame:CGRectMake(0, yy + 10, pageWidth, 70.0)];
    disclaimerText.editable = NO;
    disclaimerText.text = @"This app does not collect any personally identifiable information. Developed by Scott Parris and Shara Karasic. Contact Scott at scott@stparris.com and Shara at shara@coderdojo.com.";
    disclaimerText.textColor = [UIColor whiteColor];
    disclaimerText.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:disclaimerText];
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
