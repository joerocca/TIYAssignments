//
//  ViewController.m
//  Form Validator
//
//  Created by Joe Rocca on 3/9/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "FormValidator.h"

@interface ViewController () <UITextFieldDelegate>
{
    FormValidator *validator;
}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Form Validator";
//    validator = [[FormValidator alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (textField == self.nameTextField)
    {
        rc = [validator validateName:self.nameTextField.text];
        
        
    }
    
    if (textField == self.cityTextField)
    {
        rc = [validator validateCity:self.cityTextField.text];
    }
    
    if (textField == self.zipCodeTextField)
    {
        rc = [validator validateZipCode:self.zipCodeTextField.text];
    }
    
    if (textField == self.stateTextField)
    {
        rc = [validator validateState:self.zipCodeTextField.text];
    }
    
    if(textField == self.phoneNumberTextField)
    {
        rc = [validator validatePhoneNumber:self.phoneNumberTextField.text];
    }
    
    if (textField == self.addressTextField)
    {
        rc = [validator validateAddress:self.addressTextField.text];
    }
    
    
    if (rc)
    {
        [textField resignFirstResponder];
    }
    
    return rc;
}










@end
