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
    var isTyping = false
    var multipleOperators = false
    
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
        
        brain.firstNumStor(calcDisplayNum)
        
        if brain.firstNumberStr == ""
        {
            
        }
        
    }
    
    @IBAction func equalsButton(sender: UIButton)
    {
        
//        calcDisplayNum = calcDisplayLabel.text!
        
        performCalculation()
    }
    
    func performCalculation()
    {
        isTyping = false

        calcDisplayNum = calcDisplayLabel.text!
        brain.secondNumStor(calcDisplayNum)

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
        brain.secondNumberStr = ""
        brain.secondNumStor("")
    }
    
    func clearStorValues()
    {
        brain.firstNumStor("0")
        brain.secondNumStor("0")
        brain.firstNumberStr = ""
        brain.firstNumber = 0
        brain.secondNumber = 0
    }


}

