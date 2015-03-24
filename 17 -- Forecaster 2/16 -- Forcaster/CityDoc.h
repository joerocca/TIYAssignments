//
//  CityDoc.h
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/24/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"

@interface CityDoc : NSObject

@property (strong, nonatomic) City *city;
@property (strong, nonatomic) NSString *docPath;


- (instancetype)initWithDocPath:(NSString *)docPath;
- (void)saveData;
- (void)deleteDoc;





@end
