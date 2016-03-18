//
//  ViewController.h
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 12/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#import "RoutesViewController.h"
#import "StationsViewController.h"
#import "PumabusManager.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, RoutesViewDelegate, StationsViewDelegate>

//IBOutlets
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *labelNearestStation;

//Public Properties
@property (nonatomic, strong)CLLocation *currentLocation;

@end

