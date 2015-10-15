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
 //   var firstNum = 0.0
 //   var secondNum = 0.0
 //   var calcDisplay = ""
    
//    func storNum(firstNumber: String)
//    {
//        firstNum = NSString(string: firstNumber).doubleValue
//    }
    
    func add(firstNum: Double, secondNum: Double) -> Double
    {
        let result = firstNum + secondNum
        return result
    }
    
    func subtract(firstNum: Double, secondNum: Double) -> Double
    {
        let result = firstNum - secondNum
        return result
    }
    
    func multiply(firstNum: Double, secondNum: Double) -> Double
    {
        let result = firstNum * secondNum
        return result
    }
    
    func divide(firstNum: Double, secondNum: Double) -> Double
    {
        let result = firstNum / secondNum
        return result
    }
    
    func toInverse(firstNum: Double) -> Double
    {
        let result = firstNum * -1
        return result
    }
    
    func toPercent(firstNum: Double) -> Double
    {
        let result = firstNum * 0.01
        return result
    }
    
    func equals()
    {
        
    }
    
    func toDouble()
    {
        
    }

}