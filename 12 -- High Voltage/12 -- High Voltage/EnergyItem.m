//
//  EnergyItem.m
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "EnergyItem.h"

@implementation EnergyItem


+(NSMutableArray *)allEnergyTypes
{

        
    return [[NSMutableArray alloc] initWithObjects:@"Volts",@"Watts",@"Amps",@"Ohms", nil];

    
}




- (instancetype)init
{
    self = [super init];
    if(self)
    {

        _types = EnergyTypeNone;
        
        
        
        
        
       
        
    }

return self;

}


@end
