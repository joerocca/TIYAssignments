//
//  ToDoTableViewController.h
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToDoTableViewControllerDelegate

-(void) delete;

@end




@interface ToDoTableViewController : UITableViewController <ToDoTableViewControllerDelegate>

@end
