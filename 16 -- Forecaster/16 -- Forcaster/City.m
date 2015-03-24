//
//  City.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@implementation City

- (instancetype)initWithZipCode:(NSString *)zip;
{
    if (self)
    {
        self = [super init];
        
        _zipCode = zip;
        
    }
    
    return self;
}


- (BOOL)parseCoordinateInfo:(NSDictionary *)mapsDictionary
{
    BOOL rc = NO;
    
    if (mapsDictionary)
    {
        rc = YES;
    NSArray *results = [mapsDictionary objectForKey:@"results"];
    NSDictionary *locationInfo2 = results[0];
    NSArray *address = [locationInfo2 objectForKey:@"address_components"];
    NSDictionary *cityName = address[1];
    NSDictionary *stateName = address[3];
        self.name = [cityName objectForKey:@"long_name"];
        self.state = [stateName objectForKey:@"short_name"];
    
    
    
    NSDictionary *geometry = [locationInfo2 objectForKey:@"geometry"];
    NSDictionary *latLong = [geometry objectForKey:@"location"];
    NSString *lat = [latLong objectForKey:@"lat"];
    NSString *longitude = [latLong objectForKey:@"lng"];
    self.latitude = [lat doubleValue];
    self.longitude = [longitude doubleValue];
        
        
    }
    return rc;
}



@end