//
//  ViewController.m
//  PinMap
//
//  Created by Khoa on 11/11/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

@interface ViewController ()<MKMapViewDelegate>
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth
                                    | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.mapView];
    
    CLLocationCoordinate2D location;
//    10.767683, 106.695179
    location.latitude = 10.767683;
    location.longitude = 106.695179;
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:location title:@"Title" subTitle:@"SubTitle"];
    annotation.pinColor = MKPinAnnotationColorPurple;
    [self.mapView addAnnotation:annotation];
}
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKAnnotationView *result = nil;
    if ([annotation isKindOfClass:[MyAnnotation class]] == NO) {
        return result;
    }
    if ([mapView isEqual:self.mapView] == NO) {
        return result;
    }
    MyAnnotation *senderAnnotation = (MyAnnotation *) annotation;
    NSString *pinResuableIdentifier = [MyAnnotation resubaleIndentifierForPinColor:senderAnnotation.pinColor];
    MKPinAnnotationView  *annotationView = (MKPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:pinResuableIdentifier];
    if (annotationView != nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:senderAnnotation reuseIdentifier:pinResuableIdentifier];
        [annotationView setCanShowCallout:YES];
    }
    annotationView.pinColor = senderAnnotation.pinColor;
    result = annotationView;
    return result;
}

@end
