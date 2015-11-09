//
//  ViewController.m
//  OutaTimeObjC
//
//  Created by david on 11/9/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "PickerViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *destTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *presTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (nonatomic) NSTimer *timer;
//@property (nonatomic) int *baseSpeed;
//@property (nonatomic) int *currentSpeed;
@property (nonatomic) int speed;

@property (weak, nonatomic) IBOutlet UIButton *travelBackButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.speedLabel.text = @"0 MPH";
    self.presTimeLabel.text = [self formatTime: [NSDate date]];
    
//    self.baseSpeed = 0;
//    self.currentSpeed = 0;
    self.speed = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PickerViewController* datePickerVC = (PickerViewController *)segue.destinationViewController;
    datePickerVC.delegate = self;
}

- (IBAction)setDestinationTimeButton:(UIButton *)sender
{
    
}

- (IBAction)travelBackButton:(UIButton *)sender
{
    [self travelBackPressed];
}

- (void)dateWasChosen:(NSDate *)date;
{
    NSString *formattedTime = [self formatTime: date];
    self.destTimeLabel.text = formattedTime;
//    self.speedLabel.text =
}

- (void)travelBackPressed
{
    if(![self.destTimeLabel.text isEqualToString:@"NOT SET"] && ![self.presTimeLabel.text isEqualToString:self.destTimeLabel.text])
//  if(self.timer == nil);
    {
        [self makeTimer];
        self.travelBackButton.enabled = false;
    }
}

- (NSString *)formatTime:(NSDate *)timeToFormat;
{
//    NSDateFormatter* formatter;
//    formatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMM dd YYYY" options:0 locale: nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd YYYY"];
    NSString *formattedTime = [formatter stringFromDate: timeToFormat];
    NSString *capitalizedTime = [formattedTime uppercaseString];
    
    return capitalizedTime;
}

- (void)makeTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target: self selector:@selector(updateSpeed) userInfo: nil repeats: YES];
}

- (void)updateSpeed
{
    self.speed += 1;
    
    if(self.speed == 88)
    {
        [self.timer invalidate];
        self.lastTimeLabel.text = self.presTimeLabel.text;
        self.presTimeLabel.text = self.destTimeLabel.text;
        self.speed = 0;
        self.travelBackButton.enabled = true;
    }
    
    NSString *speedString = [NSString stringWithFormat:@"%d MPH", self.speed];
    self.speedLabel.text = speedString;
}
@end
