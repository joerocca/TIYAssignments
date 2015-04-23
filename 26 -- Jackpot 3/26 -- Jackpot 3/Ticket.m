//
//  Ticket.m
//  26 -- Jackpot 3
//
//  Created by Joe Rocca on 4/22/15.
//  Copyright (c) 2015 Joe Rocca. All rights reserved.
//

#import "Ticket.h"


typedef enum
{
    WinnerType1Dollar = 3,
    WinnerType5Dollars = 4,
    WinnerType20Dollars = 5,
    WinnerType100Dollars = 6,
} WinnerType;

@implementation Ticket
{
    NSMutableArray *ticketNumbers;
}


- (instancetype)init
{
    if (self = [super init])
    {
        ticketNumbers = [[NSMutableArray alloc] init];
        _winningTicket = NO;
        _payAmount = @"";
    }
    
    return self;
}

+(instancetype)createTicket
{
     Ticket *aTicket = [[Ticket alloc] init];
        for (int i = 0; i < 6; i++)
        {
            [aTicket generateTicketNumbers];
        }
    
    return aTicket;
    
}

+ (instancetype)ticketUsingArray:(NSArray *)specificTickets
{
    Ticket *aTicket = [[Ticket alloc] init];
    [aTicket insertPicksUsingArray:specificTickets];
    return aTicket;
}


-(void)generateTicketNumbers
{
    
    int randomLottoNumber = arc4random_uniform(53) + 1;
    [ticketNumbers addObject:[NSNumber numberWithInt:randomLottoNumber]];
        
    
    
    NSSortDescriptor *lowestToHighest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [ticketNumbers sortUsingDescriptors:@[lowestToHighest]];
    
    
    NSLog(@"%@",ticketNumbers);
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  %@  %@  %@  %@  %@", ticketNumbers[0], ticketNumbers[1], ticketNumbers[2], ticketNumbers[3], ticketNumbers[4], ticketNumbers[5]];
}


- (NSArray *)ticketNumbers
{
    return [ticketNumbers copy];
}

- (void)insertPicksUsingArray:(NSArray *)specificPicks
{
    ticketNumbers = [specificPicks mutableCopy];
}


- (void)compareWithTicket:(Ticket *)anotherTicket
{
    NSArray *possibleWinningNumbers = [anotherTicket ticketNumbers];
    int matchCount = 0;
    
    for (int i = 0; i < [ticketNumbers count]; i++)
    {
        for (int j = 0; j < [possibleWinningNumbers count]; j++)
        {
            if ([ticketNumbers[i] isEqualToNumber:possibleWinningNumbers[j]])
            {
                matchCount++;
                break;
            }
        }
    }
    
    switch (matchCount)
    {
        case WinnerType1Dollar:
            [self setWinningTicket:YES];
            [self setPayAmount:@"$1"];
            break;
        case WinnerType5Dollars:
            [self setWinningTicket:YES];
            [self setPayAmount:@"$5"];
            break;
        case WinnerType20Dollars:
            [self setWinningTicket:YES];
            [self setPayAmount:@"$20"];
            break;
        case WinnerType100Dollars:
            [self setWinningTicket:YES];
            [self setPayAmount:@"$100"];
            break;
            
        default:
            break;
    }
}


@end
