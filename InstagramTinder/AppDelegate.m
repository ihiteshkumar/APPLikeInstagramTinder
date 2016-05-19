//
//  AppDelegate.m
//  InstagramTinder
//
//  Created by Hitesh Kumar on 18/05/16.
//  Copyright © 2016 Hitesh Kumar. All rights reserved.
//

#import "AppDelegate.h"
#import "SwipeViewController.h"
#import "LikeViewController.h"
#import "DisLikeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SwipeViewController *swipeVC = [[SwipeViewController alloc] init];
    swipeVC.tabBarItem.title = @"Feed";
    DisLikeViewController *disLikeVC = [[DisLikeViewController alloc] init];
    disLikeVC.tabBarItem.title = @"DisLiked";
    LikeViewController *likeVC = [[LikeViewController alloc] init];
    likeVC.tabBarItem.title = @"Liked";
    NSArray *myViewControllers = [[NSArray alloc] initWithObjects:disLikeVC,swipeVC,likeVC, nil];
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:myViewControllers];
    self.window.rootViewController = self.tabBarController;
    UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
    UITabBarItem* it;
    it = [[tabBar.tabBar items] objectAtIndex:0];
    it.titlePositionAdjustment = UIOffsetMake(-15.0, -15.0);
    it = [[tabBar.tabBar items] objectAtIndex:1];
    it.titlePositionAdjustment = UIOffsetMake(0.0, -15.0);
    it = [[tabBar.tabBar items] objectAtIndex:2];
    it.titlePositionAdjustment = UIOffsetMake(25.0, -15.0);
    [tabBar setSelectedIndex:1];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
