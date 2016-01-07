//
//  Ticket.m
//  Jackpot Redux
//
//  Created by Michael Reynolds on 11/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "Ticket.h"

@implementation Ticket

+ (Ticket *)newTicket
{
    Ticket *aTicket = [[Ticket alloc] init];
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    BOOL willLoop = true;
    while(willLoop)
    {
        [numbers removeAllObjects];
        while (numbers.count < 6)
        {
            int number = 1 + arc4random() % 52;
            NSNumber *pick = [NSNumber numberWithInt:number];
            [numbers addObject: pick];
        }
        
        NSSet *setFromArray = [NSSet setWithArray:numbers];
        if(setFromArray.count == numbers.count)
        {
            willLoop = false;
        }
    }
    aTicket.numbers = numbers;
    return aTicket;
}

- (BOOL)noDuplicates:(NSMutableArray *)arrayToTest
{
    NSSet *setFromArray = [NSSet setWithArray:arrayToTest];
    if(setFromArray.count == arrayToTest.count)
    {
        return true;
    }
    else
    {
        return false;
    }
}

- (NSString *)checkWinningTicket:(NSMutableArray *)winningTicketNumbers
{
    int matchingNumbers = 0;
    
    NSString *prize = [[NSString alloc] init];
    prize = @"$0";
    self.isWinner = NO;
    
    for (NSNumber *winningNumber in winningTicketNumbers)
    {
        for(NSNumber *number in self.numbers)
        {
            if([number isEqualToNumber: winningNumber])
            {
                matchingNumbers += 1;
            }
        }
    }
    
//    NSLog(@"%@", self.numbers);
//    NSLog(@"%@", winningTicketNumbers);
    
    if (matchingNumbers == 3)
    {
        prize = @"$1";
        self.isWinner = YES;
    }
    else if (matchingNumbers == 4)
    {
        prize = @"$5";
        self.isWinner = YES;
    }
    else if (matchingNumbers == 5)
    {
        prize = @"$20";
        self.isWinner = YES;
    }
    else if (matchingNumbers == 6)
    {
        prize = @"$100";
        self.isWinner = YES;        
    }
    
    NSLog(@"tick prz amt %d", matchingNumbers);
    return prize;
}


@end
