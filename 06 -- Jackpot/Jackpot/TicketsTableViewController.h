//
//  TicketsTableViewController.h
//  Jackpot
//
//  Created by Joe Rocca on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerWinningTicketDelegate   

-(void)winningTicketNumberWasChosen:(NSArray *)lottoWinnningNumbers; //what the delgate recieves?


@end



@interface TicketsTableViewController : UITableViewController <ViewControllerWinningTicketDelegate> //telling this view controller that it is the delegate?

@end
