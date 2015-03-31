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


- (instancetype)init;

@property (strong, nonatomic) NSString *taskName;
@property (nonatomic) NSString *dueDate;
@property (strong,nonatomic) NSString *addressName;
@property (strong, nonatomic) NSString *streetName;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *stateName;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *notes;
@property (assign) BOOL done;








@end
