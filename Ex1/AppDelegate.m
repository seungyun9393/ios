//
//  AppDelegate.m
//  Ex1
//
//  Created by e4net on 2020/01/15.
//  Copyright © 2020 e4net. All rights reserved.
//

#import "AppDelegate.h"
#import "View/MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    MainViewController *mainViewController = [[MainViewController alloc]
         initWithNibName:@"MainViewController" bundle:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];
    self.window.rootViewController= mainViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
