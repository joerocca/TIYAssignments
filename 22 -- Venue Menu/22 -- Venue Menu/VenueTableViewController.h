//
//  VenueTableViewController.h
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VenueTableViewController.h"



@protocol VenueTableViewControllerDelegate

-(void)unfavorite;

@end


@interface VenueTableViewController : UITableViewController <VenueTableViewControllerDelegate>





@end
