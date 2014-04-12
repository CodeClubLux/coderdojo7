//
//  TwitterViewController.m
//  CoderDojo1
//
//  Created by Scott Parris on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterViewController.h"
#import "TweetViewController.h"
#import <Twitter/Twitter.h>

@implementation TwitterViewController

@synthesize activityIndicator;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = NSLocalizedString(@"Twitter", @"Twitter");
        self.tabBarItem.image = [UIImage imageNamed:@"twitter"];
        [self.tableView setRowHeight:110];
        CGRect frame = CGRectMake(10.0, 10.0, 25.0, 25.0);
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        [self.activityIndicator sizeToFit];
        self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | 
                                                   UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
        UIBarButtonItem *loadingView = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
        loadingView.target = self;
        UIBarButtonItem *tweeter = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeTweet:)];
        self.navigationItem.rightBarButtonItem = tweeter;
        UIBarButtonItem *refresh =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: refresh, loadingView, nil];
        UILabel *label = [[UILabel alloc] init];
        self.navigationItem.titleView = label;
        label.text = @"";
        [self getTweets];

    }
    return self;
}

- (IBAction)refresh:(id)sender
{
    [self.activityIndicator startAnimating];
 //   NSLog(@"activityView=%@ isMainThread=%d", activityIndicator, [NSThread isMainThread]);
    [self getTweets];
}

- (void)composeTweet:(id)sender
{
    TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
    [twitter setInitialText:@"#coderdojo"];
    [self presentViewController:twitter animated:YES completion:nil];
    twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) {
        NSString *title = @"Tweet Status";
        NSString *msg;
        if(result == TWTweetComposeViewControllerResultDone) {
            msg = @"Tweet composition completed.";
        }
        if(result == TWTweetComposeViewControllerResultCancelled) {
            msg = @"Tweet compostion was canceled.";
        }
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
        
        [self dismissModalViewControllerAnimated:YES];
    };
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)getTweets {
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                 NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                 [params setObject:@"50" forKey:@"count"];
                 [params setObject:@"coderdojo" forKey:@"q"];

                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:params];
                 
                 postRequest.account = twitterAccount;
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      NSDictionary *results = [NSJSONSerialization
                                               JSONObjectWithData:responseData
                                               options:NSJSONReadingMutableLeaves
                                               error:&error];
                      
                      NSArray *resultKeys = [results allKeys];
                      tweets = [[NSMutableArray alloc] init];
                      for (NSString *key in resultKeys) {
                          if ([key isEqualToString:@"statuses"]) {
                              NSArray *statuses = [results objectForKey:key];
                              for (id object in statuses) {
                                  NSMutableDictionary *tweet = [[NSMutableDictionary alloc] init];
                                  NSArray *statusKeys = [object allKeys];
                                  for (NSString *skey in statusKeys) {
                                      if ([skey isEqualToString:@"id"]) {
                                          [tweet setValue:[object objectForKey:skey] forKeyPath:skey];
                                      }
                                      if ([skey isEqualToString:@"text"]) {
                                          [tweet setValue:[object objectForKey:skey] forKeyPath:skey];
                                      }
                                      if ([skey isEqualToString:@"user"]) {
                                          NSDictionary *user = [object objectForKey:skey];
                                          NSArray *userKeys = [user allKeys];
                                          for (NSString *ukey in userKeys) {
                                              // NSLog(@"user key is %@ and obj %@", ukey, [user objectForKey:ukey]);
                                              if ([ukey isEqualToString:@"name"]) {
                                                  [tweet setValue:[user objectForKey:ukey] forKeyPath:ukey];
                                              }
                                              if ([ukey isEqualToString:@"profile_image_url_https"]) {
                                                  [tweet setValue:[user objectForKey:ukey] forKeyPath:ukey];
                                              }
                                              if ([ukey isEqualToString:@"screen_name"]) {
                                                  [tweet setValue:[user objectForKey:ukey] forKeyPath:ukey];
                                              }
                                              if ([ukey isEqualToString:@"location"]) {
                                                  [tweet setValue:[user objectForKey:ukey] forKeyPath:ukey];
                                              }
                                              if ([ukey isEqualToString:@"created_at"]) {
                                                  [tweet setValue:[user objectForKey:ukey] forKeyPath:ukey];
                                              }
                                          }
                                      }
                                      // NSLog(@"status key is %@ and obj %@", skey, [object objectForKey:skey]);
                                  }
                                  [tweets addObject:tweet];
                              }
                          }
                      }
                      if (tweets.count != 0) {
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self.tableView reloadData];
                          });
                      }

                }];
            }
         } else {
             // Handle failure to get account access
         }
     }];
    [self.activityIndicator stopAnimating];

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
/**    ACAccountStore *account = [[ACAccountStore alloc]init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
        if (granted == YES) {
            NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
            if ([arrayOfAccounts count] > 0) {
                self.twitterAccount = [arrayOfAccounts firstObject];
            }
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    
    [self getTweets];
*/
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *tweet = [tweets objectAtIndex:indexPath.row];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[tweet objectForKey:@"profile_image_url_https"]]];
    cell.imageView.image = [UIImage imageWithData:imageData];
    cell.textLabel.text = [tweet objectForKey:@"name"];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.detailTextLabel.text = [tweet objectForKey:@"text"];
    [cell.detailTextLabel setNumberOfLines:6];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TweetViewController *tweetView = [[TweetViewController alloc] init];
    tweetView.tweet = [tweets objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:tweetView animated:YES];
}

@end
