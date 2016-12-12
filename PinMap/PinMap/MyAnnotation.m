//
//  MyAnnotation.m
//  PinMap
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "MyAnnotation.h"

NSString *const kReusablePinRed = @"Red";
NSString *const kReusablePinGreen = @"Green";
NSString *const kReusablePinPurple = @"Purple";

@implementation MyAnnotation

-(instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinate title:(NSString *)paramTitle subTitle:(NSString *)paramSubtile {
    self = [super init];
    if (self != nil) {
        _coordinate = paramCoordinate;
        _title = paramTitle;
        _subtile = paramTitle;
        _pinColor = MKPinAnnotationColorGreen;
    }
    return self;
}

+(NSString *) resubaleIndentifierForPinColor: (MKPinAnnotationColor) paramColor {
    NSString *result = nil;
    switch (paramColor) {
        case MKPinAnnotationColorRed:
            result = kReusablePinRed;
            break;
        case MKPinAnnotationColorGreen:
            result = kReusablePinGreen;
            break;
        case MKPinAnnotationColorPurple:
            result = kReusablePinPurple;
            break;
    }
    return result;
}


@end

