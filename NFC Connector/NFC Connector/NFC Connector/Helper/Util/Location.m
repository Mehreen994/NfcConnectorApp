//
//  Location.m
//  NFC Connector
//
//  Created by Mehreen kanwal on 26.09.19.
//  Copyright © 2019 Auguris. All rights reserved.
//

#import "Location.h"

@implementation Location


+(Location*) sharedObject {
    static Location* sharedObject;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });

    return sharedObject;
}

-(void) getLocation:(NSString*) calledBy tag:(NSString*) tid {
    self.caller = calledBy;
    self.tagId = tid;
    if([CLLocationManager locationServicesEnabled]){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        }
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager startUpdatingLocation];

    } else {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = 0.0f;
        coordinate.longitude = 0.0f;
        [_locationManager stopUpdatingLocation];
        if ([_delegate respondsToSelector:@selector(onLocationFound:calledBy:tag:)]) {
            [_delegate onLocationFound:coordinate calledBy:self.caller tag:_tagId];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = locations.count > 0 ? locations[0] : nil;
    if(newLocation) {
        _locationManager.delegate = nil;
        [_locationManager stopUpdatingLocation];
        NSLog(@"latitude : %f longitude : %f",newLocation.coordinate.latitude, newLocation.coordinate.longitude);
        if ([_delegate respondsToSelector:@selector(onLocationFound:calledBy:tag:)]) {
            [_delegate onLocationFound:newLocation.coordinate calledBy:_caller tag:_tagId];
        }
    } else {
        [_locationManager stopUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error in location %@", error);
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 0.0f;
    coordinate.longitude = 0.0f;
    [_locationManager stopUpdatingLocation];
    if ([_delegate respondsToSelector:@selector(onLocationFound:calledBy:tag:)]) {
        [_delegate onLocationFound:coordinate calledBy:self.caller tag:_tagId];
    }
}

@end
