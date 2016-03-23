//
//  RoutesViewController.h
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 12/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PumabusManager.h"

@protocol RoutesViewDelegate <NSObject>

- (void)didSelectRoute:(int)numberOfRoute;

@end

@interface RoutesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableViewRoutes;

#pragma mark Protocol Properties
@property (retain)id <RoutesViewDelegate> delegate;
@end
