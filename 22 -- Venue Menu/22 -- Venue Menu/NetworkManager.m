//
//  NetworkManager.m
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NetworkManager.h"




@interface NetworkManager () <NSURLSessionDataDelegate>
{
    NSURLSessionConfiguration *configuration;
    NSURLSession *session;
    NSMutableDictionary *citiesForActiveTasks;
    NSMutableDictionary *receivedDataRepos;
}



@end

@implementation NetworkManager

static NSString *clientID = @"KBHEX4LKMFTRUMLYXN4OZOPY2IHOL1KUVBR4OEZXUBSSMLZA";
static NSString *clientSecret = @"AOXFKQTCEMKYNK3LA4LEOIVG5SIAEBAYOMEN4JDZNCBPZZLA";





- (instancetype) init
{
    self = [super init];
    if (self)
    {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        citiesForActiveTasks = [[NSMutableDictionary alloc] init];
        receivedDataRepos = [[NSMutableDictionary alloc] init];
        
    }
    return self;
}


#pragma mark - NSURLSession delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSMutableData *receivedData = receivedDataRepos[[NSNumber numberWithInteger:dataTask.taskIdentifier]];
    [receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
//        
//        NSMutableData *receivedData = receivedDataRepos[[NSNumber numberWithInteger:task.taskIdentifier]]; //double brackets needed to set as index
//        NSDictionary *aDictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
//        City *aCity = citiesForActiveTasks[[NSNumber numberWithInteger:task.taskIdentifier]];
//        DataFetchType fetchType;
//        if ([aDictionary objectForKey:@"results"])
//        {
//            fetchType = DataFetchTypeCoordinates;
//        }
//        else
//        {
//            fetchType = DataFetchTypeWeather;
//        }
//        BOOL coordinatesSuccess = NO;
//        BOOL weatherSuccess = NO;
//        switch (fetchType)
//        {
//            case DataFetchTypeCoordinates:
//                coordinatesSuccess = [aCity parseCoordinateInfo:aDictionary];
//                break;
//            case DataFetchTypeWeather:
//                weatherSuccess = [aCity.currentWeather parseWeatherInfo:aDictionary];
//                break;
//                
//            default:
//                break;
//        }
//        
//        if (coordinatesSuccess)
//        {
//            [self.delegate cityWasFound:aCity];
//        }
//        if (weatherSuccess)
//        {
//            [self.delegate weatherWasFoundForCity:aCity];
//        }
    }
}






@end
