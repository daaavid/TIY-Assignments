//
//  CalculatorBrainerino.swift
//  High-Voltage
//
//  Created by david on 10/22/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Brainerino
{
    var watts: Float = 0.0
    var volts: Float  = 0.0
    var amps: Float  = 0.0
    var ohms: Float  = 0.0
    
    var wattStr = ""
    var voltStr = ""
    var ampStr = ""
    var ohmStr = ""
    
    var calculateFinished = false
    
    func calculate()
    {
        if watts != 0 && amps != 0
        {
            ohms = ohmsCalc(3)
            volts = voltsCalc(2)
        }
        else if watts != 0 && volts != 0
        {
            ohms = ohmsCalc(2)
            amps = ampsCalc(2)
        }
        else if watts != 0 && ohms != 0
        {
            amps = ampsCalc(2)
            volts = voltsCalc(3)
        }
        else if volts != 0 && amps != 0
        {
            ohms = ohmsCalc(1)
            watts = wattsCalc(1)
        }
        else if volts != 0 && ohms != 0
        {
            watts = wattsCalc(2)
            amps = ampsCalc(1)
        }
        else if ohms != 0 && amps != 0
        {
            watts = wattsCalc(3)
            volts = voltsCalc(1)
        }
        
        wattStr = String(watts)
        voltStr = String(volts)
        ampStr = String(amps)
        ohmStr = String(ohms)
        
        watts = 0
        volts = 0
        amps = 0
        ohms = 0

        calculateFinished = true
    }
    
    func ohmsCalc(cv: Int) -> Float
    {
        switch cv
        {
        case 1:
            ohms = volts / amps
        case 2:
            ohms = (volts * volts) / watts
        case 3:
            ohms = watts / (amps * amps)
        default:
            ohms = 1000000
        }
        return ohms
    }
    
    func ampsCalc(cv: Int) -> Float
    {
        switch cv
        {
        case 1:
            amps = volts / ohms
        case 2:
            amps = watts / volts
        case 3:
            amps = Float(sqrt(Double(watts) / Double(ohms)))
        default:
            amps = 1000000
        }
        return amps
    }
    
    func voltsCalc(cv: Int) -> Float
    {
        switch cv
        {
        case 1:
            volts = amps * ohms
        case 2:
            volts = watts / amps
        case 3:
            volts = Float(sqrt(Double(watts) * Double(ohms)))
        default:
            volts = 1000000
        }
        return volts
    }
    
    func wattsCalc(cv: Int) -> Float
    {
        switch cv
        {
        case 1:
            watts = volts * amps
        case 2:
            watts = (volts * volts) / ohms
        case 3:
            watts = (amps * amps) * ohms
        default:
            watts = 1000000
        }
        return watts
    }
    
    func reset()
    {
//        watts = 0
//        volts = 0
//        amps = 0
//        ohms = 0
        
        wattStr = ""
        voltStr = ""
        ampStr = ""
        ohmStr = ""
    }
}