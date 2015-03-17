//
//  CounterItem.h
//  14 -- Counter
//
//  Created by Joe Rocca on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CounterItem : NSObject

@property (assign) NSInteger counterValue;

@property (strong, nonatomic) NSString *counterName;


-(void) calcCountUp;
-(void) calcCountDown;


@end
