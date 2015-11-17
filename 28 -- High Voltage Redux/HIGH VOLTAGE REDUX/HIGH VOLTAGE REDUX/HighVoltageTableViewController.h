//
//  HighVoltageTableViewController.h
//  HIGH VOLTAGE REDUX
//
//  Created by david on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverProtocol

-(void)itemWasChosen:(NSString *)chosenItem;

@end


@interface HighVoltageTableViewController : UITableViewController <PopoverProtocol, UIPopoverPresentationControllerDelegate, UITextFieldDelegate>

@end
