//
//  ZipCodeViewController.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ZipCodeViewController.h"
#import "WeatherCell.h"
#import "City.h"
#import "NetworkManager.h"

@interface ZipCodeViewController () <NSURLSessionDataDelegate, UITextFieldDelegate>
{
    NSMutableData *receivedData;
   
}

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@property (weak, nonatomic) IBOutlet UILabel *zipCodeInvalidLabel;

- (IBAction)findCityButton:(UIButton *)sender;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end

@implementation ZipCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.prompt = @"Enter a zip code to find the current weather conditions";
    self.title = @"Add City";
    
    self.zipCodeTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)findCityButton:(UIButton *)sender
{
    
    [self.zipCodeTextField resignFirstResponder];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ([self.zipCodeTextField.text length] == 5 && [self.zipCodeTextField.text rangeOfCharacterFromSet:set].location != NSNotFound)
    {
        
        
        City *aCity = [[City alloc] initWithZipCode:self.zipCodeTextField.text];
        
        [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];
    }
    else
    {
        self.zipCodeInvalidLabel.text = @"Invalid Entry.";
    }
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] || [textField.text isEqualToString:@""])
    {

        
            [textField resignFirstResponder];
            rc = YES;
        
    
       
    }
    
    
    return rc;
}











@end
