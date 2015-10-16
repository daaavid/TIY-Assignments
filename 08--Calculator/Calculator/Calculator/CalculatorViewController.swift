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
        clearStorValues()
    }
    @IBAction func numberButton(sender: UIButton)
    {
        if isTyping == false
        {
            calcDisplayLabel.text = sender.currentTitle!
            isTyping = true
        }
        else
        {
            calcDisplayLabel.text = calcDisplayLabel.text! + sender.currentTitle!
        }
    }
    
    @IBAction func operatorButton(sender: UIButton)
    {
        isTyping = false
        calcDisplayNum = calcDisplayLabel.text!
        let operatorPressed = sender.currentTitle!
        brain.operatorStor(operatorPressed)
        
//        if brain.firstNumber == nil //if there's not a value already in firstNumber, put one in
        if brain.firstNumberStr == ""
        {
//            currentOperator = sender.currentTitle!
//            brain.operatorSign = operatorPressed
//            brain.operatorStor(operatorPressed)
            brain.firstNumStor(calcDisplayNum)
        }
//        if brain.secondNumber != 0
//        {
//            performCalculation()
//        }
        else //otherwise if there's already a value, put it in the secondNumber and then run the calc on it
        {
//            currentOperator = sender.currentTitle!
//            operatorPressed = brain.operatorSign
//            brain.operatorStor(operatorPressed)
//            brain.operatorStor("")
//            brain.secondNumStor(calcDisplayNum)
            performCalculation()
//            brain.firstNumberStr = ""
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
//        brain.secondNumStor(calcDisplayNum)
        performCalculation()
//        brain.firstNumberStr = ""
    }
    
    func performCalculation()
    {
        calcDisplayNum = calcDisplayLabel.text!
        
        isTyping = false
        brain.secondNumStor(calcDisplayNum)
 //       let answer = brain.calculate(brain.operatorSign)

        
        if brain.firstNumberStr == ""
        {
            brain.operatorSign = ""
        }
    
        let answer = brain.calculate(brain.operatorSign)

        
        if brain.canBeInt(answer) == true
        {
            calcDisplayLabel.text = brain.convertToIntString(answer)
        }
        else
        {
            calcDisplayLabel.text = String(answer)
        }

        brain.firstNumStor(String(answer))
        brain.secondNumStor("")
    }

    
//    func performCalculation()
//    {
//        isTyping = false
//        let answer = brain.calculate(currentOperator)
//        
//        if brain.canBeInt(answer) == true
//        {
//            calcDisplayLabel.text = brain.convertToIntString(answer)
//        }
//        else
//        {
//            calcDisplayLabel.text = String(answer)
//        }
//        
//        brain.firstNumStor(String(answer))
//        brain.secondNumStor("0")
    
//        brain.secondNumStor(String(answer))
//        brain.secondNumber = answer
        
//        brain.firstNumStor("0")
//        brain.firstNumber = 0
        
//       secondNum = NSString(string: calcDisplayLabel.text!).doubleValue
//        brain.secondNumStor(calcDisplayNum)
//        let brain = CalculatorBrain(firstNum: firstNum, secondNum: secondNum)
//        if brain.canBeInt(answer) == true
//        {
//            let answerAsIntArr = String(answer).componentsSeparatedByString(".")
//            calcDisplayLabel.text = String(answerAsIntArr[0])
//        }
//        else
//        {
//            calcDisplayLabel.text = String(brain.calculate(currentOperator))
//        }
//    }
    
    func clearStorValues()
    {
        brain.firstNumStor("0")
        brain.secondNumStor("0")
        brain.firstNumberStr = ""
        brain.firstNumber = 0
        brain.secondNumber = 0
    }


}

