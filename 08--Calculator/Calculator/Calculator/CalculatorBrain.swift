//
//  CalcBrain.swift
//  Calculator
//
//  Created by david on 10/15/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    var firstNumStr = ""
    var secondNumStr = ""
    var operatorSign = ""
    var result = 0.0
    var lastPressWasNum = false

    func calculate() -> Double
    {
        let firstNumber = toDouble(firstNumStr)
        let secondNumber = toDouble(secondNumStr)
        
        switch operatorSign
        {
        case "+":
            result = firstNumber + secondNumber
        case "−":
            result = firstNumber - secondNumber
        case "÷":
            result = firstNumber / secondNumber
        case "×":
            result = firstNumber * secondNumber
        case "%":
            result = secondNumber * 0.01
        case "+/-":
            result = secondNumber * -1
        case "=":
            result = firstNumber
        default:
            result = firstNumber
        }

        return result
    }
    
    func resultAsString(result: Double) -> String
    {
        if canBeInt(result) == true
        {
            return convertToIntString(result)
        }
        else
        {
            return String(result)
        }
    }
    
    func toDouble(numberToMake: String) -> Double
    {
        let numberAsDouble = NSString(string: numberToMake).doubleValue
        return numberAsDouble
    }
    
    func canBeInt(isDouble: Double) -> Bool
    {
        var rc = false
        if isDouble % 1 == 0
        {
            rc = true
        }
        return rc
    }
    
    func convertToIntString(result: Double) -> String
    {
        let resultAsIntArr = String(result).componentsSeparatedByString(".")
        return String(resultAsIntArr[0])
    }
}