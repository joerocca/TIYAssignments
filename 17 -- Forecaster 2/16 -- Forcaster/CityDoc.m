//
//  CityDoc.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/24/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityDoc.h"
#import "CityDatabase.h"

#define kDataKey @"data"
#define kDataFile @"data.plist"

@implementation CityDoc


-(instancetype)initWithDocPath:(NSString *)docPath
{
    self = [super init];
    if(self)
    {
        _docPath = [docPath copy];
    }
    
    return self;
}

- (BOOL)createDataPath
{
    if (self.docPath)
    {
        if (!self.docPath)
        {
            self.docPath = [CityDatabase nextCityDocPath];
        }
    }
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:self.docPath withIntermediateDirectories:YES attributes:nil error:&error];
                    
    if(!success)
    {
        NSLog(@"Error creating data path: %@", [error localizedDescription]);
    }
    
    return success;
}

- (void)saveData
{
    if (!self.city)
    {
        [self createDataPath];
        
        NSString *dataPath = [self.docPath stringByAppendingPathComponent:kDataFile];
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:self.city forKey:kDataKey];
        [archiver finishEncoding];
        [data writeToFile:dataPath atomically:YES];
    }
}


@end
