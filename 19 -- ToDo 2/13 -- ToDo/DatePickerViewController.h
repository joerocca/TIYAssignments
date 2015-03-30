//
//  DatePickerViewController.h
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailToDoTableViewController.h"
#import "ToDoItem.h"

@interface DatePickerViewController : UIViewController


@property (nonatomic, strong) ToDoItem *aTask;

@property (strong, nonatomic) id <DetailToDoViewControllerDelegate> delegate;

@end
