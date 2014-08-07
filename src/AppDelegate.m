//  Copyright (c) 2012 - 2014 Sean Olszewski. All rights reserved.

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (void)dealloc {
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.viewController = [[[ViewController alloc] initWithNibName:@"MainView" bundle: nil] autorelease];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
	{}

- (void)applicationDidEnterBackground:(UIApplication *)application
	{}

- (void)applicationWillEnterForeground:(UIApplication *)application
	{}

- (void)applicationDidBecomeActive:(UIApplication *)application
	{}

- (void)applicationWillTerminate:(UIApplication *)application
	{}

@end
