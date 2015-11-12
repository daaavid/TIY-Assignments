//
//  HighVoltageTableViewController.m
//  HIGH VOLTAGE REDUX
//
//  Created by david on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "HighVoltageTableViewController.h"
#import "PopOverTableViewController.h"
#import "CalcCell.h"
#import "Brainerino.h"

@interface HighVoltageTableViewController ()
{
    Brainerino *brain;
}

@property NSArray *allItems;
@property NSMutableArray *remainingItems;
@property NSMutableArray *shownItems;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIButton *calculateButton;

@end

@implementation HighVoltageTableViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allItems = @[@"AMPS", @"WATTS", @"VOLTS", @"OHMS"];
    self.remainingItems = [[NSMutableArray alloc] initWithArray:self.allItems];
    self.shownItems = [[NSMutableArray alloc] init];
    
    self.addButton.enabled = YES;
    self.calculateButton.enabled = NO;
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
    return self.shownItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalcCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalcCell" forIndexPath:indexPath];
    
    NSString *item = self.shownItems[indexPath.row];
    cell.elecLabel.text = item;
    
    if([cell.elecTextField.text isEqualToString:@""])
    {
        [cell.elecTextField becomeFirstResponder];
    }
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    if([textField.text isEqualToString:@""])
    {
        rc = YES;
    }
    
    if(self.shownItems.count == 2)
    {
        [self calculate];
    }
    
    return rc;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowPopoverSegue"])
    {
        PopOverTableViewController *popVC = segue.destinationViewController;
        UIPopoverPresentationController *popover = popVC.popoverPresentationController;
        
        popVC.delegate = self;
        popover.delegate = self;
        
        popVC.items = [[NSMutableArray alloc] initWithArray:self.remainingItems];
        
        popVC.modalPresentationStyle = UIModalPresentationPopover;
        
        CGFloat contentHeight = popVC.items.count * 44;
        
        popVC.preferredContentSize = CGSizeMake(200, contentHeight);
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

#pragma mark - Action Handlers

- (IBAction)calculateButtonTapped:(UIButton *)sender
{
    [self calculate];
}

- (IBAction)clearButtonTapped:(UIButton *)sender
{
    [self.remainingItems addObjectsFromArray:self.allItems];
    [self.shownItems removeAllObjects];
    
    NSArray *visibleCells = self.tableView.visibleCells;
    
    for (CalcCell *cell in visibleCells)
    {
        cell.elecTextField.text = @"";
    }
    
    self.addButton.enabled = YES;
    self.calculateButton.enabled = NO;
    
    [self.tableView reloadData];
}

#pragma mark - item chosen from popover functon

- (void)itemWasChosen:(NSString *)chosenItem;
{
    [self.shownItems addObject:chosenItem];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    if([self.remainingItems containsObject:chosenItem])
    {
        [self.remainingItems removeObject:chosenItem];
    }
    
    if(self.shownItems.count == 2)
    {
        self.addButton.enabled = NO;
        self.calculateButton.enabled = YES;
    }
    
    [self.tableView reloadData];
}

#pragma mark - private

- (void)calculate
{
    brain = [[Brainerino alloc] init];
    
    NSArray *visibleCells = self.tableView.visibleCells;
    
    for (CalcCell *cell in visibleCells)
    {
        NSString *cellLabel = cell.elecLabel.text;
        NSString *cellTextfield = cell.elecTextField.text;
        
        [self checkCellLabelAndSetValues:cellLabel textfield:cellTextfield];
    }
    
    for (NSString *item in self.allItems)
    {
        if(![self.shownItems containsObject:item])
        {
            [self.shownItems addObject:item];
        }
    }
    
    [brain calculate];
    
    [self.tableView reloadData];
    
    [self populateCellsWithAnswers];
    [self.remainingItems removeAllObjects];
    
    [self.tableView reloadData];
}

- (BOOL)checkCellLabelAndSetValues:(NSString *) label textfield:(NSString *)textfield
{
    if([textfield doubleValue] > 0)
    {
        if([label isEqualToString:@"WATTS"])
        {
            double watts = [textfield doubleValue];
            brain.watts = watts;
        }
        else if([label isEqualToString:@"VOLTS"])
        {
            double volts = [textfield doubleValue];
            brain.volts = volts;
        }
        else if([label isEqualToString:@"AMPS"])
        {
            double amps = [textfield doubleValue];
            brain.amps = amps;
        }
        else if([label isEqualToString:@"OHMS"])
        {
            double ohms = [textfield doubleValue];
            brain.ohms = ohms;
        }
    }
    return YES;
}

- (void)populateCellsWithAnswers
{
    NSArray *cells = [self.tableView visibleCells];
    for(CalcCell *cell in cells)
    {
        if([cell.elecLabel.text isEqualToString:@"OHMS"])
        {
            NSString *ohmStr = [self formatAnswer:brain.ohms];
            cell.elecTextField.text = ohmStr;
        }
        
        if([cell.elecLabel.text isEqualToString:@"VOLTS"])
        {
            NSString *voltStr = [self formatAnswer:brain.volts];
            cell.elecTextField.text = voltStr;
        }
        
        if([cell.elecLabel.text isEqualToString:@"AMPS"])
        {
            NSString *ampStr = [self formatAnswer:brain.amps];
            cell.elecTextField.text = ampStr;
        }
        
        if([cell.elecLabel.text isEqualToString:@"WATTS"])
        {
            NSString *wattStr = [self formatAnswer:brain.watts];
            cell.elecTextField.text = wattStr;
        }
    }
}

- (NSString *)formatAnswer:(double)answerToFormat
{
    NSString *ansStr = [NSString stringWithFormat:@"%f", answerToFormat];
    NSArray *ansArr = [ansStr componentsSeparatedByString:@"."];
    if([ansArr[1] doubleValue] == 0)
    {
        ansStr = ansArr[0];
    }
    
    return ansStr;
}

@end
