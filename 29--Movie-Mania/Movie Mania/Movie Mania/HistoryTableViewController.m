//
//  HistoryTableViewController.m
//  Movie Mania
//
//  Created by david on 11/14/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "HistoryTableViewController.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (!self.history)
    {
        self.history = [[NSArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.history.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HistoryCell" forIndexPath:indexPath];
    
    NSDictionary *historyResult = self.history[indexPath.row];
    
    cell.textLabel.text = (NSString *)historyResult[@"Title"];
    cell.detailTextLabel.text = (NSString *)historyResult[@"Year"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *chosenHistoryResult = self.history[indexPath.row];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate historySearchResultWasChosen:chosenHistoryResult];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
