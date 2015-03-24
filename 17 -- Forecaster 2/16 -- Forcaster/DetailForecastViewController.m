//
//  DetailForecastViewController.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DetailForecastViewController.h"
#import "ZipCodeViewController.h"
#import "ForecastTableViewController.h"
#import "WeatherCell.h"
@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@interface DetailForecastViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTemp;
@property (weak, nonatomic) IBOutlet UILabel *iconDescription;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *rainChanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailTemp.text = [self.aCity.currentWeather currentTemperature];
    
    self.cityLabel.text =[NSString stringWithFormat:@"%@, %@",self.aCity.name,self.aCity.state];
    
    self.iconDescription.text = self.aCity.currentWeather.summary;
    
    self.iconView.image = [UIImage imageNamed:self.aCity.currentWeather.icon];
    
    self.humidityLabel.text = [self.aCity.currentWeather humidityPercentage];
    
    self.apparentTempLabel.text = [self.aCity.currentWeather feelsLikeTemperature];
    
    self.rainChanceLabel.text = [self.aCity.currentWeather chanceOfRain];
    
    self.windSpeedLabel.text = [self.aCity.currentWeather windSpeedMPH];
    
    [self configureMapView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.aCity coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE); //setter
    [self.mapView setRegion:viewRegion]; //getter
    [self.mapView addAnnotation:self.aCity]; //has MKAnnotation protocol
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[City class]])
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
