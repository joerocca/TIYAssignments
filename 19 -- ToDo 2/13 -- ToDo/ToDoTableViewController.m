//
//  ToDoTableViewController.m
//  13 -- ToDo
//
//  Created by Joe Rocca on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ToDoTableViewController.h"
#import "DetailToDoTableViewController.h"
#import "ToDoItem.h"
#import "ToDoCell.h"

@interface ToDoTableViewController () <UITextFieldDelegate>
{
    ToDoCell *toDoCell;
    NSMutableArray *taskList;
    UIRefreshControl *refreshControl;
}

- (IBAction)addCellButton:(UIBarButtonItem *)sender;
- (IBAction)clearButton:(UIRefreshControl *)sender;
- (IBAction)checkmarkButton:(UIButton *)sender;



@property (weak, nonatomic) IBOutlet UIBarButtonItem *cellAddButtonOutlet;


@end

@implementation ToDoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"To Do List";
    taskList = [[NSMutableArray alloc] init];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(clearButton:) forControlEvents:UIControlEventValueChanged];
    [self setRefreshControl:refreshControl];
    
//    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCellButton:)];
    
    
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
    ToDoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    
     ToDoItem *item = taskList[indexPath.row];
    
    
    
    

        cell.descriptionTextField.delegate = self;
   
   
    
    
    
    
  
    
    cell.descriptionTextField.text = @"";
    
    
    
    if (item)
    {
        if(item.taskName)
        {
            [cell.descriptionTextField setText:item.taskName];
        }
        else
        {
            [cell.descriptionTextField becomeFirstResponder]; //brings up keyboard
        }
        
        [cell.checkBoxButton setSelected:item.done];
    }
    
    
    
    

 
    return cell;
}










// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    ToDoItem *item = taskList[indexPath.row];
    
    return  item.done;
    
}





// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        
    if (editingStyle == UITableViewCellEditingStyleDelete)
        {
        
        
            [taskList removeObjectAtIndex:indexPath.row];
        
        
        
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"DetailSegue"])
    {
        DetailToDoTableViewController *DetailVC = (DetailToDoTableViewController *)[segue destinationViewController];
        ToDoCell *senderCell = (ToDoCell *)sender;
        NSIndexPath *path = [self.tableView indexPathForCell:senderCell];
        ToDoItem *anItem = taskList[path.row];
        anItem.taskName = senderCell.descriptionTextField.text;
        anItem.done = senderCell.checkBoxButton.selected;
        DetailVC.aTask = anItem;
        
        NSLog(@"%@",anItem);
    
//        NSLog(@"%@",sender);
    }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}




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
    
    NSUInteger index2 = [taskList indexOfObject:anItem];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index2 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]  withRowAnimation:UITableViewRowAnimationAutomatic];

    
    
//    [self.tableView reloadData];

}

- (IBAction)clearButton:(UIRefreshControl *)sender
{
    NSMutableArray *indexPathsToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *itemsToRemove = [[NSMutableArray alloc] init];
    
    for (ToDoItem *anItem in taskList)
    {
        if (anItem.done)
        {
            [itemsToRemove addObject:anItem];
            [indexPathsToRemove addObject:[NSIndexPath indexPathForRow:[taskList indexOfObject:anItem] inSection:0]];
        }
    }
    
    [taskList removeObjectsInArray:itemsToRemove];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [sender endRefreshing];
}

- (IBAction)checkmarkButton:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    UITableViewCell *cell = (UITableViewCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    ToDoItem *anItem = taskList[path.row];
    anItem.done = !anItem.done;
    [sender setSelected:anItem.done];
//    [sender setSelected:cell.backgroundColor = [UIColor colorWithRed:0.33 green:0.99 blue:0.99 alpha:0.20]];
}

@end
