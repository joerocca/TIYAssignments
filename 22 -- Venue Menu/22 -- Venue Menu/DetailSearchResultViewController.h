//
//  DetailSearchResultViewController.h
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapObject.h"
#import "Venue.h"
#import "CoreDataStack.h"



@interface DetailSearchResultViewController : UIViewController

@property (strong, nonatomic) CoreDataStack *cdStack;

@property (nonatomic, strong) MapObject *aMap;

@property (strong, nonatomic) NSDictionary *venueInfo;

@property (strong, nonatomic) Venue *venueObject;

@end
