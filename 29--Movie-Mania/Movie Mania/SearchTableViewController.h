//
//  SearchTableViewController.h
//  Movie Mania
//
//  Created by david on 11/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryProtocol

- (void)historySearchResultWasChosen:(NSDictionary *)result;

@end

@interface SearchTableViewController : UITableViewController <HistoryProtocol>

@end
