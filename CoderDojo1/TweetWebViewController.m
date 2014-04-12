//
//  TweetWebViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 11/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetWebViewController.h"

@implementation TweetWebViewController

@synthesize twitterURL, webView, activityIndicator;

- (id)initWithURL:(NSURL *)TwitterURL {
	if (self = [super init]) {
        self.twitterURL = TwitterURL;
        CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [self.activityIndicator sizeToFit];
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
                                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        loadingView.target = self;
        self.navigationItem.rightBarButtonItem = loadingView;
        self.webView.frame = self.view.frame;
        self.webView.scalesPageToFit = YES;
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

- (void)viewDidLoad
{
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds]; 
    [webView loadRequest:[NSURLRequest requestWithURL:self.twitterURL]];
    [webView setDelegate:self];
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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
