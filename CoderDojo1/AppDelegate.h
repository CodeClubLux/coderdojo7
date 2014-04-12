//
//  AppDelegate.h
//  CoderDojo1
//
//  Created by Scott Parris on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate> 

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *loadingView;
@property (strong, nonatomic) UITabBarController *tabBarController;

@end
