//
//  PickerViewController.m
//  Jackpot Redux
//
//  Created by Michael Reynolds on 11/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "PickerViewController.h"

@interface PickerViewController ()
{
    NSMutableArray *winningNumbers;
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *com0;
@property (weak, nonatomic) IBOutlet UITextField *com1;
@property (weak, nonatomic) IBOutlet UITextField *com2;
@property (weak, nonatomic) IBOutlet UITextField *com3;
@property (weak, nonatomic) IBOutlet UITextField *com4;
@property (weak, nonatomic) IBOutlet UITextField *com5;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

@end

@implementation PickerViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for(int x = 5; x >= 0; x--)
    {
        int randomRow = arc4random() % 52;
        [self.picker selectRow:randomRow inComponent:x animated:YES];
    }
    
    winningNumbers = [[NSMutableArray alloc] init];
    
    self.errorLabel.text = @"";
    
    [self.com0 becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    winningNumbers = [self getWinningNumbers];
    
    NSLog(@"%@", winningNumbers);
    
    [self.delegate winningNumbersWereChosen: winningNumbers];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 52;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowAsStr = [NSString stringWithFormat:@"%ld", (long)row + 1];
    return rowAsStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.errorLabel.text = @"";
}

-(NSMutableArray *)getWinningNumbers
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(int x = 0; x <= 5; x++)
    {
        NSInteger selectedNumber = [self.picker selectedRowInComponent:x];
        NSNumber *selectedNSNumber = [NSNumber numberWithInteger:selectedNumber + 1];
        [tempArray addObject:selectedNSNumber];
    }
    return tempArray;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if(![self.com0.text isEqualToString: @""])
    {
        [self.com1 becomeFirstResponder];
    }
    if(![self.com1.text isEqualToString: @""])
    {
        [self.com2 becomeFirstResponder];
    }
    if(![self.com2.text isEqualToString: @""])
    {
        [self.com3 becomeFirstResponder];
    }
    if(![self.com3.text isEqualToString: @""])
    {
        [self.com4 becomeFirstResponder];
    }
    if(![self.com4.text isEqualToString: @""])
    {
        [self.com5 becomeFirstResponder];
    }
    if(![self.com5.text isEqualToString: @""])
    {
        [self setRows];
        rc = YES;
    }
    
    return rc;
}

- (IBAction)setButtonTapped:(UIButton *)sender
{
    [self setRows];
}

- (void)setRows
{
    self.errorLabel.text = @"";
    
    NSInteger allNumbers = 0;
    
    NSArray *numStrArr = @[
                           self.com0.text,
                           self.com1.text,
                           self.com2.text,
                           self.com3.text,
                           self.com4.text,
                           self.com5.text
                           ];
    
    NSOrderedSet *numStrSet = [NSOrderedSet orderedSetWithArray:numStrArr];
    
    for(NSString *str in numStrArr)
    {
        if([str integerValue] > 0)
        {
            allNumbers += 1;
        }
    }
    
    if(numStrSet.count == numStrArr.count && allNumbers == 6)
    {
        NSInteger num0 = [self.com0.text integerValue] - 1;
        NSInteger num1 = [self.com1.text integerValue] - 1;
        NSInteger num2 = [self.com2.text integerValue] - 1;
        NSInteger num3 = [self.com3.text integerValue] - 1;
        NSInteger num4 = [self.com4.text integerValue] - 1;
        NSInteger num5 = [self.com5.text integerValue] - 1;
        
        [self.picker selectRow:num0 inComponent:0 animated:YES];
        [self.picker selectRow:num1 inComponent:1 animated:YES];
        [self.picker selectRow:num2 inComponent:2 animated:YES];
        [self.picker selectRow:num3 inComponent:3 animated:YES];
        [self.picker selectRow:num4 inComponent:4 animated:YES];
        [self.picker selectRow:num5 inComponent:5 animated:YES];
    }
    else
    {
        self.errorLabel.text = @"Enter valid ticket";
    }
}

@end
