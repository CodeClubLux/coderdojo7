//
//  LocatorViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 6/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocatorViewController.h"

@implementation LocatorViewController

@synthesize webView, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Locate a Dojo", @"Locate a Dojo");
        self.tabBarItem.image = [UIImage imageNamed:@"locate"];
        CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [self.activityIndicator sizeToFit];
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
                                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        loadingView.target = self;
        self.navigationItem.rightBarButtonItem = loadingView; 
        UILabel *label = [[UILabel alloc] init];
        self.navigationItem.titleView = label;
        label.text = @"";
        webView.frame = self.view.frame;
        webView.scalesPageToFit = YES;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)viewDidLoad
{
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds]; 
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zen.coderdojo.com/dojo"]]];
    [webView setDelegate:self];
    [self.view addSubview:webView];
}

- (void)updateBackButton 
{
    if ([self.webView canGoBack]) {
        if (!self.navigationItem.leftBarButtonItem) {
            [self.navigationItem setHidesBackButton:YES animated:YES];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backWasClicked)];
            [self.navigationItem setLeftBarButtonItem:backItem animated:YES];
        }
    } else {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        [self.navigationItem setHidesBackButton:NO animated:YES];
    }
}

- (void)backWasClicked
{
    [webView goBack];
}

- (void)webViewDidStartLoad:(UIWebView *)webView 
{
    [self updateBackButton];
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView 
{
    [self updateBackButton];
    [self.webView stringByEvaluatingJavaScriptFromString:@"window.scrollTo(0.0, 50.0)"];
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
