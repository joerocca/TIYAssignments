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

@import CoreLocation;
@import MapKit;
@import AddressBook;

@interface ZipCodeViewController () <UITextFieldDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;

   
}

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@property (weak, nonatomic) IBOutlet UILabel *zipCodeInvalidLabel;

@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

- (IBAction)findCityButton:(UIButton *)sender;

- (IBAction)findCityWithCurrentLocation:(UIButton *)sender;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end

@implementation ZipCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.prompt = @"Enter a zip code to find the current weather conditions";
    self.title = @"Add City";
    
    self.zipCodeTextField.delegate = self;
 
    geocoder = [[CLGeocoder alloc] init];
    
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

#pragma mark -- Location Services

- (void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!locationManager)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
        
    }
    else
    {
        [self.currentLocationButton setEnabled:NO];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.currentLocationButton setEnabled:NO];
    }
    else
    {
        [self enableLocationManager:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable) {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation];
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
        [self.currentLocationButton setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ((placemarks != nil) && (placemarks.count > 0))
        {
            [self enableLocationManager:NO];
            NSString *cityName = [placemarks[0] locality];
            NSString *state = [[placemarks[0] addressDictionary] objectForKey:(NSString *)kABPersonAddressStateKey];
            NSString *zipCode = [[placemarks[0] addressDictionary] objectForKey:(NSString *)kABPersonAddressZIPKey];
            double lat = location.coordinate.latitude;
            double lng = location.coordinate.longitude;
            City *aCity = [[City alloc] initWithName:cityName state:state latitude:lat longitude:lng andZipCode:zipCode];
            [[NetworkManager sharedNetworkManager] cityFoundUsingCurrentLocation:aCity];
        }
    }];
}

#pragma mark -- Action Handlers

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


- (IBAction)findCityWithCurrentLocation:(UIButton *)sender
{
    [self configureLocationManager];
    
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
