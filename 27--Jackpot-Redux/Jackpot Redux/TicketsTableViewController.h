//
//  TicketsTableViewController.h
//  Jackpot Redux
//
//  Created by Michael Reynolds on 11/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerProtocol

- (void)winningNumbersWereChosen:(NSMutableArray *)winningNumbers;

@end

@interface TicketsTableViewController : UITableViewController <PickerProtocol, UIPopoverPresentationControllerDelegate>

@end
