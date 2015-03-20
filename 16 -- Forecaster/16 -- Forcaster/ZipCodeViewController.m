//
//  ZipCodeViewController.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ZipCodeViewController.h"
#import "WeatherItem.h"
#import "WeatherCell.h"

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
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    if ([self.zipCodeTextField.text length] == 5 && [self.zipCodeTextField.text rangeOfCharacterFromSet:set].location != NSNotFound)
    {
    NSString *zipCode = self.zipCodeTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false",zipCode];
    NSURL *url = [NSURL URLWithString:urlString];
    
//    NSLog(@"%@",urlString);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //starts in paused state; have to tell it to resume.
    
    [dataTask resume];
        
        
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
//        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//        
//        if ([textField.text length] == 5 && [textField.text rangeOfCharacterFromSet:set].location != NSNotFound)
//        {
        
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
//        [self.location addObject:locationInfo];
       
        
        
        WeatherItem *weatherItem = [[WeatherItem alloc] init];
        
        
        
        NSArray *results = [locationInfo objectForKey:@"results"];
        NSDictionary *locationInfo2 = results[0];
        NSArray *address = [locationInfo2 objectForKey:@"address_components"];
        NSDictionary *cityName = address[1];
        NSDictionary *stateName = address[3];
        weatherItem.cityName = [cityName objectForKey:@"long_name"];
        weatherItem.stateName = [stateName objectForKey:@"short_name"];
        
       
        
        NSDictionary *geometry = [locationInfo2 objectForKey:@"geometry"];
        NSDictionary *latLong = [geometry objectForKey:@"location"];
        NSString *lat = [latLong objectForKey:@"lat"];
        NSString *longitude = [latLong objectForKey:@"lng"];
        weatherItem.latitude = lat;
        weatherItem.longitude = longitude;
        
        [self.location addObject:weatherItem];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        NSLog(@"%@",weatherItem.latitude);
        NSLog(@"%@",weatherItem.longitude);
        
        [weatherItem weatherForecast];
    }
//    NSLog(@"%@",self.location);
}










@end
