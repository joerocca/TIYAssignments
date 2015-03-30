//
//  LocationTableViewController.h
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailToDoTableViewController.h"
#import "ToDoCell.h"

@interface LocationTableViewController : UITableViewController

@property (nonatomic, strong) ToDoItem *aTask;

@property (nonatomic, strong) NSArray *locationsArray;

@end
