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
    var firstNumber = 0.0
    var secondNumber = 0.0
    var firstNumStr = ""
    var secondNumStr = ""
    var operatorSign = ""
    var result = 0.0
    
    func firstNumStor(number: String)
    {
        firstNumStr = number
    }
    
    func secondNumStor(number: String)
    {
        secondNumStr = number
    }
    
//    func numStor(number: String)
//    {
//        if operatorSign == ""
//        {
//            firstNumberStr = firstNumberStr + number
//        }
//
//        else
//        {
//            secondNumberStr = secondNumberStr + number
//        }
//    }
    
    func opStor(operat: String)
    {
        operatorSign = operat
    }
    
    func calculate() -> Double
    {
        firstNumber = toDouble(firstNumStr)
        secondNumber = toDouble(secondNumStr)
        
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

        firstNumber = 0
        secondNumber = 0
        
        return result
    }
    
    func resultAsString(result: Double) -> String
    {
        if canBeInt(result)
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