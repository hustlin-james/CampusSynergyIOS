//
//  AppDelegate.m
//  CampusSynergy
//
//  Created by feifan meng on 8/30/13.
//  Copyright (c) 2013 mobi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Parse API
    //Load the api_key.config file and Set the applicationID and clientKeys
    
    //Add parse setup code here
    
    // Override point for customization after application launch.
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"api_key" ofType:@"config"];
    
    //Check that the file exists, which stores the application_id and client_key
    //for parsed
    if (filePath) {
            NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
            NSLog(@"ApplicationID: %@", json[@"parse_application_id"]);
            NSLog(@"Client_Key: %@", json[@"client_key"]);
            [Parse setApplicationId:@"QuoI3WPv5g9LyP4awzhZEH8FvRKIgWgFEdFJSTmB"
                      clientKey:@"DsDAvLDiDSLQ9VFOLRte3Ck7Yk1MmJONfeUWjZ5V"];
    }
    else{
        NSLog(@"Error Unable to retrieve api_key.config file");
    }
    
    return YES;
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
