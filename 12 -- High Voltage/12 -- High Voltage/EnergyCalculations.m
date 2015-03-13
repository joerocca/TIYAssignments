//
//  EnergyCalculations.m
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "EnergyCalculations.h"
#import "EnergyItem.h"

@implementation EnergyCalculations
{
    EnergyItem *energyItem;
}

-(instancetype)init
{
    self = [super init];                //overiding init of super class (NSObject)
    if (self)
    {
        
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];       //_ is form for instance variables when overriding init
        _operand1 = 0.0f;
        _operand2 = 0.0f;
        energyItem.types = EnergyTypeNone;
       
    }
    
    return self;
}







//- (float) energyCalculations
//{
//    float returnValue;
//    switch (energyItem.types)
//    {
//        case EnergyTypeVolts & EnergyTypeAmps:
//            self.operand1 = [self.operand1String floatValue];
//            self.operand2 = [self.operand2String floatValue];
//            returnValue =
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//  return
//    
//}





@end
