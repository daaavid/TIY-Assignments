//
//  PopOverTableViewController.h
//  HIGH VOLTAGE REDUX
//
//  Created by Samuel Shaw on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighVoltageTableViewController.h"

@interface PopOverTableViewController : UITableViewController

@property (nonatomic) id <PopoverProtocol> delegate;
@property (nonatomic) NSMutableArray *items;

@end
