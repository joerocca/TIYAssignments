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
#import "DetailForecastViewController.h"
#import "NetworkManager.h"

#define kCitiesKey @"cities"

@interface ForecastTableViewController ()
{
    NSMutableArray *location;
}




@end

@implementation ForecastTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCityData];
    
    if ([location count]>0)
    {
        for (City *aCity in location)
        {
            aCity.currentWeather = [[Weather alloc] init];
        }
        [[NetworkManager sharedNetworkManager] fetchCurrentWeatherForCities:location];
    }
    
    self.title = @"Current Weather";
    [NetworkManager sharedNetworkManager].delegate = self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

}

-(void)loadCityData
{
    NSData *cityData = [[NSUserDefaults standardUserDefaults] objectForKey:kCitiesKey];
    if (cityData)
    {
        location = [NSKeyedUnarchiver unarchiveObjectWithData:cityData];
    }
    else
    {
        location = [[NSMutableArray alloc] init]; 
    }
}

- (void)saveCityData
{
    NSData *cityData = [NSKeyedArchiver archivedDataWithRootObject:location];
    [[NSUserDefaults standardUserDefaults] setObject:cityData forKey:kCitiesKey];
    
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
    
    
    

    
    City *cityItem = location[indexPath.row];
  
    
    
    cell.cityCellLabel.text =[NSString stringWithFormat:@"%@, %@",cityItem.name,cityItem.state];
    cell.degreesCellLabel.text = [cityItem.currentWeather currentTemperature];
  


    
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [location removeObjectAtIndex:indexPath.row];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    City *selectedCity = location[indexPath.row];
    DetailForecastViewController *DetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailForecastView"];
    DetailVC.aCity = selectedCity;
    
    [self.navigationController pushViewController:DetailVC animated:YES];
}







- (void)cityWasFound:(City *)aCity
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [location addObject:aCity];
    aCity.currentWeather = [[Weather alloc] init];
    
    [[NetworkManager sharedNetworkManager] fetchCurrentWeatherForCity:aCity];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[location indexOfObject:aCity] inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (void)weatherWasFoundForCity:(City *)aCity
{
    NSIndexPath *cityPath = [NSIndexPath indexPathForRow:[location indexOfObject:aCity] inSection:0];
    WeatherCell *cell = (WeatherCell *)[self.tableView cellForRowAtIndexPath:cityPath];
    
    cell.degreesCellLabel.text = [aCity.currentWeather currentTemperature];
    cell.currentConditionsLabel.text = aCity.currentWeather.summary;
    
    
}

@end
