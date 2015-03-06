//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Joe Rocca on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain


-(instancetype)init
{
    self = [super init];                //overiding init of super class (NSObject)
    if (self)
    {
        
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];       //_ is form for instance variables when overriding init 
        _operand1 = 0.0f;
        _operand2 = 0.0f;
        _operatorType = OperatorTypeNone;
        _userIsTypingANumber = NO;
    }
    
    return self;
}

@end
