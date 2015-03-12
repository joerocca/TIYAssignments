//
//  EnergyItem.h
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    EnergyTypeNone,
    EnergyTypeVolts,
    EnergyTypeAmps,
    EnergyTypeWatts,
    EnergyTypeOhms
    
}EnergyTypes;





@interface EnergyItem : NSObject



@property (assign) EnergyTypes types;



+(NSArray *)allEnergyTypes;

@end
