//
//  Location.h
//  18 -- Dude, Where's My Car?
//
//  Created by Joe Rocca on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;



@interface Location : NSObject <MKAnnotation, NSCoding>




@property (strong, nonatomic) NSString *name;


- (CLLocationCoordinate2D)coordinate;


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D ) coordinate userPinDescription:(NSString *)name;





@end
