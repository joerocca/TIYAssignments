//
//  DetailToDoTableViewController.h
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoItem.h"
#import "LocationTableViewController.h"

@import MapKit;



@protocol DetailToDoViewControllerDelegate

-(void)dueDateWasChosen:(NSDate *)dueDate;

@end




@interface DetailToDoTableViewController : UITableViewController <DetailToDoViewControllerDelegate>


@property (nonatomic, strong) ToDoItem *aTask;

@property (weak, nonatomic) IBOutlet UITextField *enterLocationTextField;

@property (weak,nonatomic) MKLocalSearchResponse *results;



-(void)performSearch:(MKCoordinateRegion)aRegion;







@end
