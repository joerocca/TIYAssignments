//
//  VoltageTableViewController.h
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VoltageTableViewControllerDelegate

-(void)energyTypeWasChosen:(NSString *)chosentype; //what the delgate recieves?

@end

@interface VoltageTableViewController : UITableViewController <VoltageTableViewControllerDelegate>








@end
