//
//  WeatherCell.h
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *degreesCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityCellLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentConditionsLabel;

@end
