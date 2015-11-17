//
//  TicketsTableViewController.m
//  Jackpot Redux
//
//  Created by Michael Reynolds on 11/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "TicketsTableViewController.h"
#import "Ticket.h"
#import "PickerViewController.h"

@interface TicketsTableViewController ()
{
    NSMutableArray *tickets;
    NSMutableArray *winningTicket;
}

@end

@implementation TicketsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tickets = [[NSMutableArray alloc] init];
    
    [self newTicket];
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
    return tickets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TicketCell" forIndexPath:indexPath];
    
    Ticket *aTicket = tickets[indexPath.row];
    NSString *ticketString = [self formatTicket:aTicket.numbers];
    
    cell.textLabel.text = ticketString;
    cell.detailTextLabel.text = [aTicket checkWinningTicket:winningTicket];
    if(aTicket.isWinner)
    {
        cell.backgroundColor = [UIColor greenColor];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PickerViewController *pickerVC = segue.destinationViewController;
    UIPopoverPresentationController *controller = pickerVC.popoverPresentationController;
    controller.delegate = self;
    pickerVC.delegate = self;
    
    pickerVC.modalPresentationStyle = UIModalPresentationPopover;
    pickerVC.preferredContentSize = CGSizeMake(400, 200);
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - ticket

- (void)newTicket
{
    Ticket *aTicket = [Ticket newTicket];
    [tickets addObject:aTicket];
    [self.tableView reloadData];
}

- (NSString *)formatTicket:(NSArray *)numbers
{
    NSString *ticketStr;
    ticketStr = [[NSString alloc] init];
    for(id number in numbers)
    {
        NSString *numberAsStr = [NSString stringWithFormat: @"%@ ", number];
        ticketStr = [ticketStr stringByAppendingString:numberAsStr];
    }
    return ticketStr;
}

- (void)winningNumbersWereChosen:(NSMutableArray *)winningNumbers;
{
    winningTicket = winningNumbers;
    
    [self.tableView reloadData];
}

#pragma mark - Action Handlers

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender
{
    [self newTicket];
}

- (IBAction)deleteButtonTapped:(UIBarButtonItem *)sender
{
    [tickets removeAllObjects];
    [winningTicket removeAllObjects];
    [self.tableView reloadData];
}



@end
