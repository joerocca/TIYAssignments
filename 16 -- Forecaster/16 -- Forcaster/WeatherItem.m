//
//  WeatherItem.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "WeatherItem.h"





@implementation WeatherItem
{
    NSMutableData *receivedData;
}

//-(void)createAnInstanceOfForecastTableViewController
//{
//    ForecastTableViewController *ForecastTableView = [[ForecastTableViewController alloc] init];
//    ForecastTableView.delegate = self;
//    
//}








-(void)weatherForecast
{
 
    
    NSString *latitude = self.latitude; //unnessecary
    NSString *longitude = self.longitude;
    NSString *urlString = [NSString stringWithFormat:@"https://api.forecast.io/forecast/f3d7c26c780a5dad68ee1742b896b272/%@,%@",latitude,longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    
    //    NSLog(@"%@",urlString);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //starts in paused state; have to tell it to resume.
    
    [dataTask resume];
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
        NSDictionary *weatherInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        NSDictionary *currentWeather = [weatherInfo objectForKey:@"currently"];
        self.temperature = [currentWeather objectForKey:@"temperature"];
        self.apparentTemp = [currentWeather objectForKey:@"apparentTemperature"];
        self.forecastSummary = [currentWeather objectForKey:@"summary"];
        

        NSLog(@"Temp: %@",self.temperature);
        NSLog(@"Apparent Temp: %@", self.apparentTemp);
        NSLog(@"Summary: %@",self.forecastSummary);
        
        
//        NSLog(@"%@",weatherInfo);
//        [self.location addObject:locationInfo];
//        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    //    NSLog(@"%@",self.location);
}






@end
