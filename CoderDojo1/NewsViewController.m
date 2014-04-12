//
//  NewsViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsItem.h"
#import "NewsDetailViewController.h"


@implementation NewsViewController

@synthesize parser, activityIndicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"News", @"News");
        self.tabBarItem.image = [UIImage imageNamed:@"news"];
        [self.tableView setRowHeight:75];
        CGRect frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [self.activityIndicator sizeToFit];
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
             UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        loadingView.target = self;
        self.navigationItem.rightBarButtonItem = loadingView; 
        [self.activityIndicator startAnimating];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad]; 
    NSURL *url = [NSURL URLWithString:@"https://news.google.com/news/feeds?q=coderdojo&hl=en&prmd=imvns&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.,cf.osb&biw=1680&bih=858&um=1&ie=UTF-8&output=rss"];
    parser = [[NewsParser alloc] initWithURL:url];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.activityIndicator stopAnimating];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == YES);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [parser.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NewsItem *item = [parser.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    [cell.textLabel setNumberOfLines:3];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = item.date;
    [cell.detailTextLabel setNumberOfLines:1];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];        
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsItem *item = [parser.items objectAtIndex:indexPath.row];
    NewsDetailViewController *webView = [[NewsDetailViewController alloc] initWithNewsItem:item];
    [(UIActivityIndicatorView *)[self navigationItem].rightBarButtonItem.customView startAnimating];
    [self.navigationController pushViewController:webView animated:YES];
}

@end
