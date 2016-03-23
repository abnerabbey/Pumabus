//
//  RoutesViewController.m
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 12/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import "RoutesViewController.h"

@interface RoutesViewController ()

@end

@implementation RoutesViewController
{
    NSArray *arrayRoutes;
    float red, green, blue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Rutas";
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStylePlain target:self action:@selector(cancelView)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    arrayRoutes = [NSArray arrayWithObjects:@"Ninguna", @"Ruta 1", @"Ruta 2", @"Ruta 3", @"Ruta 4", @"Ruta 5", @"Ruta 6", @"Ruta 7", @"Ruta 8", @"Ruta 9", @"Ruta 10", @"Ruta 11", @"Ruta 12", nil];
    
    self.tableViewRoutes.delegate = self;
    self.tableViewRoutes.dataSource = self;
}

#pragma mark TableView Delegates
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayRoutes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCell = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    if(!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idCell];
    cell.textLabel.text = [arrayRoutes objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    //Setting the route color
    UIView *colorView = [cell viewWithTag:1];
    if(indexPath.row == 0)
        colorView.backgroundColor = [UIColor clearColor];
    else{
        NSDictionary *routeDic = [PumabusManager dictionaryWithPumabusRoute:(int)indexPath.row];
        NSArray *colors = [routeDic objectForKey:@"col"];
        red = [[colors objectAtIndex:0] floatValue]/255;
        green = [[colors objectAtIndex:1] floatValue]/255;
        blue = [[colors objectAtIndex:2] floatValue]/255;
        colorView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self delegate] didSelectRoute:(int)indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0;
}

#pragma mark Methods unamed
- (void)cancelView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end





































































