//
//  ViewController.m
//  18 -- Dude, Where's My Car?
//
//  Created by Joe Rocca on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "Location.h"

@import CoreLocation;
@import MapKit;
@import AddressBook;


#define MAP_DISPLAY_SCALE 1.0 * 1609.344
#define kPinKey @"pin"

@interface ViewController () <CLLocationManagerDelegate,UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pinCurrentLocation;
@property (weak, nonatomic) IBOutlet UITextField *barTextField;


- (IBAction)pinCurrentLocationButton:(UIBarButtonItem *)sender;

- (IBAction)removeCurrentLocationPinButton:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.barTextField.delegate = self;
    
    
    
    if (!self.aLocation)
    {
        [self configureLocationManager];
    }
    else
    {
        [self configureMapView];
        [self configurePin];
    }
}

-(void)loadData
{
    NSData *Data = [[NSUserDefaults standardUserDefaults] objectForKey:kPinKey];
    if (Data)
    {
    self.aLocation = [NSKeyedUnarchiver unarchiveObjectWithData:Data];
    }
    else
    {
        self.aLocation = nil;
    }
    
   
}

- (void)saveData
{
    NSData *Data = [NSKeyedArchiver archivedDataWithRootObject:self.aLocation];
    [[NSUserDefaults standardUserDefaults] setObject:Data forKey:kPinKey];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.aLocation coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE); //setter
    [self.mapView setRegion:viewRegion]; //getter
//    [self.mapView addAnnotation:self.aLocation]; //has MKAnnotation protocol
    
}

-(void)configurePin
{
    [self.mapView addAnnotation:self.aLocation];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[Location class]])
    {
        static NSString * const identifier = @"CityAnnotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
}





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
        [self.pinCurrentLocation setEnabled:NO];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.pinCurrentLocation setEnabled:NO];
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
        [self.pinCurrentLocation setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self enableLocationManager:NO];
    
    CLLocation *location = [locations lastObject];

    [self.pinCurrentLocation setEnabled:YES];
    
    self.aLocation = [[Location alloc] initWithCoordinate:location.coordinate userPinDescription:self.barTextField.text];
    
    [self configureMapView];
    
    
//            NSLog(@"%f",location.coordinate.latitude);
//            NSLog(@"%f",location.coordinate.longitude);
   

}
 
- (IBAction)pinCurrentLocationButton:(UIBarButtonItem *)sender
{
    [self configurePin];
    self.aLocation.name = [NSString stringWithFormat:@"%@", self.barTextField.text];
    [self.barTextField resignFirstResponder];
    self.barTextField.text = @"";
    
}

- (IBAction)removeCurrentLocationPinButton:(UIBarButtonItem *)sender
{
    [self.mapView removeAnnotation:self.aLocation];
    self.aLocation = nil;
    
    
    [self configureLocationManager];
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] || [textField.text isEqualToString:@""])
    {
        self.aLocation.name = [NSString stringWithFormat:@"%@", self.barTextField.text];
        [textField resignFirstResponder];
        rc = YES;
        
    }
    
    return rc;
}















@end
