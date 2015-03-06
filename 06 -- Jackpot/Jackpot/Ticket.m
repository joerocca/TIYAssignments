//
//  Ticket.m
//  Jackpot
//
//  Created by Joe Rocca on 3/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.


// Model Class

#import "Ticket.h"

@interface Ticket ()
{
    NSMutableArray *picks;
    NSNumber *aNumber;
}



@end

@implementation Ticket

+ (instancetype)ticketUsingQuickPick
{
    Ticket *aTicket = [[Ticket alloc] init];  //create 6 random numbers with the create pick method and store the in the a ticket
    if (aTicket)
    {
        for (int i = 0; i < 6; i++)  //number of times this will loop //start at 0 condition is 6
                                    //for(int i=initial value; conditional exp."i<6";incrementation exp."i++ or i = i + 1){}
                                    //set initial value;run loop;increment initial value;check conditional;run loop again
        {
        [aTicket createPick];
        }
    }
    return aTicket;
}

- (instancetype)init
{
    if (self = [super init])
    {
        picks = [[NSMutableArray alloc] init];  //creating a picks mutable array to store the random number values
    
    }
    
    return self;
}

+ (instancetype)ticketsUsingArray:(NSArray *)winningNumbers
{
    {
        Ticket *winningTicket = [[Ticket alloc] init]; // for winning ticket object
        if (winningTicket)
        {
            [winningTicket createPicksWithArray:winningNumbers];
        }
        
        return winningTicket;
    }

}


-(NSString *)description
{
    

   return [NSString stringWithFormat:@"%@   %@   %@   %@   %@   %@", picks[0], picks[1],picks[2],picks[3],picks[4],picks[5]]; //set each picks number to the description object method
    
    
}

-(void)createPick
{
    int pickInt = arc4random() % 53 + 1; //create a random number  //add 1 because the numbers go from 0-52 if the perimeter is set to 53 and we need 53. If we add 1we get 1-53.
    aNumber = [NSNumber numberWithInt:pickInt]; // assign it to the a Number variable
    [picks addObject:aNumber];  //add that random number to the picks array
    NSSortDescriptor *ascending = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];     [picks sortUsingDescriptors:@[ascending]];//sort those numbers in ascending order


}

-(void)createPicksWithArray:(NSArray *)winningPicks
{
    
    picks = [winningPicks mutableCopy];
    
}

@end

