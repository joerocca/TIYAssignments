//
//  EnergyCalculations.h
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnergyCalculations : NSObject




@property (strong, nonatomic) NSMutableString *operand1String;
@property (strong, nonatomic) NSMutableString *operand2String;


@property (assign) float operand1;
@property (assign) float operand2;

- (float) energyCalculations;

- (NSString)

@end
