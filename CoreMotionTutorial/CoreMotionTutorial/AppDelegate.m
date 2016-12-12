//
//  AppDelegate.m
//  CoreMotionTutorial
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreMotion/CoreMotion.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
//    
//    if ([motionManager isGyroAvailable]) {
//        if ([motionManager isGyroActive] == NO) {
//            [motionManager setGyroUpdateInterval:1.0f / 40.0f];
//            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//            [motionManager startGyroUpdatesToQueue:queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
//                NSLog(@"Gyro Rotation x = %.04f", gyroData.rotationRate.x);
//                NSLog(@"Gyro Rotation y = %.04f", gyroData.rotationRate.y);
//                NSLog(@"Gyro Rotation z = %.04f", gyroData.rotationRate.z);
//            }];
//        } else {
//            NSLog(@"Gyro is not available.");
//        }
//    } else {
//        NSLog(@"Gyro is not available.");
//    }
    
    
    
//    
//    if ([motionManager isAccelerometerActive]) {
//        NSLog(@"Accelerometer is active.");
//    } else {
//        NSLog(@"Accelerometer is not active.");
//    }
//    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
