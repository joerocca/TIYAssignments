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
    CalculatorBrain *brain;   //
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


@property (weak, nonatomic) IBOutlet UIButton *acButton;

//-(void)someMethod;
 
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayLabel.text = @"0";  //set initial label value to 0
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 2.png"]];
    
//    
//    [NSTimer scheduledTimerWithTimeInterval:0.3f target:self selector:@selector(someMethod) userInfo:nil repeats:YES];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)someMethod
    {
       
    }




-(IBAction) operandTapped:(UIButton *)sender
{
    if(!brain)
    {
        brain = [[CalculatorBrain alloc] init];
   
    }
    
    
    if (brain.operatorType == OperatorTypeNone)
    {
        [brain.operand1String appendString:sender.titleLabel.text];
        
        self.displayLabel.text = brain.operand1String;
        
    }
    else
    {
        [brain.operand2String appendString:sender.titleLabel.text];
        self.displayLabel.text = brain.operand2String;
    }
    
    
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
-(IBAction)equalTapped:(UIButton *)sender
{
    brain.operand1 = [brain.operand1String floatValue];
    brain.operand2 = [brain.operand2String floatValue];
    
    if (brain.operatorType == OperatorTypeAddition)
    {
    float addFunc = brain.operand1 + brain.operand2;
    self.displayLabel.text = [NSString stringWithFormat:@"%f",addFunc];
    }
    else if (brain.operatorType == OperatorTypeSubtraction)
    {
        float subFunc = brain.operand1 - brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%f", subFunc];
    }
    else if (brain.operatorType == OperatorTypeMultiplication)
    {
        float multiplyFunc = brain.operand1 * brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%f", multiplyFunc];
    }
    else if (brain.operatorType == OperatorTypeDivision)
    {
        if(brain.operand2 == 0)
        {
            self.displayLabel.text = @"Error";
        }
        else
        {
        float DivideFunc = brain.operand1 / brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%f", DivideFunc];
        }
    }
    
//    if (!brain.operand1String == OperatorTypeNone)
//    {
//     self.view.backgroundColor =[UIColor greenColor];
//        
//    }
    
    
   

}

- (IBAction)allClearTapped:(UIButton *)sender
{
    self.displayLabel.text = @"0";
    brain = nil;
    
   [(UIButton*)sender setTitle:@"AC" forState:UIControlStateNormal]; //why (UIButton*)sender ?


}

- (IBAction)decimalPoint:(UIButton *)sender
{
    if (!brain) {
        brain = [[CalculatorBrain alloc] init];
        brain.operand1String = [@"0." mutableCopy];         //mutable copy makes the string mutable
        self.displayLabel.text = brain.operand1String;          //If brain is NOT already intiated initiate it. Set the operand1String to 0. with a mutableCopy and display that the operand1String on the displayLabel.
    }
    else if (brain.operatorType == OperatorTypeNone && brain.operand1String)
    {                                                       //if operand2string is equal to nothing, set operand2string to .0 using                    mutable copy and display that to the displayLabel.
        [brain.operand1String appendString:@"."];
        self.displayLabel.text = brain.operand1String;
    }
    
    else if ([brain.operand2String isEqualToString:@""])
    {
        brain.operand2String = [@"0." mutableCopy];
        self.displayLabel.text = brain.operand2String;
    
    }
    else if (brain.operatorType != OperatorTypeNone && brain.operand2String)
    {
        [brain.operand2String appendString:@"."];
        self.displayLabel.text = brain.operand2String;
     
    }
        
        


}

- (IBAction)percentButton:(UIButton *)sender {
    
    brain.operand1 = [brain.operand1String floatValue];
    brain.operand2 = [brain.operand2String floatValue];
    
    if (brain.operatorType == OperatorTypeNone)
    {
    float percent = brain.operand1 * 0.01;
    brain.operand1String = [NSMutableString stringWithFormat:@"%.2f", percent];
    self.displayLabel.text = brain.operand1String;
    }
    
        if (brain.operatorType != OperatorTypeNone)
    {
        float percent2 = brain.operand2 * 0.01;
        brain.operand2String = [NSMutableString stringWithFormat:@"%.2f", percent2];
        self.displayLabel.text = brain.operand2String;
    }
    

}

@end


