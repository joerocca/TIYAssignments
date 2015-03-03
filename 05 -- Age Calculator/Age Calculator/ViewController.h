//
//  ViewController.h
//  Age Calculator
//
//  Created by Joe Rocca on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDatePickerDelegate

-(void)birthDayWasChosen:(NSDate *)birthDate;


@end


@interface ViewController : UIViewController <ViewControllerDatePickerDelegate>

@end

