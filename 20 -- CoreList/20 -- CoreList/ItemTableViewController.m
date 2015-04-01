//
//  ItemTableViewController.m
//  20 -- CoreList
//
//  Created by Joe Rocca on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ItemTableViewController.h"
#import "ModalViewController.h"
#import "CoreDataStack.h"
#import "ListItem.h"


static NSString * const StudentCellIdentifier = @"ItemCell";

@interface ItemTableViewController ()
{
    NSMutableArray *items;
    CoreDataStack *cdStack;
}



@end

@implementation ItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cdStack = [CoreDataStack coreDataStackWithModelName:@"CoreListModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    items = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSEntityDescription *entity =[NSEntityDescription entityForName:@"ListItem" inManagedObjectContext:cdStack.managedObjectContext];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = entity;
    
    items = nil;
    
    items = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
    
    [self.tableView reloadData];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    
    
    ListItem *anItem = items[indexPath.row];
    cell.textLabel.text = anItem.item;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        [cdStack.managedObjectContext deleteObject: items[indexPath.row]];
       
        [self saveCoreDataUpdates];
        
         [items removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ModalVCSegue"])
    {
        ModalViewController *ModalVC = (ModalViewController *)[segue destinationViewController];
        ModalVC.cdStack = cdStack;

        
    }
    
}

#pragma mark - Methods

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





@end
