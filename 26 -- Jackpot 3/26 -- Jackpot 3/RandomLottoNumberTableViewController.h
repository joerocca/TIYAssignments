//
//  RandomLottoNumberTableViewController.h
//  26 -- Jackpot 3
//
//  Created by Joe Rocca on 4/22/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ticket.h"

@protocol RandomLottoNumberTableViewControllerDelegate

- (void)winningTicketWasAdded:(Ticket *)ticket;

@end

@interface RandomLottoNumberTableViewController : UITableViewController <RandomLottoNumberTableViewControllerDelegate>



@end
