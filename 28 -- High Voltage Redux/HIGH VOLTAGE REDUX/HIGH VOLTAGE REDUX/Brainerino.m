//
//  Brainerino.m
//  HIGH VOLTAGE REDUX
//
//  Created by david on 11/11/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

#import "Brainerino.h"

@implementation Brainerino

- (void)calculate;//:(double)firstnum secondnum:(double)secondnum;
{
    if(_watts && _amps)
    {
        _ohms = _watts / (_amps * _amps);
        _volts = _watts / _amps;
    }
    else if(_watts && _volts)
    {
        _ohms = (_volts * _volts) / _watts;
        _amps = _watts / _volts;
    }
    else if(_watts && _ohms)
    {
        _amps = sqrt(_watts / _ohms);
        _volts = sqrt(_watts * _ohms);
    }
    else if(_volts && _amps)
    {
        _ohms = _volts / _amps;
        _watts = _volts * _amps;
    }
    else if(_volts && _ohms)
    {
        _watts = (_volts * _volts) / _ohms;
        _amps = _volts / _ohms;
    }
    else if(_ohms && _amps)
    {
        _watts = (_amps * _amps) * _ohms;
        _volts = _ohms * _amps;
    }
}

- (void)reset
{
    _amps = 0;
    _watts = 0;
    _ohms = 0;
    _volts = 0;
}

@end
