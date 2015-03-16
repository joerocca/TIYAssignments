//
//  ToDoTableViewController.m
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "ToDoItem.h"

@interface ToDoTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *taskList;
}

- (IBAction)addCellButton:(UIBarButtonItem *)sender;
- (IBAction)clearButton:(UIBarButtonItem *)sender;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *cellAddButtonOutlet;


@end

@implementation ToDoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"To Do List";
    taskList = [[NSMutableArray alloc] init];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
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
    return [taskList count];
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
     ToDoItem *item = taskList[indexPath.row];
    
    
    
    UITextField *cellTextField = (UITextField  *)[cell viewWithTag:1];
//    UISwitch *cellSwitch = (UISwitch  *)[cell viewWithTag:2];
    
   
        cellTextField.text = @"";
    
    
    
  
    
    
    cellTextField.delegate = self;
    
    
    if (item)
    {
        if(item.taskName)
        {
            [cellTextField setText:item.taskName];
        }
        else
        {
            [cellTextField becomeFirstResponder]; //brings up keyboard
        }
        
    }
    
    
    
//    if (!cellSwitch.isOn == NO)
//    {
//
//        cell.backgroundColor = [UIColor greenColor];
//
//    }
    
 
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
        [taskList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


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
        ToDoItem *anItem = taskList[path.row];
        anItem.taskName = textField.text;
        
        
        
        rc = YES;
    }
    
    
    return rc;
}

# pragma mark - Action Handlers

- (IBAction)addCellButton:(UIBarButtonItem *)sender
{
    ToDoItem *anItem = [[ToDoItem alloc] init];
    [taskList addObject:anItem];
    [self.tableView reloadData];

}

- (IBAction)clearButton:(UIBarButtonItem *)sender
{
    [taskList removeAllObjects];
    [self.tableView reloadData];
    
    
}


@end
