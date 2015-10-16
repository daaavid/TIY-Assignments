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
        
        if brain.operatorSign == "="
        {
            brain.secondNumStor(calcDisplayLabel.text!)
        }
        else
        {
            brain.operatorSign = sender.currentTitle!
        }
        
        if brain.firstNumStr == ""
        {
            brain.firstNumStor(calcDisplayLabel.text!)
        }
        else
        {
            brain.secondNumStor(calcDisplayLabel.text!)
            performCalculation()
        }
        
    }
    
    @IBAction func equalsButton(sender: UIButton)
    {
        if brain.firstNumStr == ""
        {
            brain.firstNumStor(calcDisplayLabel.text!)
        }
        else
        {
            brain.secondNumStor("")
            brain.secondNumStor(calcDisplayLabel.text!)
        }
        performCalculation()
        clearStorValues()
    }
    
    func performCalculation()
    {
        isTyping = false
        let answer = brain.calculate()
        calcDisplayLabel.text = brain.resultAsString(answer)
        brain.firstNumStor(String(answer))
        brain.secondNumStor("0")
    }
    
    func clearStorValues()
    {
        brain.firstNumStor("")
        brain.secondNumStor("")
        brain.operatorSign = ""
    }


}

