//
//  PopoverTableViewController.h
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoltageTableViewController.h"

@interface PopoverTableViewController : UITableViewController



@property (strong, nonatomic) id <VoltageTableViewControllerDelegate> delegate;


@property (strong, nonatomic) NSMutableArray *energyTypes3;


@end
