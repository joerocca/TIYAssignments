//
//  Ticket.h
//  Jackpot
//
//  Created by Joe Rocca on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ticket : NSObject

+ (instancetype)ticketUsingQuickPick;     //+ = class method
+ (instancetype)ticketsUsingArray:(NSArray *)winningNumbers;  //state propertys/methods/classes that you want to call from other places in the .h file



@end

