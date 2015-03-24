//
//  CityDatabase.h
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/24/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDatabase : NSObject


+ (NSMutableArray *)loadCityDocs;
+ (NSString *)nextCityDocPath;

@end
