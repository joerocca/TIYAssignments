//
//  Ticket.h
//  26 -- Jackpot 3
//
//  Created by Joe Rocca on 4/22/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

@property (assign) BOOL winningTicket;
@property (nonatomic) NSString *payAmount;

+(instancetype)createTicket;
+ (instancetype)ticketUsingArray:(NSArray *)specificTickets;

- (void)compareWithTicket:(Ticket *)anotherTicket;

- (NSArray *)ticketNumbers;

@end
