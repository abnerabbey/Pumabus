//
//  StationsViewController.m
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 13/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import "StationsViewController.h"

@interface StationsViewController ()

@property (nonatomic, strong)NSArray *arrayStations;

@end

@implementation StationsViewController
{
    NSArray *sortedArrayStations;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Navigation Bar Inits
    if(self.numberOfRouteShown == 0)
        self.navigationItem.title = @"Estaciones";
    else
        self.navigationItem.title = [NSString stringWithFormat:@"Estaciones Ruta %d", self.numberOfRouteShown];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //Stations customizations
    self.arrayStations = [self getStationsOfRoute:self.numberOfRouteShown];
    sortedArrayStations = [self sortArrayAlphabetically:self.arrayStations];
    
    //Table View Setup
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark TableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayStations count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Estaciones: %d", (int)[self.arrayStations count]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    NSDictionary *dictionaryStation = [sortedArrayStations objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionaryStation objectForKey:@"nom"];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Load Methods
- (NSArray *)getStationsOfRoute:(int)numberOfRoute
{
    NSArray *arrayStations;
    if(numberOfRoute == 0){
        NSDictionary *dictionary = [PumabusManager dictionaryWithPumabusStations];
        arrayStations = [dictionary objectForKey:@"estaciones"];
    }
    else{
        arrayStations = [PumabusManager arrayWithStationsOfRoute:numberOfRoute];
    }
    return arrayStations;
}

#pragma mark Helper Methods
- (NSArray *)sortArrayAlphabetically:(NSArray *)array
{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nom" ascending:YES];
    NSArray *sortDesciptor = [NSArray arrayWithObject:nameDescriptor];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:sortDesciptor];
    return sortedArray;
}

@end





































































