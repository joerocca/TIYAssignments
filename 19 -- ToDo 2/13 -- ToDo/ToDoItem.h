//
//  ToDoItem.h
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@import MapKit;

@interface ToDoItem : NSObject

- (instancetype)initWithResponse:(MKLocalSearchResponse *)localSearchInit;
- (instancetype)initWithDate:(NSDate*)date;
- (instancetype)init;

@property (strong, nonatomic) NSString *taskName;
@property (nonatomic) NSDate *dueDate;
@property (assign) BOOL done;
@property (strong,nonatomic) NSString *addressName;
@property (strong, nonatomic) NSString *streetName;

@property (strong,nonatomic) MKLocalSearchResponse *locationSearchMapItems;





@end
