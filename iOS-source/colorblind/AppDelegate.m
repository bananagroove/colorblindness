//
//  AppDelegate.m
//  colorblind
//
//  Created by Fábio Lima on 3/23/13.
//  Copyright (c) 2013 Banana Groove Studios. All rights reserved.
//

#import "TestFlight.h"
#import "AppDelegate.h"

@implementation AppDelegate

@synthesize deckController, currentDeviceToken, booBlindness, booPauseCapture, currentColor, currentColorString, navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [TestFlight takeOff:@"092a9ec5-7bc9-48a4-b19f-a489cf191a3b"];
    
    // prepare view controllers
    _leftController     = [[CBConfigViewController alloc] init];
    _rightController    = [[CBPuzzleViewController alloc] init];
    _viewController     = [[CBViewController alloc] init];
    
    deckController =  [[IIViewDeckController alloc] initWithCenterViewController:_viewController leftViewController:_leftController rightViewController:_rightController];
    
    [deckController setLeftSize:0];
    [deckController setRightSize:0];
    [deckController setShadowEnabled:false];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:deckController];
    navigationController.navigationBar.hidden = YES;
    self.window.rootViewController = navigationController;

    //Check if app has runned before to set initial view controller
    if(![self checkIfFirstRun]){
        CBTutorialViewController *tutorilViewController = [[CBTutorialViewController alloc]init];
        [navigationController pushViewController:tutorilViewController animated:YES];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)checkIfFirstRun {
    
    //Get the first run object from defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id runned = [defaults objectForKey:@"firstRun"];
    
    //Check if app has been runned before, if not fill and Sync
    if (!runned){
        //[defaults setObject:[NSDate date] forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    //Return if app has runned before
    return (BOOL)runned;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
