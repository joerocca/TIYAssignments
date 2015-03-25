//
//  ForecastTableViewController.h
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"


@protocol ForecastTableViewControllerDelegate

- (void)cityWasFound:(City *)aCity;

- (void)weatherWasFoundForCity:(City *)aCity;


@end




@interface ForecastTableViewController : UITableViewController<ForecastTableViewControllerDelegate>

- (void)saveCityData;

@end
