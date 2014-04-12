//
//  TwitterViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface TwitterViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *tweets;
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)composeTweet:(id)sender;
- (IBAction)refresh:(id)sender;
- (void)getTweets;

@end
