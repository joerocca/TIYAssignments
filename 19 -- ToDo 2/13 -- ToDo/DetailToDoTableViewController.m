//
//  DetailToDoTableViewController.m
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DetailToDoTableViewController.h"
#import "DatePickerViewController.h"
#import "LocationTableViewController.h"
#import "ToDoItem.h"
#import "ToDoTableViewController.h"

@interface DetailToDoTableViewController ()<UITextFieldDelegate, CLLocationManagerDelegate>
{
    NSDateFormatter *dateFormatter;
    CLLocationManager *locationManager;
    MKLocalSearch *localSearch;
    CLGeocoder *geocoder;
//    MKLocalSearchResponse *results;
    
 
    

}

@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *checkMarkButton;
@property (weak, nonatomic) IBOutlet UILabel *locationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *streetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (weak, nonatomic) IBOutlet UITextView *notesTextView;



- (IBAction)detailCheckMarkButton:(UIButton *)sender;
- (IBAction)deleteButton:(UIButton *)sender;


@end

@implementation DetailToDoTableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.taskTextField.text = self.aTask.taskName;
    self.checkMarkButton.selected = self.aTask.done;
    
    self.notesTextView.text = self.aTask.notes;
    
    
    dateFormatter =[[NSDateFormatter alloc] init];
    
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMddyyyyhm" options:0 locale:[NSLocale currentLocale]];
    
    [dateFormatter setDateFormat: dateFormat];
    
    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.enterLocationTextField.text = @"";
    
    self.locationNameLabel.text = self.aTask.addressName;
    self.streetNameLabel.text = self.aTask.streetName;
    
    if (self.aTask.cityName != nil && self.aTask.stateName != nil)
    {
    self.cityNameLabel.text = [NSString stringWithFormat:@"%@, %@" , self.aTask.cityName, self.aTask.stateName ];
    }
    else
    {
        self.cityNameLabel.text = @"";
    }
    self.zipCodeLabel.text = self.aTask.zipCode;
    
   
    
//    self.dueDateLabel.text = [dateFormatter stringFromDate:dueDateInstanceVar];
    // making up an IBOutlet called someLabel
    // making up a model method (description) that returns a string representing your model
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.aTask.notes = self.notesTextView.text;
    self.aTask.taskName = self.taskTextField.text;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dueDateWasChosen:(NSDate *)dueDate
{
    self.dueDateLabel.text = [dateFormatter stringFromDate:dueDate];
    self.aTask.dueDate = [dateFormatter stringFromDate:dueDate];
}







#pragma mark - Table view data source


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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowDatePickerSegue"])
    {

        UINavigationController *datePickerNavC = [segue destinationViewController];
        DatePickerViewController *datePickerVC = [datePickerNavC viewControllers][0];
        
        datePickerVC.delegate = self;
        
    }
   
}





- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] || [textField.text isEqualToString:@""])
    {
        
        
        if (textField == self.enterLocationTextField && ![textField.text isEqualToString:@""])
        {
            [self configureLocationManager];
        
            
        }
    
        
        [textField resignFirstResponder];
        rc = YES;
    
        
    }
    
    
    return rc;
}



- (void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!locationManager)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
        
    }
    else
    {

    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {

    }
    else
    {
        [self enableLocationManager:YES];
    }
}

- (void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable) {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation];
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self enableLocationManager:NO];
    
    CLLocation *location = [locations lastObject];
    
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(location.coordinate, 1500.00, 1500.00);
    
    [self performSearch:userLocation];
    
    
    //            NSLog(@"%f",location.coordinate.latitude);
    //            NSLog(@"%f",location.coordinate.longitude);
    
    
}



-(void)performSearch:(MKCoordinateRegion)aRegion
  {
      
      
      MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
      request.naturalLanguageQuery = self.enterLocationTextField.text;
      request.region = aRegion;
      
      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
      localSearch = [[MKLocalSearch alloc] initWithRequest:request];
      
      [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
          
          [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
          
          if (error != nil) {
              [[[UIAlertView alloc] initWithTitle:@"Map Error"
                                          message:[error localizedDescription]
                                         delegate:nil
                                cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
              return;
          }
          
          if ([response.mapItems count] == 0) {
              [[[UIAlertView alloc] initWithTitle:@"No Results"
                                          message:nil
                                         delegate:nil
                
                                cancelButtonTitle:@"OK"otherButtonTitles:nil] show];
              return;
          }
          
          

          
          self.results = response;
          

          
          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
          UINavigationController *navC = [storyboard instantiateViewControllerWithIdentifier:@"LocationNavController"];
          
          LocationTableViewController *locationVC = [navC viewControllers][0];
          
          
          [locationVC setModalPresentationStyle:UIModalPresentationFullScreen];
          
          locationVC.locationsArray = response.mapItems;
          locationVC.aTask = self.aTask;
        
                    
          [self presentViewController:navC animated:YES completion:nil];
          
          
          
      }];

      
  }







- (IBAction)detailCheckMarkButton:(UIButton *)sender
{
    
    
    
}

- (IBAction)deleteButton:(UIButton *)sender
{

    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure you want to delete this task?"
                                                                   message:@"You will not be able to retrieve this task once it has been deleted."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction *action) {
                                                          
                                                             
                                                        
                                                           [self.delegate delete];
                                                             
                                                              
                                                          }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {

                                                              
                                                          }];
    
    [alert addAction:noAction];
    [alert addAction:yesAction];
    alert.view.tintColor = [UIColor redColor];
    [self presentViewController:alert animated:YES completion:nil];
    

 
}
@end
