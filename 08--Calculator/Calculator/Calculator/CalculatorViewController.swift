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
    
    var calcDisplay = ""
    var firstNum = 0.0
    var secondNum = 0.0
    var isTyping = false
    var calcBrain = CalculatorBrain?()
    
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
        let currentNum = sender.currentTitle
        
        if isTyping == true
        {
            calcDisplayLabel.text = calcDisplayLabel.text! + currentNum!
        }
        else
        {
            calcDisplayLabel.text = currentNum!
            isTyping = true
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
//        calcDisplay = calcDisplayLabel.text!
//        firstNum = NSString(string: calcDisplay).doubleValue
//        
//        calcDisplayLabel.text = ""
        
        calcDisplay = calcDisplayLabel.text!
        
    }
    @IBAction func equalsButton(sender: UIButton)
    {
        isTyping = false
    }

}

