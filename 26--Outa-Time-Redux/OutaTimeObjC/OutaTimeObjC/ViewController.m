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
@property (nonatomic) NSTimer *accelerate;
@property (nonatomic) NSTimer *decelerate;
@property (nonatomic) int speed;

@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UIButton *travelBackButton;
@property (weak, nonatomic) IBOutlet UIButton *setDestTimeButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup
{
    self.speed = 0;
    self.speedLabel.text = @"0 MPH";
    self.destTimeLabel.text = @"--- -- ----";
    self.lastTimeLabel.text = @"--- -- ----";
    self.presTimeLabel.text = [self formatTime: [NSDate date]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showPickerSegue"])
    {
        PickerViewController* datePickerVC = segue.destinationViewController;
        UIPopoverPresentationController *controller = datePickerVC.popoverPresentationController;
        controller.delegate = self;
        datePickerVC.delegate = self;
        
        datePickerVC.modalPresentationStyle = UIModalPresentationPopover;
        datePickerVC.preferredContentSize = CGSizeMake(400, 200);
    }
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
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
    BOOL notSet = ![self.destTimeLabel.text isEqualToString:@"--- -- ----"];
    BOOL presAndDestNotEqual = ![self.presTimeLabel.text isEqualToString:self.destTimeLabel.text];
    if (notSet && presAndDestNotEqual)
//  if(self.timer == nil);
    {
        self.travelBackButton.enabled = NO;
        self.setDestTimeButton.enabled = NO;
        [self accelTimer: 0.15];
    }
    else if (!notSet)
    {
        self.errorLabel.text = @"DEST TIME NOT SET";
    }
    else if (!presAndDestNotEqual)
    {
        self.errorLabel.text = @"DEST AND PRES TIME ARE EQUAL";
    }
}

- (NSString *)formatTime:(NSDate *)timeToFormat;
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd YYYY"];
    NSString *formattedTime = [formatter stringFromDate: timeToFormat];
    NSString *capitalizedTime = [formattedTime uppercaseString];
    
    return capitalizedTime;
}

- (void)accelTimer:(double)tickInterval;
{
    self.accelerate = [NSTimer scheduledTimerWithTimeInterval: tickInterval target: self selector: @selector(updateSpeed) userInfo: nil repeats: YES];
}

- (void)updateSpeed
{
    self.speed += 1;
    [self accelerateSpeed:self.speed];
    
    if(self.speed < 88)
    {
        NSString *speedString = [NSString stringWithFormat:@"%d MPH", self.speed];
        self.speedLabel.text = speedString;
    }
    else if(self.speed == 88)
    {
        self.speedLabel.text = @"88 MPH";
        self.errorLabel.text = @"SPEED REACHED";
    }
    else if(self.speed == 92)
    {
        self.errorLabel.text = @"TRAVELING";
    }
    else if(self.speed == 96)
    {
        [self invalidateTimers];
//        self.speed = 0;
        self.travelBackButton.enabled = true;
        
        self.lastTimeLabel.text = self.presTimeLabel.text;
        self.presTimeLabel.text = self.destTimeLabel.text;
        
        self.decelerate = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(updateBrake) userInfo:nil repeats:YES];
        
        self.errorLabel.text = @"DECELERATING";
    }
}

- (void)accelerateSpeed:(int)speed;
{
    switch(speed)
    {
        case 5:
            [self invalidateTimers];
            [self accelTimer:0.03];
        case 10:
            [self invalidateTimers];
            [self accelTimer:0.025];
        case 20:
            [self invalidateTimers];
            [self accelTimer:0.02];
        case 30:
            [self invalidateTimers];
            [self accelTimer:0.0225];
        case 50:
            [self invalidateTimers];
            [self accelTimer:0.03];
        case 60:
            [self invalidateTimers];
            [self accelTimer:0.0345];
        case 70:
            [self invalidateTimers];
            [self accelTimer:0.0585];
        case 80:
            [self invalidateTimers];
            [self accelTimer:0.065];
        default: break;
    }
}

- (void)invalidateTimers
{
    [self.accelerate invalidate];
    [self.decelerate invalidate];
}

- (void)updateBrake
{
    self.speed -= 1;
    NSString *speedString = [NSString stringWithFormat:@"%d MPH", self.speed];
    self.speedLabel.text = speedString;
    
    if(self.speed == 0)
    {
        [self stop];
    }
}

- (void) stop
{
    [self invalidateTimers];
    self.speed = 0;
    
    self.travelBackButton.enabled = YES;
    self.setDestTimeButton.enabled = YES;
    
    self.errorLabel.text = @"ARRIVED";
}

@end
