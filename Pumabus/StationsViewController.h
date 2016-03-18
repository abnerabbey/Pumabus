//
//  StationsViewController.h
//  Pumabus
//
//  Created by Abner  Iván Castro Aguilar on 13/03/16.
//  Copyright © 2016 Abner  Iván Castro Aguilar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PumabusManager.h"

@protocol StationsViewDelegate <NSObject>


@end

@interface StationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property int numberOfRouteShown;

@property (retain)id <StationsViewDelegate> delegate;

@end
