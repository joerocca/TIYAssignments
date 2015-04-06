//
//  MapObject.h
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface MapObject : NSObject <MKAnnotation>


@property (nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D ) coordinate;

@end
