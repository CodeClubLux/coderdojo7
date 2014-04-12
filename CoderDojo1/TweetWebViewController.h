//
//  TweetWebViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 11/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetWebViewController : UIViewController <UIWebViewDelegate> {
}

@property (nonatomic, strong) NSURL *twitterURL;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (id)initWithURL:(NSURL *)TwitterURL;

@end
