//
//  DatePickerViewController.m
//  Age Calculator
//
//  Created by Joe Rocca on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Rectangle 1.png"]];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
[super viewWillDisappear:animated];

[self.delegate birthDayWasChosen:self.datePicker.date];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
