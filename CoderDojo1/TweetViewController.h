//
//  TweetViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>

@interface TweetViewController : UIViewController

@property (nonatomic, strong) NSDictionary *tweet;
@property (nonatomic, strong) NSMutableArray *tweetLinks;
@property (nonatomic, strong) UIView *tweetText;
@property (nonatomic, strong) UIImageView *tweetImage;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *created;
@property (nonatomic, strong) UIToolbar *tweetBar;
@property (nonatomic, strong) TWTweetComposeViewController *twitter;
@property (nonatomic, strong) ACAccount *twitterAccount;

- (void)composeTweet:(id)sender;
- (void)retweetMessage:(id)sender;
- (void)linkTapped:(id)sender;
- (void)showTweetStatus:(id)sender;

@end
