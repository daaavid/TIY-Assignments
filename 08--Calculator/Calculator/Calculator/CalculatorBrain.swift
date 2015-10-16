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
    var result = 0.0
    
//    func storNum(firstNumber: String)
//    {
//        firstNum = NSString(string: firstNumber).doubleValue
//    }
    
    func firstNumStor(firstNum: String)
    {
        firstNumber = makeDouble(firstNum)
    }
    
    func secondNumStor(secondNum: String)
    {
        secondNumber = makeDouble(secondNum)
    }
    
    func makeDouble(numberToMake: String) -> Double
    {
        let numberAsDouble = NSString(string: numberToMake).doubleValue
        return numberAsDouble
    }
    
//    init(firstNum: Double, secondNum: Double)
//    {
//        firstNumber = firstNum
//        secondNumber = secondNum
//    }
    
    func calculate(currentOperator: String) -> Double
    {
        switch currentOperator
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
        default:
            break
        }
        
        firstNumber = 0.0
        secondNumber = 0.0
        
        return result
    }
    
    func canBeInt(isDouble: Double) -> Bool
    {
        if isDouble % 1 == 0
        {
            return true
        }
        else
        {
            return false
        }
    }
//    func add(firstNum: Double, secondNum: Double) -> Double
//    {
//        let result = firstNum + secondNum
//        return result
//    }
//    
//    func subtract(firstNum: Double, secondNum: Double) -> Double
//    {
//        let result = firstNum - secondNum
//        return result
//    }
//    
//    func multiply(firstNum: Double, secondNum: Double) -> Double
//    {
//        let result = firstNum * secondNum
//        return result
//    }
//    
//    func divide(firstNum: Double, secondNum: Double) -> Double
//    {
//        let result = firstNum / secondNum
//        return result
//    }
//    
//    func toInverse(firstNum: Double) -> Double
//    {
//        let result = firstNum * -1
//        return result
//    }
//    
//    func toPercent(firstNum: Double) -> Double
//    {
//        let result = firstNum * 0.01
//        return result
//    }
//    
//    func equals()
//    {
//        
//    }
//    
//    func toDouble()
//    {
//        
//    }

}