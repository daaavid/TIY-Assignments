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

    var isTyping = false
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
    
//MARK: - THE ACTION HANDLERS 2: ELECTRIC BOOGALOO
    
    @IBAction func clearButton(sender: UIButton)
    {
        calcDisplayLabel.text = ""
        clearStorValues()
    }
    
    @IBAction func numberButton(sender: UIButton)
    {
        brain.lastPressWasNum = true
        
        if isTyping
        {
            calcDisplayLabel.text = calcDisplayLabel.text! + sender.currentTitle!
        }
        else
        {
            calcDisplayLabel.text = sender.currentTitle!
            isTyping = true
        }
    }
    
    @IBAction func operatorButton(sender: UIButton)
    {
        isTyping = false
        brain.operatorSign = sender.currentTitle!

        if brain.firstNumStr == ""
        {
            //if there isn't a first number, assign one
            brain.firstNumStr = calcDisplayLabel.text!
        }
        else
        {
            //otherwie, store it in the second number and do that calculation right away.
            //however, only if the last selection before the operator was a number.
            //ie no = then +
            
            if brain.lastPressWasNum == true
            {
                brain.secondNumStr = calcDisplayLabel.text!
            }
        
            performCalculation()
        }
    }
    
    @IBAction func equalsButton(sender: UIButton)
    {
        
        if brain.operatorSign == ""
        {
            //if user just presses a number and then 0 without pressing an operator, the calc display just shows the number
            brain.firstNumStr = calcDisplayLabel.text!
        }
        else
        {
            //otherwise, store the second number that's on the screen
            brain.secondNumStr = calcDisplayLabel.text!
        }

        performCalculation()
    }
    
//MARK: - private
    
    func performCalculation()
    {
        isTyping = false
        
        let answer = brain.calculate()
        calcDisplayLabel.text = brain.resultAsString(answer)
        
        brain.firstNumStr = String(answer)
        brain.secondNumStr = "0"
        brain.lastPressWasNum = false
    }
    
    func clearStorValues()
    {
        brain.firstNumStr = ""
        brain.secondNumStr = ""
        brain.operatorSign = ""
    }
}

