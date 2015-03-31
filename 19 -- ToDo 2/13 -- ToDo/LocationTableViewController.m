//
//  LocationTableViewController.m
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "LocationTableViewController.h"
#import "DetailToDoTableViewController.h"

@import MapKit;

@interface LocationTableViewController ()

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@end



@implementation LocationTableViewController
{
    NSMutableArray *locationData;
    DetailToDoTableViewController *detailVC;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSLog(@"%@",self.locationsArray);
    
    

 
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return [self.locationsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationCell" forIndexPath:indexPath];
    

    MKMapItem *item = self.locationsArray[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@ | %@", item.placemark.addressDictionary[@"Street"],[NSString stringWithFormat:@"%@, %@",item.placemark.locality,item.placemark.administrativeArea],item.placemark.postalCode];
    
//    cell.textLabel.text = item.name;
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   MKMapItem *aAddress = self.locationsArray[indexPath.row];
    NSString *name = aAddress.name;
    NSString *street = aAddress.placemark.addressDictionary[@"Street"];
    NSString *city = aAddress.placemark.locality;
    NSString *state = aAddress.placemark.administrativeArea;
    NSString *zipCode = aAddress.placemark.postalCode;
    
    self.aTask.addressName = name;
    self.aTask.streetName = street;
    self.aTask.cityName = city;
    self.aTask.stateName = state;
    self.aTask.zipCode = zipCode;
    
    NSLog(@"%@",city);
    
    

    [self dismissViewControllerAnimated:YES completion:nil];
    
    
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



@end
