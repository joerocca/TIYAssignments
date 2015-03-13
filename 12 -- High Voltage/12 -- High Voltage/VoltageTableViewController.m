//
//  VoltageTableViewController.m
//  12 -- High Voltage
//
//  Created by Joe Rocca on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "VoltageTableViewController.h"
#import "PopoverTableViewController.h"
#import "EnergyItem.h"

@interface VoltageTableViewController () <UITextFieldDelegate, UIPopoverPresentationControllerDelegate>
{
    EnergyItem *energyItem;
}

- (IBAction)voltsTextField:(UITextField *)sender;
- (IBAction)ampsTextField:(UITextField *)sender;
- (IBAction)ohmsTextField:(UITextField *)sender;
- (IBAction)wattsTextField:(UITextField *)sender;




@end

@implementation VoltageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"High Voltage";
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return 4;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

 
 
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPopoverSegue"])
    {
        PopoverTableViewController *destVC = (PopoverTableViewController *)[segue destinationViewController];
        
        destVC.popoverPresentationController.delegate = self;
        NSArray *energyTypes = [EnergyItem allEnergyTypes];
        
        float contentHeight = 44.0f * [energyTypes count];
        
        destVC.preferredContentSize = CGSizeMake(100.0f, contentHeight);
        
    }
    
    
    
}

#pragma mark - PopoverPresentationController delegate


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    
    return UIModalPresentationNone;
}





#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] || [textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        
        

        rc = YES;
    }
    
    
    return rc;
}












#pragma mark -- Action Handlers






- (IBAction)voltsTextField:(UITextField *)sender
{
    energyItem.types = EnergyTypeVolts;
}

- (IBAction)ampsTextField:(UITextField *)sender
{
    energyItem.types = EnergyTypeAmps;
}

- (IBAction)ohmsTextField:(UITextField *)sender
{
    energyItem.types = EnergyTypeOhms;
}

- (IBAction)wattsTextField:(UITextField *)sender
{
    energyItem.types = EnergyTypeWatts;
}



@end
