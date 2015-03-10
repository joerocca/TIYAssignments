//
//  CalculatorBrain.m
//  CalculatorBrain
//
//  Created by Joe Rocca on 3/10/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain


- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _operand1String = [[NSMutableString alloc] init];
        _operand2String = [[NSMutableString alloc] init];
        _operand1 = 0.0f;
        _operand2 = 0.0f;
        _operatorType = OperatorTypeNone;
        _userIsTypingANumber = NO;
        
    }
    
    return self;
}


//-(void)hello
//{
//self.operand1 = [self.operand1String floatValue];
//self.operand2 = [self.operand2String floatValue];
//}




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
            
        case OperatorTypePercent:
            
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            if (_operatorType)
            {
                returnValue = self.operand1 * 0.01;
            }
            else
            {
                returnValue = self.operand2 * 0.01;
            }
            break;
            
        case OperatorTypeSignChanger:
            
            self.operand1 = [self.operand1String floatValue];
            self.operand2 = [self.operand2String floatValue];
            if (_operatorType)
            {
                returnValue = self.operand1 * -1;
            }
            else
            {
                returnValue = self.operand2 * -1;
            }
            break;
        
        
        
            
        
        default:
            break;
    }
    
    
    return returnValue;
    
}








@end
