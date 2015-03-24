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
    self.humidity = [[currentWeather objectForKey:@"humidity"] doubleValue] * 100;
    self.dewPoint = [[currentWeather objectForKey:@"dewPoint"] doubleValue];
    self.precipProbability = [[currentWeather objectForKey:@"precipProbability"] doubleValue] * 100;
    self.windSpeed = [[currentWeather objectForKey:@"windSpeed"] doubleValue];
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

- (NSString *)dewPointTemperature
{
    return [NSString stringWithFormat:@"%.0f℉",self.dewPoint];
}

- (NSString *)humidityPercentage
{
    return [NSString stringWithFormat:@"%g%%",self.humidity];
}

- (NSString *)chanceOfRain
{
    return [NSString stringWithFormat:@"%.0f%%",self.precipProbability];
}

- (NSString *)windSpeedMPH
{
    return [NSString stringWithFormat:@"%.0f MPH",self.windSpeed];
}

@end