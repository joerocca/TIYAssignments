//
//  WeatherItem.h
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ForecastTableViewController.h"

@interface WeatherItem : NSObject <NSURLSessionDataDelegate>



@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *stateName;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;


@property (strong, nonatomic) NSString *temperature;
@property (strong, nonatomic) NSString *forecastSummary;
@property (strong, nonatomic) NSString *apparentTemp;


-(void)weatherForecast;





@end
