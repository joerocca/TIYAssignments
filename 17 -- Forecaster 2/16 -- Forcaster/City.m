//
//  City.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"


@interface City ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end


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

- (instancetype)initWithName:(NSString *)name latitude:(double)lat longitude:(double)lng andZipCode:(NSString *)zip;
{
    if (self)
    {
        self = [super init];
        
        _name = name;
        _latitude = lat;
        _longitude = lng;
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
        
        self.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude);
        
    }
    return rc;
}

- (NSString *)title
{
    return self.name;
}

- (NSString *)subtitle
{
    return [self.currentWeather currentTemperature];
}

- (CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

- (MKMapItem *)mapItem
{
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.name;
    
    return mapItem;
}

#pragma mark -- NSCoding

#define kNameKey @"name"
#define kLatitudeKey @"latitude"
#define kLongitudekey @"longitude"
#define kZipCodeKey @"zipCode"


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeDouble:self.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.longitude forKey:kLongitudekey];
    [aCoder encodeObject:self.zipCode forKey:kZipCodeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *cityName = [aDecoder decodeObjectForKey:kNameKey];
    double latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:kLongitudekey];
    NSString *zipCode = [aDecoder decodeObjectForKey:kZipCodeKey];
    
    return [self initWithName:cityName latitude:latitude longitude:longitude andZipCode:zipCode];
    

}




@end