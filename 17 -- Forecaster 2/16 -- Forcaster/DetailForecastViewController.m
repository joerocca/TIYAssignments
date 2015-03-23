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


@interface DetailForecastViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *iconDescription;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTempLabel;

@end

@implementation DetailForecastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.cityLabel.text = self.aCity.name;
    
    self.iconDescription.text = self.aCity.currentWeather.summary;
    
    self.iconView.image = [UIImage imageNamed:self.aCity.currentWeather.icon];
    
    self.humidityLabel.text = [self.aCity.currentWeather humidityPercentage];
    
    self.apparentTempLabel.text = [self.aCity.currentWeather feelsLikeTemperature];
    
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

@end
