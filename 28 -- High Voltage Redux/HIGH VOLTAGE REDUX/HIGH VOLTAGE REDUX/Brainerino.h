//
//  Brainerino.h
//  HIGH VOLTAGE REDUX
//
//  Created by david on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brainerino : NSObject

@property (nonatomic) double watts;
@property (nonatomic) double volts;
@property (nonatomic) double amps;
@property (nonatomic) double ohms;

- (void)calculate;//:(double)firstnum secondnum:(double)secondnum;
- (void)reset;

@end
