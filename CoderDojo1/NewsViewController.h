//
//  NewsViewController.h
//  CoderDojo1
//
//  Created by Scott Parris on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsParser.h"

@interface NewsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {

}

@property (nonatomic, strong) NewsParser *parser;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end
