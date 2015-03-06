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
    self.displayLabel.text = [NSString stringWithFormat:@"%.0f",addFunc];
    }
    else if (brain.operatorType == OperatorTypeSubtraction)
    {
        float subFunc = brain.operand1 - brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", subFunc];
    }
    else if (brain.operatorType == OperatorTypeMultiplication)
    {
        float multiplyFunc = brain.operand1 * brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", multiplyFunc];
    }
    else if (brain.operatorType == OperatorTypeDivision)
    {
        float DivideFunc = brain.operand1 / brain.operand2;
        self.displayLabel.text = [NSString stringWithFormat:@"%.0f", DivideFunc];
       
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

@end


