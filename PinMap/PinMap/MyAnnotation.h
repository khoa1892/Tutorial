//
//  MyAnnotation.h
//  PinMap
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

extern NSString *const kReusablePinRed;
extern NSString *const kReusablePinGreen;
extern NSString *const kReusablePinPuple;

@interface MyAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtile;
-(instancetype) initWithCoordinates:(CLLocationCoordinate2D) paramCoordinate
                              title:(NSString *) paramTitle
                           subTitle: (NSString *) paramSubtile;
@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;
+(NSString *) resubaleIndentifierForPinColor: (MKPinAnnotationColor) paramColor;
@end
