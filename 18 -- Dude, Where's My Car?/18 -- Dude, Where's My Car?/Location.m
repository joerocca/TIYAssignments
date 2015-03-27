//
//  Location.m
//  18 -- Dude, Where's My Car?
//
//  Created by Joe Rocca on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"



@interface Location ()

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end



@implementation Location



- (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate userPinDescription:(NSString *)name
{
    if (self) {
        self = [super init];
        
        _coordinate = coordinate;
        _name = name;
    
    }
    return self;
}




- (NSString *)title
{
    return self.name;
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



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeDouble:self.coordinate.latitude forKey:kLatitudeKey];
    [aCoder encodeDouble:self.coordinate.longitude forKey:kLongitudekey];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString *name = [aDecoder decodeObjectForKey:kNameKey];
    double latitude = [aDecoder decodeDoubleForKey:kLatitudeKey];
    double longitude = [aDecoder decodeDoubleForKey:kLongitudekey];
 
    return [self initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) userPinDescription:name];
    
}





@end
