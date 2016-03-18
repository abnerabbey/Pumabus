//
//  LocationManager.m
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 12/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

+ (LocationManager *)sharedInstance
{
    static LocationManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LocationManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if(self){
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.pausesLocationUpdatesAutomatically = YES;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.activityType = CLActivityTypeOtherNavigation;
    }
    return self;
}

@end
