//
//  DatePickerViewController.m
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DatePickerViewController.h"
#import "DetailToDoTableViewController.h"
#import "ToDoItem.h"

@interface DatePickerViewController ()

- (IBAction)cancelButton:(UIBarButtonItem *)sender;
- (IBAction)doneButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}






-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

    
    
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

- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButton:(UIBarButtonItem *)sender
{
    
    
    [self.delegate dueDateWasChosen:self.datePicker.date];
    

    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
