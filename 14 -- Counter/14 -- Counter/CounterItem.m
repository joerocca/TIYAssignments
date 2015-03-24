//
//  CounterItem.m
//  14 -- Counter
//
//  Created by Joe Rocca on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CounterItem.h"

@implementation CounterItem





-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _counterValue = 0;
        
    }
    
    return self;
}

-(void) calcCountUp
{
    self.counterValue++;
}

-(void) calcCountDown
{
    if (_counterValue >= 1)
    {
        self.counterValue--;
    }
    
}

-(void) labelReset
{
    self.counterValue = 0;
}


@end
