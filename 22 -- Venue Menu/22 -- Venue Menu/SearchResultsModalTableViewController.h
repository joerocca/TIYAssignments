//
//  SearchResultsModalTableViewController.h
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapObject.h"
#import "CoreDataStack.h"

@interface SearchResultsModalTableViewController : UITableViewController


@property (strong, nonatomic) CoreDataStack *cdStack;

@property (strong, nonatomic) NSMutableArray *venues;

@end
