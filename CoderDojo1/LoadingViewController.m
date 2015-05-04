//
//  LoadingViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 11/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingViewController.h"
#import "FlickrPhoto.h"
#import "AboutScrollViewController.h"
#import "ResourcesViewController.h"
#import "NewsViewController.h"
#import "TwitterViewController.h"
#import "LocatorViewController.h"

#define kFlickrKey "a5891c385ca0532ee7b6584c722a533a"
#define kFlickrSecret "3f8ea7c77f8049da"

NSString *const kFlickrAPIKey = @"a5891c385ca0532ee7b6584c722a533a";

@implementation LoadingViewController

@synthesize flickrConnection;
@synthesize activityIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self customizeAppearance];
        UILabel *label = [[UILabel alloc] init];
        self.navigationItem.titleView = label;
        label.text = @"";  
        UIScreen *screen = [UIScreen mainScreen];
        UIImageView *cdLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, screen.bounds.size.width, 45.0)];
        cdLogo.image = [UIImage imageNamed:@"dojologoPortrait"];
        [self.view addSubview:cdLogo];
        UIImageView *cdBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 45.0, screen.bounds.size.width, 118.0)];
        cdBanner.image = [UIImage imageNamed:@"dojo_class_banner.jpg"];
        [self.view addSubview:cdBanner];
        
        UITextView *aboutText = [[UITextView alloc] initWithFrame:CGRectMake(0, 163.0, screen.bounds.size.width, 98.0)];
        aboutText.editable = NO;
        aboutText.text = @"CoderDojo is a free coding club where kids around the world learn how to express themselves with digital tools, make cool stuff, have fun and share with the community.";
        [aboutText setFont:[UIFont systemFontOfSize:14]];
        aboutText.textColor = [UIColor blackColor];
        aboutText.backgroundColor = [UIColor whiteColor];    
        [self.view addSubview:aboutText];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150.0, 350.0, screen.bounds.size.width, 25.0)];
        [self.activityIndicator sizeToFit];
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
                                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        [self.view addSubview:activityIndicator];
        flickrCells = [[NSMutableArray alloc] init];
        flickrPhotos = [[NSMutableDictionary alloc] init];
        [self getFlickrPhotos];
    }
    return self;
}


- (void)customizeAppearance
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"dojologo7portrait.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"dojologo7landscape.png"] forBarMetrics:UIBarMetricsLandscapePhone];

}

- (void)loadTabs
{ 
    UIViewController *viewController1 = [[AboutScrollViewController alloc] initWithFlickrCells:flickrCells FlickrPhotos:flickrPhotos];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:viewController1];    
    UIViewController *viewController2 = [[ResourcesViewController alloc] init];
    UINavigationController *resourceNav = [[UINavigationController alloc] initWithRootViewController:viewController2];    
    UIViewController *viewController3 = [[NewsViewController alloc] init];
    UINavigationController *newsNav = [[UINavigationController alloc] initWithRootViewController:viewController3];
    UIViewController *viewController4 = [[TwitterViewController alloc] init];
    UINavigationController *twitterNav = [[UINavigationController alloc] initWithRootViewController:viewController4];
    UIViewController *viewController5 = [[LocatorViewController alloc] init];
    UINavigationController *locatorNav = [[UINavigationController alloc] initWithRootViewController:viewController5];
    
    [self customizeAppearance];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [NSArray arrayWithObjects:aboutNav, resourceNav, newsNav, twitterNav, locatorNav, nil];
    [self presentModalViewController:tabBarController animated:NO];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *realResponse = (NSHTTPURLResponse *)response;
    if (realResponse.statusCode == 200){ 
        flickrData = [[NSMutableData alloc] init];
        // NSLog(@"Good response");
    } else {
        // NSLog(@"Bad response = %i",realResponse.statusCode);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (flickrConnection == connection){
        [flickrData appendData:data];
        // NSLog(@"Getting data...");
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (flickrConnection == connection){
        NSError *error = nil;
        NSDictionary *results = [NSJSONSerialization
                                 JSONObjectWithData:flickrData
                                 options:NSJSONReadingMutableLeaves
                                 error:&error]; 
        NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
        int i = 0;
        for (NSDictionary *photo in photos) {
            NSString *fid = [photo objectForKey:@"id"];
            NSString *rtitle = [photo objectForKey:@"title"];
            NSString *title = (rtitle.length > 0 ? rtitle : @"untitled");
            NSString *photoURLString = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_q.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            NSData *thumbData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]; 
            UIImage *thumb = [[UIImage alloc] initWithData:thumbData];  
            photoURLString = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_n.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
            FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithTitle:title thumbNail:thumb largeURL:[NSURL URLWithString:photoURLString]];
            
            [flickrPhotos setObject:flickrPhoto forKey:fid];
            if (i == 0) {
                flickrCell = [[NSMutableArray alloc] init];
                [flickrCell addObject:fid];
                i += 1;
            } else {
                [flickrCell addObject:fid];
                [flickrCells addObject:flickrCell];
                flickrCell = nil;
                i = 0;
            }
            flickrPhoto = nil;
        }
        
        [self.activityIndicator stopAnimating];
        flickrConnection = nil;
        [self loadTabs];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    flickrConnection = nil;
    // NSLog(@"Oh no! Error:%@",error.localizedDescription);
}

- (void)getFlickrPhotos
{
    NSString *flickrUrl = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=coderdojo&per_page=10&format=json&nojsoncallback=1", kFlickrAPIKey];
    // NSLog(@"url: %@", flickrUrl);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:flickrUrl]];
    flickrConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.activityIndicator startAnimating];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
