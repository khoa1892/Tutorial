//
//  ViewController.m
//  CoreMotionTutorial
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    if ([self.motionManager isAccelerometerAvailable]) {
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            NSLog(@"X = %.04f, Y = %.04f, Z = %.04f",
                  accelerometerData.acceleration.x,
                  accelerometerData.acceleration.y,
                  accelerometerData.acceleration.z);
        }];
    } else {
        NSLog(@"Accelerometer is not available.");
    }
    
}

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shake" message:@"Shake" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
         [alert show];
    }
}

@end
