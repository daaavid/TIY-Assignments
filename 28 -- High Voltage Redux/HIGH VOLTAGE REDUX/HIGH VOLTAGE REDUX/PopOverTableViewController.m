//
//  PopOverTableViewController.m
//  HIGH VOLTAGE REDUX
//
//  Created by Samuel Shaw on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "PopOverTableViewController.h"

@interface PopOverTableViewController ()

@end

@implementation PopOverTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
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
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *item = self.items[indexPath.row];
    
    [self.delegate itemWasChosen: item];
        
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    NSString *item = self.items[indexPath.row];
    cell.textLabel.text = item;
    
    return cell;
}

@end
