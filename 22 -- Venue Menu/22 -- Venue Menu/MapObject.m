//
//  MapObject.m
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "MapObject.h"

@implementation MapObject




- (instancetype)initWithCoordinate:(CLLocationCoordinate2D )coordinate
{
    if (self) {
        self = [super init];
        
        _coordinate = coordinate;
        
        
    }
    return self;
}








@end
