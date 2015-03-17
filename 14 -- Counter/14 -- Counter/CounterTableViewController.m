//
//  CounterTableViewController.m
//  14 -- Counter
//
//  Created by Joe Rocca on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CounterTableViewController.h"
#import "CounterCell.h"
#import "CounterItem.h"

@interface CounterTableViewController ()<UITextFieldDelegate>
{
    NSMutableArray *countList;
}

- (IBAction)addCounterCellButton:(UIBarButtonItem *)sender;

- (IBAction)deleteCounterCellButton:(UIBarButtonItem *)sender;

- (IBAction)minusButton:(UIButton *)sender;
- (IBAction)plusButton:(UIButton *)sender;





@end

@implementation CounterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countList = [[NSMutableArray alloc] init];
    self.title = @"Counter";
    
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
    return [countList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   CounterCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"CounterCell" forIndexPath:indexPath];
    
    cell.descriptionTextField.delegate = self;
    
    
    CounterItem *item = countList[indexPath.row];
    
    cell.descriptionTextField.text = @"";
    
    if (item)
    {
        if(item.counterName)
        {
            [cell.descriptionTextField setText:item.counterName];
        }
        else
        {
            [cell.descriptionTextField becomeFirstResponder]; //brings up keyboard
        }
        
       
    }
    
    
    
    
    
    
    
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
        [countList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
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



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] || [textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        
        
        UIView *contentView = [textField superview];
        UITableViewCell *cell = (UITableViewCell *)[contentView superview]; //need explaination
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        CounterItem *anItem = countList[path.row];
        anItem.counterName = textField.text;

        
        
        rc = YES;
    }
    
    
    return rc;
}








#pragma mark - Action Handlers


- (IBAction)addCounterCellButton:(UIBarButtonItem *)sender
{
    CounterItem *anItem = [[CounterItem alloc] init];
    [countList addObject:anItem];
    
    NSUInteger index2 = [countList indexOfObject:anItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index2 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
    
}

- (IBAction)deleteCounterCellButton:(UIBarButtonItem *)sender
{
    

    
    
    
    [countList removeAllObjects];
    [self.tableView reloadData];

    

}

- (IBAction)minusButton:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    CounterCell *cell = (CounterCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    CounterItem *aCounter = countList[path.row];
    
    [aCounter calcCountDown];
    cell.counterLabel.text = [NSString stringWithFormat:@"%2ld", (long)aCounter.counterValue];
    
    
    
    
}

- (IBAction)plusButton:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    CounterCell *cell = (CounterCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    CounterItem *aCounter = countList[path.row];
    
    [aCounter calcCountUp];
    cell.counterLabel.text = [NSString stringWithFormat:@"%2ld", (long)aCounter.counterValue];

    
}




@end
