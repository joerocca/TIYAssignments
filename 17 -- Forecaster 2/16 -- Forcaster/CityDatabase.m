//
//  CityDatabase.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/24/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityDatabase.h"
#import "CityDoc.h"

@implementation CityDatabase

+ (NSString *)getPrivateDocsDir
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:@"Private Documents"];
    
    NSError *error;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:&error]; //&error gives the actual address if the object
    
    if(error)
    {
        NSLog(@"Error creating directory: %@", [error localizedDescription]);
        
    }
    
    return documentsDirectory;
                                    
}

+ (NSMutableArray *)loadCityDocs
{
    NSString *documentsDirectory = [CityDatabase getPrivateDocsDir];
    
    NSError *error;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:&error];
    if (error)
    {
        NSLog(@"Error reading contents of documents directory: %@", [error localizedDescription]);
        return nil;
    }
    
    NSMutableArray *docs = [NSMutableArray arrayWithCapacity:files.count];
    for (NSString *file in files)
    {
        if ([file.pathExtension compare:@"city"] == NSOrderedSame)
        {
            NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:file];
            CityDoc *doc = [[CityDoc alloc] initWithDocPath:fullPath];
            [docs addObject:doc];
            
        }
    }
    
    return docs;
}

+ (NSString *)nextCityDocPath
{
    
}


@end
