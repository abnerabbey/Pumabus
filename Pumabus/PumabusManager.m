//
//  PumabusManager.m
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 13/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import "PumabusManager.h"

//Hacer keys en la clase para llamar a los keys del dictionary
@implementation PumabusManager

+ (NSDictionary *)dictionaryWithPumabusStations
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"estaciones" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if(error)
        NSLog(@"error in [PumabusManager dictionaryWithPumabusStations]: %@", error);
    return dic;
}

+ (NSDictionary *)getNearestStationFromLocation:(CLLocation *)currentLocation
{
    double distMin = 0;
    double distAux = 0;
    NSMutableDictionary *nearestStation;
    NSDictionary *stationsDictionary = [self dictionaryWithPumabusStations];
    NSArray *arrayStations = [stationsDictionary objectForKey:@"estaciones"];
    for(int i = 0; i < [arrayStations count]; i++)
    {
        NSDictionary *station = [arrayStations objectAtIndex:i];
        double latStation = [[station objectForKey:@"lat"] doubleValue];
        double lonStation = [[station objectForKey:@"lon"] doubleValue];
        CLLocation *locationStation = [[CLLocation alloc] initWithLatitude:latStation longitude:lonStation];
        
        if(i == 0){
            distMin = [currentLocation distanceFromLocation:locationStation];
            nearestStation = [[NSMutableDictionary alloc] initWithDictionary:station];
            nearestStation[@"distance"] = [NSNumber numberWithDouble:distMin];
        }
        else{
            distAux = [currentLocation distanceFromLocation:locationStation];
            if(distAux < distMin){
                distMin = distAux;
                [nearestStation addEntriesFromDictionary:station];
                nearestStation[@"distance"] = [NSNumber numberWithDouble:distMin];
            }
        }
    }
    return (NSDictionary *)nearestStation;
}

+ (NSArray *)arrayWithStationsOfRoute:(int)numberOfRoute
{
    NSDictionary *allStations = [self dictionaryWithPumabusStations];
    NSArray *arrayStations = [allStations objectForKey:@"estaciones"];
    NSMutableArray *stations = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in arrayStations) {
        NSArray *rutas = [dictionary objectForKey:@"rut"];
        for(int i = 0; i < [rutas count]; i++)
        {
            int linea = [[rutas objectAtIndex:i] intValue];
            if(linea == numberOfRoute){
                [stations addObject:dictionary];
                break;
            }
        }
    }
    return (NSArray *)stations;
}

#pragma mark Helper Methods
+ (CLLocationCoordinate2D)convertValuesFromDictionaryToDegrees:(NSDictionary *)dictionary
{
    CLLocationCoordinate2D coordinate;
    double lat = [[dictionary objectForKey:@"lat"] doubleValue];
    double lon = [[dictionary objectForKey:@"lon"] doubleValue];
    coordinate.latitude = lat;
    coordinate.longitude = lon;
    return coordinate;
}

@end



































































