//
//  ToDoItem.h
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject


- (instancetype)initWithDate:(NSDate*)date;
- (instancetype)init;

@property (strong, nonatomic) NSString *taskName;
@property (nonatomic) NSDate *dueDate;
@property (assign) BOOL done;






@end
