//
//  PumabusManager.h
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 13/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PumabusManager : NSObject

+ (NSDictionary *)dictionaryWithPumabusStations;
+ (NSDictionary *)getNearestStationFromLocation:(CLLocation *)currentLocation;
+ (NSArray *)arrayWithStationsOfRoute:(int)numberOfRoute;
+ (NSArray *)arrayWithRouteCoordinates:(int)numberOfRoute;

//Helper Methods
+ (CLLocationCoordinate2D)convertValuesFromDictionaryToDegrees:(NSDictionary *)dictionary;

@end
