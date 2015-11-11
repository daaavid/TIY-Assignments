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
//    NSLog(winningNumbers);
    [self.delegate winningNumbersWereChosen: winningNumbers];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 53;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowAsStr = [NSString stringWithFormat:@"%ld", (long)row];
    return rowAsStr;
}

-(NSMutableArray *)getWinningNumbers
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSInteger x = 5;
    while (x >= 0)
    {
        NSInteger selectedNumber = [self.picker selectedRowInComponent:x];
        NSNumber *selectedNSNumber = [NSNumber numberWithInteger:selectedNumber];
        [tempArray addObject:selectedNSNumber];
        
        x -= 1;
    }
    return tempArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
