//
//  SearchResultsModalTableViewController.m
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "SearchResultsModalTableViewController.h"
#import "DetailSearchResultViewController.h"

@import MapKit;
@import CoreLocation;

@interface SearchResultsModalTableViewController ()<CLLocationManagerDelegate,UISearchBarDelegate,NSURLSessionDataDelegate>
{
CLLocationManager *locationManager;
MKLocalSearch *localSearch;
NSMutableData *receivedData;
double latitude;
double longitude;
NSMutableArray *globalVenueArray;
    
}




@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


- (IBAction)cancelButton:(UIBarButtonItem *)sender;




@end

@implementation SearchResultsModalTableViewController


static NSString *clientID = @"KBHEX4LKMFTRUMLYXN4OZOPY2IHOL1KUVBR4OEZXUBSSMLZA";
static NSString *clientSecret = @"AOXFKQTCEMKYNK3LA4LEOIVG5SIAEBAYOMEN4JDZNCBPZZLA";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search Results";
    self.navigationItem.prompt = @"Enter a venue name to receive a list of results";

    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search";
    [self.searchBar becomeFirstResponder];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    

    
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
    return [self.venues count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultsCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.venues[indexPath.row][@"name"];
    
   
    NSString *address = [self.venues[indexPath.row][@"location"][@"formattedAddress"] objectAtIndex:0];
    NSString *cityStateZip = [self.venues[indexPath.row][@"location"][@"formattedAddress"] objectAtIndex:1];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  |  %@", address, cityStateZip];
    
    NSString *iconPrefix = [self.venues[indexPath.row] [@"categories"]objectAtIndex:0][@"icon"][@"prefix"];
    NSString *iconSuffix = [self.venues[indexPath.row] [@"categories"]objectAtIndex:0][@"icon"][@"suffix"];
    NSString *icon = [NSString stringWithFormat:@"%@%@%d%@",iconPrefix,@"bg_",44,iconSuffix];
    NSURL *iconURL = [NSURL URLWithString:icon];
    NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
//    NSLog(@"%@",icon);
 
    
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *aVenue = [self.venues objectAtIndex:indexPath.row];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    
    DetailSearchResultViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailResultView"];
    

    detailVC.venueInfo = aVenue;

    detailVC.cdStack = self.cdStack;
    
     [self.navigationController pushViewController:detailVC animated:YES];
    
    NSLog(@"%@",aVenue);

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
    
      if ([segue.identifier isEqualToString:@"SearchResultDetailSegue"])
      {
          


      }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.searchBar resignFirstResponder];
    [self configureLocationManager];
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
    
    
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    
    
    
    [self foursquareUrlSession];
    
    NSLog(@"%f",latitude);
    NSLog(@"%f",longitude);
    
    
}



-(void)foursquareUrlSession
{
    NSString *searchString = self.searchBar.text;
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%f,%f&query=%@&radius=1600",clientID,clientSecret,latitude,longitude,searchString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSLog(@"%@",urlString);
    
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //
    //    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //
    //    NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    //    [self.friends addObject:userInfo];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url]; //starts in paused state; have to tell it to resume.
    
    [dataTask resume];
    
    //    [self cancel];
}



- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if(!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    
    else
    {
        [receivedData appendData:data];
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error //if didnt complete, this will point to error
{
    if (!error)
    {
        NSLog(@"Download Successful.");
        NSDictionary *venueInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];

       NSDictionary *response = [venueInfo objectForKey:@"response"];
       NSMutableArray *venues = [response objectForKey:@"venues"];

        self.venues = venues;
        
        if ([self.venues isEqualToArray:@[]])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No search results"
                                                                           message:@"Try another search request"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action) {
                                                                 
                                                                 
                                                             }];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }

        [self.tableView reloadData];
        
        
        NSLog(@"%@", self.venues);

    }
}







- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    [self.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
