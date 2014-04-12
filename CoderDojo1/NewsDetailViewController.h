//
//  NewsDetailViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface NewsDetailViewController : UIViewController <UIWebViewDelegate> {
   
}

@property (nonatomic, strong) NewsItem *newsItem;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (id)initWithNewsItem:(NewsItem *)selectedNewsItem;

@end
