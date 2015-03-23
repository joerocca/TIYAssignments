//
//  Weather.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/23/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@implementation Weather

- (BOOL)parseWeatherInfo:(NSDictionary *)infoDictionary
{
    BOOL rc = NO;
    if (infoDictionary)
    {
        rc = YES;
    NSDictionary *currentWeather = [infoDictionary objectForKey:@"currently"];
        
    self.temperature = [[currentWeather objectForKey:@"temperature"]doubleValue];
    self.apparentTemperature = [[currentWeather objectForKey:@"apparentTemperature"]doubleValue];
    self.summary = [currentWeather objectForKey:@"summary"];
    self.icon = [currentWeather objectForKey:@"icon"];
    }
    return rc;
}




- (NSString *)currentTemperature
{
    return [NSString stringWithFormat:@"%.0f℉", self.temperature];
}
- (NSString *)feelsLikeTemperature
{
    return [NSString stringWithFormat:@"%.0f℉", self.apparentTemperature];
}
//- (NSString *)dewPointTemperature
//{
//    
//}
//- (NSString *)humidityPercentage
//{
//    
//}
//- (NSString *)chanceOfRain
//{
//    
//}
//- (NSString *)windSpeedMPH
//{
//    
//}

@end