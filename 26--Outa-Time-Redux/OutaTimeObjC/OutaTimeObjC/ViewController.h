//
//  ViewController.h
//  OutaTimeObjC
//
//  Created by david on 11/9/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol foo
//
//- (void)methodname:(NSString *)argumentname;
//
//@end

@protocol DatePickerProtocol

- (void)dateWasChosen:(NSDate *)date;

@end


@interface ViewController : UIViewController <DatePickerProtocol, UIPopoverPresentationControllerDelegate>

@end

