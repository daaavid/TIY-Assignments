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
    var firstNum = 0.0
    var secondNum = 0.0
    var isTyping = false
    var calcBrain = CalculatorBrain?()
    var storedNum = 0.0
//    var currentNum: Double
//    var currentNumStr: NSString
    
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
        
        
        
 //       calcBrain?.storNum(calcDisplayNum)
        
        
//        calcDisplay = calcDisplayLabel.text!
        firstNum = NSString(string: calcDisplayNum).doubleValue
//        
//        calcDisplayLabel.text = ""
        
        
        
    }
    @IBAction func equalsButton(sender: UIButton)
    {
        secondNum = NSString(string: calcDisplayLabel.text!).doubleValue
        
        isTyping = false
        
        let brain = CalculatorBrain()
//        
//        if currentOperator == "+"
//        {
//            calcDisplayLabel.text = String(brain.add(firstNum, secondNum:storedNum))
//        }
//        
        
        
        switch currentOperator
        {
        case "+":
            calcDisplayLabel.text = String(brain.add(firstNum, secondNum:secondNum))
        case "−":
            calcDisplayLabel.text = String(brain.subtract(firstNum, secondNum:secondNum))
        case "÷":
            calcDisplayLabel.text = String(brain.divide(firstNum, secondNum:secondNum))
        case "×":
            calcDisplayLabel.text = String(brain.multiply(firstNum, secondNum:secondNum))
        case "%":
            calcDisplayLabel.text = String(brain.toPercent(secondNum))
        case "+/-":
            calcDisplayLabel.text = String(brain.toInverse(secondNum))
        default:
            break
        }

    }

}

