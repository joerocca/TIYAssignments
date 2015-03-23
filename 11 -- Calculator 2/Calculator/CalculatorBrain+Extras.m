//
//  CalculatorBrain+Extras.m
//  Calculator
//
//  Created by Joe Rocca on 3/11/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CalculatorBrain+Extras.h"

@implementation CalculatorBrain (Extras)


- (float) squaredCalculation
{
    
    float rc;
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
    
    if (self.operatorType == OperatorTypeNone)
    {
        float squared = self.operand1 * self.operand1;
        self.operand1String = [NSMutableString stringWithFormat:@"%g", squared];
        rc = squared;
    }
    else if (self.operatorType != OperatorTypeNone)
    {
        float squared = self.operand2 * self.operand2;
        self.operand2String = [NSMutableString stringWithFormat:@"%g", squared];
        rc = squared;
    }
    
    return rc;
    
}


- (float) squareRootCalculation
{
    
    float rc;
    
    self.operand1 = [self.operand1String floatValue];
    self.operand2 = [self.operand2String floatValue];
    
    if (self.operatorType == OperatorTypeNone)
    {
        float squareRootOf = sqrtf(self.operand1);
        self.operand1String = [NSMutableString stringWithFormat:@"%g", squareRootOf];
        rc = squareRootOf;
    }
    
    else if (self.operatorType != OperatorTypeNone)
    {
        float squareRootOf = sqrtf(self.operand2);
        self.operand2String = [NSMutableString stringWithFormat:@"%g", squareRootOf];
        rc = squareRootOf;
    }
    
    return rc;
}

@end
