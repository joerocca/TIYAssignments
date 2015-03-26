//
//  ViewController.h
//  18 -- Dude, Where's My Car?
//
//  Created by Joe Rocca on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"



@interface ViewController : UIViewController



@property (nonatomic, strong) Location *aLocation;



- (void)saveData;




@end

