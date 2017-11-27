//
//  AppDelegate.m
//  MoCaCare
//
//  Created by xhb on 2017/9/5.
//  Copyright © 2017年 elysoft. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "AccountLoginTVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    id RootVC;
    if (M_CheckStrNil([ModelUser defaultUser]._token)) {
        RootVC = [MainTabBarController defaultTabBarController];
    } else {
        RootVC = [AccountLoginTVC defaultLoginNVC];
    }
    
    self.window.rootViewController = RootVC;
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    ModelUser *user = [ModelUser defaultClearUser];
    NSLog(@"usertoken:%@", user._token);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
