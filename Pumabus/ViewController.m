//
//  ViewController.m
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 12/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"

@interface ViewController ()

@property int numberOfRouteShown;

@property (nonatomic, strong)NSArray *arrayStations;
@property (nonatomic, strong)NSDictionary *nearestStation;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //variables and properties initializations
    self.numberOfRouteShown = 0;
    
    //Navigation bar customization
    self.navigationItem.title = @"Pumabús";
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Estaciones" style:UIBarButtonItemStylePlain target:self action:@selector(selectStationsView)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Rutas" style:UIBarButtonItemStylePlain target:self action:@selector(selectRoutesView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //Core Location Inizialization
    [LocationManager sharedInstance];
    [[[LocationManager sharedInstance] locationManager] setDelegate:self];
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
        [[[LocationManager sharedInstance] locationManager] requestWhenInUseAuthorization];
    if([CLLocationManager locationServicesEnabled])
        [[[LocationManager sharedInstance] locationManager] startUpdatingLocation];
    
    //MapView init
    self.mapView.delegate = self;
    
    //Method to set stations on the map
    [self setAllStationsOnMap];
    
    //tests
    //[PumabusManager arrayWithRouteCoordinates:1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setInitialRegionOnMap];
}

#pragma mark CLLocation Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.currentLocation = [locations lastObject];
    self.nearestStation = [PumabusManager getNearestStationFromLocation:self.currentLocation];
    self.labelNearestStation.text = [NSString stringWithFormat:@"Estación más cercana: %@", [self.nearestStation objectForKey:@"nom"]];
}

#pragma mark ModalViews Instantiates
- (void)selectStationsView
{
    StationsViewController *stationView = [[self storyboard] instantiateViewControllerWithIdentifier:@"stationsView"];
    stationView.delegate = self;
    stationView.numberOfRouteShown = self.numberOfRouteShown;
    [self createModalViewBlurStyle:stationView];
}

- (void)selectRoutesView
{
    RoutesViewController *routesView = [[self storyboard] instantiateViewControllerWithIdentifier:@"routesView"];
    [routesView setDelegate:self];
    [self createModalViewBlurStyle:routesView];
}

- (void)createModalViewBlurStyle:(UIViewController *)destinationViewController
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [blurView setFrame:destinationViewController.view.bounds];
    [destinationViewController.view insertSubview:blurView atIndex:0];
    destinationViewController.view.backgroundColor = [UIColor clearColor];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:destinationViewController];
    nv.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:nv animated:YES completion:nil];
}

#pragma mark Map Delegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *polylineView = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    polylineView.strokeColor = [UIColor blueColor];
    return polylineView;
}

#pragma ModalViews Delegates
- (void)didSelectRoute:(int)numberOfRoute
{
    self.numberOfRouteShown = numberOfRoute;
    [self setStationsOnMapOfRoute:numberOfRoute];
    [self setRoutePolylineOnMap:numberOfRoute];
    if(numberOfRoute == 0)
        self.navigationItem.title = @"Pumabús";
    else
        self.navigationItem.title = [NSString stringWithFormat:@"Ruta %d", numberOfRoute];
}

#pragma mark Load Methods
- (void)setAllStationsOnMap
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    NSDictionary *dictionaryStations = [PumabusManager dictionaryWithPumabusStations];
    self.arrayStations = [dictionaryStations objectForKey:@"estaciones"];
    for (NSDictionary *dictionary in self.arrayStations) {
        CLLocationCoordinate2D coordinate = [PumabusManager convertValuesFromDictionaryToDegrees:dictionary];
        MKPointAnnotation *pinStation = [[MKPointAnnotation alloc] init];
        pinStation.coordinate = coordinate;
        pinStation.title = [dictionary objectForKey:@"nom"];
        [[self mapView] addAnnotation:pinStation];
    }
}

- (void)setStationsOnMapOfRoute:(int)numberOfRoute
{
    if(numberOfRoute == 0)
        [self setAllStationsOnMap];
    else{
        [self.mapView removeAnnotations:self.mapView.annotations];
        NSArray *arrayOfStations = [PumabusManager arrayWithStationsOfRoute:numberOfRoute];
        for (NSDictionary *dictionary in arrayOfStations) {
            CLLocationCoordinate2D coordinate = [PumabusManager convertValuesFromDictionaryToDegrees:dictionary];
            MKPointAnnotation *pinStation = [[MKPointAnnotation alloc] init];
            pinStation.coordinate = coordinate;
            pinStation.title = [dictionary objectForKey:@"nom"];
            [[self mapView] addAnnotation:pinStation];
        }
    }
}

- (void)setRoutePolylineOnMap:(int)numberOfRoute
{
    if(numberOfRoute == 0)
        [self.mapView removeOverlays:self.mapView.overlays];
    else
    {
        [self.mapView removeOverlays:self.mapView.overlays];
        NSArray *array = [PumabusManager arrayWithRouteCoordinates:numberOfRoute];
        CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * [array count]);
        for(int i = 0; i < array.count; i++)
        {
            CLLocation *location = [array objectAtIndex:i];
            coords[i] = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
        }
        MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:array.count];
        [self.mapView addOverlay:polygon];
    }
}

- (void)setInitialRegionOnMap
{
    CLLocationCoordinate2D coordinate = {19.3215091, -99.1860215};
    MKCoordinateRegion span = MKCoordinateRegionMakeWithDistance(coordinate, 2600, 2600);
    [self.mapView setRegion:span animated:YES];
    
}

#pragma mark Helper Methods

@end





































































