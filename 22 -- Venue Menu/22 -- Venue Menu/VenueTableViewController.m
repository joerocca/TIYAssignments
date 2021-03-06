//
//  VenueTableViewController.m
//  22 -- Venue Menu
//
//  Created by Joe Rocca on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "VenueTableViewController.h"
#import "SearchResultsModalTableViewController.h"
#import "DetailSearchResultViewController.h"
#import "CoreDataStack.h"
#import "Venue.h"

@interface VenueTableViewController ()<UITextFieldDelegate>
{
    NSInteger indexpathForDelete;
}


- (IBAction)addVenueButton:(UIBarButtonItem *)sender;




@end

@implementation VenueTableViewController
{
    NSMutableArray *favoriteVenues;
     CoreDataStack *cdStack;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favorite Venues";
    
    cdStack = [CoreDataStack coreDataStackWithModelName:@"VenueDataModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    favoriteVenues = [[NSMutableArray alloc] init];
 
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSEntityDescription *entity =[NSEntityDescription entityForName:@"Venue" inManagedObjectContext:cdStack.managedObjectContext];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = entity;
    
    favoriteVenues = nil;
    
    favoriteVenues = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
    
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
    return [favoriteVenues count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    Venue *aVenue = favoriteVenues[indexPath.row];
    cell.textLabel.text = aVenue.name;
    
    NSString *streetAddress = aVenue.streetAddress;
    NSString *cityStateZip = aVenue.cityStateZip;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  |  %@", streetAddress, cityStateZip];
    
    NSString *icon = aVenue.icon;
    NSURL *iconURL = [NSURL URLWithString:icon];
    NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
    
    return cell;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Venue *aVenue = [favoriteVenues objectAtIndex:indexPath.row];
//    
//    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    
//    DetailSearchResultViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailResultView"];
//    
//    
//    detailVC.venueObject = aVenue;
//    
////    detailVC.cdStack = self.cdStack;
//    
//    [self.navigationController pushViewController:detailVC animated:YES];
//    
//    NSLog(@"%@",aVenue);
    
//}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Venue *aVenue = [favoriteVenues objectAtIndex:indexPath.row];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    DetailSearchResultViewController *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailResultView"];
    
    
    detailVC.venueObject = aVenue;
    
    detailVC.delegate = self;
    
    indexpathForDelete = indexPath.row;
        
    
    //    detailVC.cdStack = self.cdStack;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    NSLog(@"%@",aVenue);
    NSLog(@"%ld",(long)indexPath.row);
}






 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [cdStack.managedObjectContext deleteObject: favoriteVenues[indexPath.row]];
        
        [self saveCoreDataUpdates];
        
        [favoriteVenues removeObjectAtIndex:indexPath.row];
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/








- (IBAction)addVenueButton:(UIBarButtonItem *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *navC = [storyboard instantiateViewControllerWithIdentifier:@"SearchResultsNavC"];
    
    SearchResultsModalTableViewController *searchResultsVC = [navC viewControllers][0];
    
    
    [searchResultsVC setModalPresentationStyle:UIModalPresentationFullScreen];
    
    
    searchResultsVC.cdStack = cdStack;
    
    
    [self presentViewController:navC animated:YES completion:nil];
}





- (void)saveCoreDataUpdates
{
    [cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@",[errorOrNil localizedDescription]);
         }
     }];
}

-(void)unfavorite
{
    [cdStack.managedObjectContext deleteObject: favoriteVenues[indexpathForDelete]];
     [self saveCoreDataUpdates];
}




@end
