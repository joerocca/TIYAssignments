//
//  CounterCell.h
//  14 -- Counter
//
//  Created by Joe Rocca on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *counterLabel;


@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;


@property (weak, nonatomic) IBOutlet UIButton *cellMinusButton;


@property (weak, nonatomic) IBOutlet UIButton *cellPlusButton;





@end
