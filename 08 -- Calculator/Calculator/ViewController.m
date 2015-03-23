//
//  ViewController.m
//  Calculator
//
//  Created by Joe Rocca on 3/5/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
{
    CalculatorBrain *brain;   
}



@property (weak, nonatomic) IBOutlet UILabel *displayLabel;


-(IBAction)operandTapped:(UIButton *)sender;  //connection to number buttons

- (IBAction)additionTapped:(UIButton *)sender;
- (IBAction)subtractionTapped:(UIButton *)sender;
- (IBAction)multiplicationTapped:(UIButton *)sender;
- (IBAction)divisionTapped:(UIButton *)sender;
- (IBAction)equalTapped:(UIButton *)sender;
- (IBAction)allClearTapped:(UIButton *)sender;
- (IBAction)decimalPoint:(UIButton *)sender;
- (IBAction)percentButton:(UIButton *)sender;
- (IBAction)signChangerTapped:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *acButton;
@property (weak, nonatomic) IBOutlet UIButton *decimalOutlet;




 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayLabel.text = @"0";  //set initial label value to 0
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 2.png"]];
    

    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(IBAction) operandTapped:(UIButton *)sender
{
    if(!brain)
    {
        brain = [[CalculatorBrain alloc] init];
   
    }
    
    self.displayLabel.text = [brain addOperand:sender.titleLabel.text];
//    
//    if (brain.operatorType == OperatorTypeNone)
//    {
//        [brain.operand1String appendString:sender.titleLabel.text];
//        
//        self.displayLabel.text = brain.operand1String;
//        
//    }
//    else
//    {
//        [brain.operand2String appendString:sender.titleLabel.text];
//        self.displayLabel.text = brain.operand2String;
//    }
//    
    
     [[self acButton] setTitle:@"C" forState:UIControlStateNormal];
    
    
    
}


-(IBAction)additionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeAddition;
    
    
}
-(IBAction)subtractionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeSubtraction;
    
}
-(IBAction)multiplicationTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeMultiplication;
    
}
-(IBAction)divisionTapped:(UIButton *)sender
{
    brain.operatorType = OperatorTypeDivision;
}




-(IBAction)equalTapped:(UIButton *)sender //pointer
{
    
    
    
    
//    float returnValue = [brain useOperator];
    
    if ((brain.operatorType == OperatorTypeDivision) && (brain.operand2 == 0))
    {
        self.displayLabel.text = @"Error";
    }
    else
    {
        self.displayLabel.text = [NSString stringWithFormat:@"%g", brain.useOperator];
        
    }
    
    
//    
//    brain.operand1 = [brain.operand1String floatValue];
//    brain.operand2 = [brain.operand2String floatValue];
//    
//    if (brain.operatorType == OperatorTypeAddition)
//    {
//    float addFunc = brain.operand1 + brain.operand2;
//        
////        if (addFunc == (int)addFunc)
////            {
////             self.displayLabel.text = [NSString stringWithFormat:@"%.0f",addFunc];
////        }
////        else
////        {
//            self.displayLabel.text = [NSString stringWithFormat:@"%g",addFunc];
//        
//   
//    }
//    else if (brain.operatorType == OperatorTypeSubtraction)
//    {
//        float subFunc = brain.operand1 - brain.operand2;
////        if (subFunc == (int)subFunc)
////        {
////            self.displayLabel.text = [NSString stringWithFormat:@"%.0f", subFunc];
////        }
////        else
////        {
//            self.displayLabel.text = [NSString stringWithFormat:@"%g", subFunc];
//        
//    }
//    else if (brain.operatorType == OperatorTypeMultiplication)
//    {
//        float multiplyFunc = brain.operand1 * brain.operand2;
////        if (multiplyFunc == (int)multiplyFunc)
////        {
////            self.displayLabel.text = [NSString stringWithFormat:@"%.0f", multiplyFunc];
////        }
////        else
////        {
//            self.displayLabel.text = [NSString stringWithFormat:@"%g", multiplyFunc];
//        
//    }
//    else if (brain.operatorType == OperatorTypeDivision)
//    {
//        if(brain.operand2 == 0)
//        {
//            self.displayLabel.text = @"Error";
//        }
//        else
//        {
//        
//         float DivideFunc = brain.operand1 / brain.operand2;
//        
////         if (DivideFunc == (int)DivideFunc)
////        {
////            
////            self.displayLabel.text = [NSString stringWithFormat:@"%.0f", DivideFunc];
////        }
////        else
////        {
//            self.displayLabel.text = [NSString stringWithFormat:@"%g",DivideFunc];
//        }
//        
//    }
    

    
    
//    if (!brain.operand1String == OperatorTypeNone)
//    {
//     self.view.backgroundColor =[UIColor greenColor];
//        
//    }
    brain = nil;
    
    
    
//   {
//    
//       brain.operand2 = [self.displayLabel.text floatValue];
//       
//       
//       if (brain.operatorType == OperatorTypeAddition)
//       {
//           float add = brain.operand2 + brain.operand2;
//           
//           self.displayLabel.text = [NSString stringWithFormat:@"%g",add];
//       }
//   }

}

- (IBAction)allClearTapped:(UIButton *)sender
{
    self.displayLabel.text = @"0";
    brain = nil;
    
   [sender setTitle:@"AC" forState:UIControlStateNormal]; //. =


}

- (IBAction)decimalPoint:(UIButton *)sender
{
    if (!brain)
    {
        brain = [[CalculatorBrain alloc] init];
        
    }
    
    
    self.displayLabel.text = [brain addDecimalPoint];
    
    
    
//        if(![brain.operand1String containsString:@"."])
//        {
//        brain.operand1String = [@"0." mutableCopy];         //mutable copy makes the string mutable
//        self.displayLabel.text = brain.operand1String;
//        }                                                   //If brain is NOT already intiated initiate it. Set the operand1String to 0. with a mutableCopy and display that the operand1String on the displayLabel.
//    }
//    else if (brain.operatorType == OperatorTypeNone && brain.operand1String)
//    {                                                       //if operand2string is equal to nothing, set operand2string to .0 using                                                                                mutable copy and display that to the displayLabel.
//        if(![brain.operand1String containsString:@"."])
//        {
//        [brain.operand1String appendString:@"."];
//        self.displayLabel.text = brain.operand1String;
//        }
//    }
//    
//    else if ([brain.operand2String isEqualToString:@""])
//    {
//        if(![brain.operand2String containsString:@"."])
//        {
//        brain.operand2String = [@"0." mutableCopy];
//        self.displayLabel.text = brain.operand2String;
//        }
//    
//    }
//    
//    else if (brain.operatorType != OperatorTypeNone && brain.operand2String)
//    {
//        if(![brain.operand2String containsString:@"."])
//        {
//        [brain.operand2String appendString:@"."];
//        self.displayLabel.text = brain.operand2String;
//        }
//     
//    }
//        
////


}

- (IBAction)percentButton:(UIButton *)sender
{
    
    
    self.displayLabel.text = [NSString stringWithFormat:@"%.2f",[brain findPercent]];
    
//    brain.operand1 = [brain.operand1String floatValue];
//    brain.operand2 = [brain.operand2String floatValue];r
//    
//    if (brain.operatorType == OperatorTypeNone)
//    {
//    float percent = brain.operand1 * 0.01;
//    brain.operand1String = [NSMutableString stringWithFormat:@"%.2f", percent];
//    self.displayLabel.text = brain.operand1String;
//    }
//    
//        if (brain.operatorType != OperatorTypeNone)
//    {
//        float percent2 = brain.operand2 * 0.01;
//        brain.operand2String = [NSMutableString stringWithFormat:@"%.2f", percent2];
//        self.displayLabel.text = brain.operand2String;
//    }
//    

}

- (IBAction)signChangerTapped:(UIButton *)sender
{
    
     self.displayLabel.text = [NSString stringWithFormat:@"%g",[brain changePositiveNegative]];
    
    
//    brain.operand1 = [brain.operand1String floatValue];
//    brain.operand2 = [brain.operand2String floatValue];
//    
//    if (brain.operatorType == OperatorTypeNone)
//    {
//        float signChanger = brain.operand1 * -1;
//        brain.operand1String = [NSMutableString stringWithFormat:@"%g", signChanger];
//        self.displayLabel.text = brain.operand1String;
//    }
//    
//    if (brain.operatorType != OperatorTypeNone)
//    {
//        float signChanger2 = brain.operand2 * -1;
//        brain.operand2String = [NSMutableString stringWithFormat:@"%g", signChanger2];
//        self.displayLabel.text = brain.operand2String;
//    
//    }

}



@end


