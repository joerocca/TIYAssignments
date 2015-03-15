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
    PopoverTableViewController *popover;
    EnergyItem *energyItem;
    NSMutableArray *energyIdentifierTypes;
    NSMutableArray *energyTypes2;
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
    energyIdentifierTypes = [[NSMutableArray alloc] init];
    
    energyTypes2 = [[NSMutableArray alloc] initWithObjects:@"Volts",@"Watts",@"Amps",@"Ohms", nil];

    
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
    return [energyIdentifierTypes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[energyIdentifierTypes objectAtIndex:indexPath.row] forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


 
 
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
        NSMutableArray *energyTypes = [EnergyItem allEnergyTypes];
        
        float contentHeight = 44.0f * [energyTypes count];
        
        destVC.preferredContentSize = CGSizeMake(100.0f, contentHeight);
        
        popover.energyTypes3 = energyTypes2;
        
        NSLog(@"%@",popover.energyTypes3);
        
        destVC.delegate = self;
        
    }
    
    
    
}




-(void)energyTypeWasChosen:(NSString *)chosentype 
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSDictionary *energyDictionary = @{@"Volts":@"VoltsCell" ,@"Watts":@"WattsCell" ,@"Amps": @"AmpsCell",@"Ohms":@"OhmsCell" };
    
    NSString *anIdentifier = [energyDictionary objectForKey:chosentype];

    [energyIdentifierTypes addObject:anIdentifier];
    NSUInteger index = [energyIdentifierTypes indexOfObject:anIdentifier];
//    NSUInteger index2 = [EnergyItem.allEnergyTypes indexOfObject:chosentype];
    NSUInteger index3 = [[EnergyItem allEnergyTypes] indexOfObject:chosentype];
    
//    NSLog(@"%ld", (long)index2);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationLeft];

    
//    [[EnergyItem allEnergyTypes] removeObjectAtIndex:index2];
    
    [[EnergyItem allEnergyTypes] removeObjectAtIndex:index3];

    
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
