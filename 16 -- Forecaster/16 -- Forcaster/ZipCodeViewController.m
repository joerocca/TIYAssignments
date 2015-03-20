//
//  ZipCodeViewController.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ZipCodeViewController.h"

@interface ZipCodeViewController () <NSURLSessionDataDelegate, UITextFieldDelegate>
{
    NSMutableData *receivedData;
   
}

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

- (IBAction)findCityButton:(UIButton *)sender;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end

@implementation ZipCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.prompt = @"Enter a zip code to find the current weather conditions";
    self.title = @"Zip Code";
    
    self.zipCodeTextField.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *zipCode = self.zipCodeTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false",zipCode];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"%@",urlString);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //starts in paused state; have to tell it to resume.
    
    [dataTask resume];
    
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





#pragma mark -- NSURLSession delegate



- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if(!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    
    else
    {
        [receivedData appendData:data];
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error //if didnt complete, this will point to error
{
    if (!error)
    {
        NSLog(@"Download Successful.");
        NSDictionary *locationInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        [self.location addObject:locationInfo];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    NSLog(@"%@",self.location);
}










@end
