//
//  CalculatorBrain.m
//  CalculatorBrain
//
//  Created by Joe Rocca on 3/10/15.
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





- (NSString *) addOperand:(NSString *)operand
{
    NSString *rc;
    if (self.operatorType == OperatorTypeNone)
    {
        [self.operand1String appendString:operand];
        rc = self.operand1String;
    }
    else
    {
        [self.operand2String appendString:operand];
        rc = self.operand2String;
    }
    
    return rc;
}




- (NSString *) addDecimalPoint
{
    
    NSString *rc;
    
    if ([self.operand1String isEqualToString:@""])
    {
        self.operand1String = [@"0." mutableCopy];
        rc = self.operand1String;
    }
    
    else if (self.operatorType == OperatorTypeNone)
    {
        if (![self.operand1String containsString:@"."])
        {
            [self.operand1String appendString:@"."];
        }
        
        
        
        rc = self.operand1String;
        
    }
    
    
    else if ([self.operand2String isEqualToString:@""])
    {
        self.operand2String = [@"0." mutableCopy];
        rc = self.operand2String;
        
    }
    else if (!self.operatorType == OperatorTypeNone)
    {
        if (![self.operand2String containsString:@"."])
        {
            [self.operand2String appendString:@"."];
        }
        
        rc = self.operand2String;
        
    }
    
  
    return rc;
}






- (float) useOperator
{
    
    
    
    float returnValue;
    switch (self.operatorType)
    {
        case OperatorTypeAddition:
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 + self.operand2;
            break;
            
        case OperatorTypeSubtraction:
            
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 - self.operand2;
            break;
            
        case OperatorTypeMultiplication:
            
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 * self.operand2;
            break;
            
        case OperatorTypeDivision:
            
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            returnValue = self.operand1 / self.operand2;
            break;
            
            
        default:
            break;
    }
    
    
    return returnValue;
    
}



- (float) findPercent;
{
    float rc;
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
    
    if (self.operatorType == OperatorTypeNone)
    {
        float percentCalculation = self.operand1 * .01;
        self.operand1String = [NSMutableString stringWithFormat:@"%g", percentCalculation];
        rc = percentCalculation;
    }
    
    else if (self.operatorType != OperatorTypeNone)
    {
        float percentCalculation = self.operand2 * .01;
        self.operand2String = [NSMutableString stringWithFormat:@"%g", percentCalculation];
        rc = percentCalculation;
        
    }
    
    return rc;
}



- (float) changePositiveNegative
{
    float rc;
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
    
    if (self.operatorType == OperatorTypeNone)
    {
        float positiveNegative = self.operand1 * -1;
        self.operand1String = [NSMutableString stringWithFormat:@"%g",positiveNegative];
        rc = positiveNegative;
    }
    
    else if (self.operatorType != OperatorTypeNone)
    {
        float positiveNegative = self.operand2 * -1;
        self.operand2String = [NSMutableString stringWithFormat:@"%g",positiveNegative];
        rc = positiveNegative;
    }
    
    return rc;
}





@end
