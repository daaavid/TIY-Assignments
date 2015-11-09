//
//  PickerViewController.h
//  OutaTimeObjC
//
//  Created by david on 11/9/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface PickerViewController : UIViewController

@property (nonatomic) id<DatePickerProtocol> delegate;

@end
