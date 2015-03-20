//
//  ForecastTableViewController.m
//  16 -- Forecaster
//
//  Created by Joe Rocca on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ForecastTableViewController.h"
#import "ZipCodeViewController.h"
#import "WeatherCell.h"
#import "WeatherItem.h"

@interface ForecastTableViewController ()
{
    NSMutableArray *location;
}

@property (weak, nonatomic) IBOutlet UILabel *degreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentConditionsLabel;


@end

@implementation ForecastTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Current Weather";
    
    location = [[NSMutableArray alloc] init];
//    self.view.backgroundColor = [UIColor purpleColor];
    
  
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
    return [location count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell" forIndexPath:indexPath];
    
    
//    WeatherItem *weatherItem = [[WeatherItem alloc] init];
    
    WeatherItem *weatherItem = location[indexPath.row];
//    NSArray *results = [locationInfo objectForKey:@"results"];
//    NSDictionary *locationInfo2 = results[0];
//    NSArray *address = [locationInfo2 objectForKey:@"address_components"];
//    NSDictionary *cityName = address[1];
//    NSDictionary *stateName = address[3];
//    NSString *longName = [cityName objectForKey:@"long_name"];
//    NSString *shortName = [stateName objectForKey:@"short_name"];
//    NSString *cityName = weatherItem.cityName;
//    NSString *stateName = weatherItem.stateName;
    
    cell.cityCellLabel.text =[NSString stringWithFormat:@"%@, %@",weatherItem.cityName,weatherItem.stateName];
    cell.degreesCellLabel.text = weatherItem.temperature;
    
    NSLog(@"%@",weatherItem.temperature);
    
//    [NSString stringWithFormat:@"%@, %@",weatherItem.cityName,weatherItem.stateName];
    
//     cell.textLabel.text = [locationInfo2 objectForKey:@"formatted_address"];
    
//    WeatherItem *weatherItem = [[WeatherItem alloc] init];
//    NSDictionary *latLong = [locationInfo2 objectForKey:@"location"];
//    NSString *lat = [latLong objectForKey:@"lat"];
//    NSString *longitude = [latLong objectForKey:@"longitude"];
//    weatherItem.latitude = lat;
//    weatherItem.longitude = longitude;
//    

    
    
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
    if ([segue.identifier isEqualToString:@"AddLocationSegue"])
    {
        UINavigationController *navC = [segue destinationViewController];
        ZipCodeViewController *zipcodeVC = [navC viewControllers][0];
        zipcodeVC.location = location;
        
    }
}



@end
