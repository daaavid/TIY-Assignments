//
//  ViewController.swift
//  Calculator
//
//  Created by david on 10/15/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController
{
    @IBOutlet var calcDisplayLabel: UILabel!
    
    var calcDisplayNum = ""
    var currentOperator = ""
//    var firstNum = 0.0
//    var secondNum = 0.0
    var isTyping = false
    var moreNums = false
//    var calcBrain = CalculatorBrain?()
//    var storedNum = 0.0
//    var currentNum: Double
//    var currentNumStr: NSString
    
    var brain = CalculatorBrain()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - ACTION HANDLERS
    
    @IBAction func clearButton(sender: UIButton)
    {
        calcDisplayLabel.text = ""
    }
    @IBAction func numberButton(sender: UIButton)
    {
//        currentNum = currentNumStr.doubleValue
//        currentNumStr = NSString(string: sender.currentTitle!)

        
        if isTyping == false
        {
            calcDisplayLabel.text = sender.currentTitle!
            isTyping = true
        }
        else
        {
            calcDisplayLabel.text = calcDisplayLabel.text! + sender.currentTitle!
        }
//        if sender.titleLabel!.text != ".
//        {
//            calcDisplayLabel.text = sender.titleLabel!.text
//        }
//        else
//        {
//            calcDisplayLabel.text = calcDisplayLabel.text! + sender.titleLabel!.text!
//        }
        
    }
    @IBAction func operatorButton(sender: UIButton)
    {
        isTyping = false
        currentOperator = sender.currentTitle!
        calcDisplayNum = calcDisplayLabel.text!

        if brain.firstNumber != 0
        {
            brain.secondNumStor(calcDisplayNum)
            performCalculation()
        }
        else
        {
            brain.firstNumStor(calcDisplayNum)
        }
        
//just assigning first number over and over
        
        
//        firstNum = NSString(string: calcDisplayNum).doubleValue
        
        
 //       calcBrain?.storNum(calcDisplayNum)
        
        
//        calcDisplay = calcDisplayLabel.text!
        
//        
//        calcDisplayLabel.text = ""
        
        
        
    }
    @IBAction func equalsButton(sender: UIButton)
    {
        calcDisplayNum = calcDisplayLabel.text!
        brain.secondNumStor(calcDisplayNum)
        
        performCalculation()
    }
    
    func performCalculation()
    {
        isTyping = false
        
//       secondNum = NSString(string: calcDisplayLabel.text!).doubleValue
//        brain.secondNumStor(calcDisplayNum)
//        let brain = CalculatorBrain(firstNum: firstNum, secondNum: secondNum)
        
        
        calcDisplayLabel.text = String(brain.calculate(currentOperator))
    }
        
        
//        
//        if currentOperator == "+"
//        {
//            calcDisplayLabel.text = String(brain.add(firstNum, secondNum:storedNum))
//        }
//        
        
        
//        switch currentOperator
//        {
//        case "+":
//            calcDisplayLabel.text = String(brain.add(firstNum, secondNum:secondNum))
//        case "−":
//            calcDisplayLabel.text = String(brain.subtract(firstNum, secondNum:secondNum))
//        case "÷":
//            calcDisplayLabel.text = String(brain.divide(firstNum, secondNum:secondNum))
//        case "×":
//            calcDisplayLabel.text = String(brain.multiply(firstNum, secondNum:secondNum))
//        case "%":
//            calcDisplayLabel.text = String(brain.toPercent(secondNum))
//        case "+/-":
//            calcDisplayLabel.text = String(brain.toInverse(secondNum))
//        default:
//            break
//          }


}

