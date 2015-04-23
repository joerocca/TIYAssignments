//
//  RandomLottoNumberTableViewController.m
//  26 -- Jackpot 3
//
//  Created by Joe Rocca on 4/22/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "RandomLottoNumberTableViewController.h"
#import "LottoNumberPickerViewController.h"
#import "TicketCell.h"
#import "Ticket.h"

@interface RandomLottoNumberTableViewController () <UIPopoverPresentationControllerDelegate>

- (IBAction)generateLottoNumbersButton:(UIBarButtonItem *)sender;

@end

@implementation RandomLottoNumberTableViewController
{
    NSMutableArray *tickets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lotto Tickets";
    tickets = [[NSMutableArray alloc] init];
    
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
    return [tickets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LottoNumbersCell" forIndexPath:indexPath];
    
    Ticket *aTicket = tickets[indexPath.row];

    
    cell.ticketNumbersLabel.text = [aTicket description];
    

    
    if (aTicket.winningTicket)
    {
        cell.backgroundColor = [UIColor greenColor];
        cell.payAmountLabel.text = aTicket.payAmount;
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.payAmountLabel.text = @"";
    }
    
    
    return cell;
}


- (void)winningTicketWasAdded:(Ticket *)ticket
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self checkForWinnersUsingTicket:ticket];
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
    if ([segue.identifier isEqualToString:@"PickerSegue"])
    {
        LottoNumberPickerViewController *lottoPickerVC = (LottoNumberPickerViewController*)[segue destinationViewController];
        lottoPickerVC.delegate = self;
        lottoPickerVC.popoverPresentationController.delegate = self;   //allows us to recieve info from popovervc
        
        float contentHeight = 300.0f;  //gives us the height fo the modal
        
        lottoPickerVC.preferredContentSize = CGSizeMake(300.0f, contentHeight); //sets the height and width of the modal
        
        
    }
}

#pragma mark - PopoverPresentationController delegate


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    
    return UIModalPresentationNone;
}




- (IBAction)generateLottoNumbersButton:(UIBarButtonItem *)sender
{

    Ticket *aTicket =[Ticket createTicket];
    [tickets addObject:aTicket];
    [self.tableView reloadData];
}


#pragma mark - Private Methods

- (void)checkForWinnersUsingTicket:(Ticket *)winningTicket
{
    for (Ticket *aTicket in tickets)
    {
        [aTicket compareWithTicket:winningTicket];
    }
    [self.tableView reloadData];
}



@end
