//
//  CalcTableViewController.swift
//  High-Voltage
//
//  Created by david on 10/22/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol ElecPopoverTableViewControllerDelegate
{
    func elecItemWasChosenFromPopover(chosenItem: String)
}

class CalcTableViewController: UITableViewController, ElecPopoverTableViewControllerDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate
{
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak var calculateButton: UIButton!

    var calcButtonEnabled: Bool = false
    var brain = Brainerino()
    
    let allCalcItems = ["AMPS", "WATTS", "VOLTS", "OHMS"]
    var remainingCalcItems = ["AMPS", "WATTS", "VOLTS", "OHMS"]
    var shownCalcItems = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "electricity and also more electricity"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCalcItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalcCell", forIndexPath: indexPath) as! CalcCell
        
        let aCalc = shownCalcItems[indexPath.row]
        cell.calcLabel.text = aCalc
        cell.calcNumTextField.userInteractionEnabled = true
        
        if cell.calcNumTextField.text == "" && brain.calculateFinished == false
        {
            cell.calcNumTextField.becomeFirstResponder()
            addButton.enabled = false
        }
    
        if brain.calculateFinished == true
        {
            populateCellTexts(cell)
        }
        
        return cell
    }
    
    func elecItemWasChosenFromPopover(chosenItem: String)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
        shownCalcItems.append(chosenItem)
        
        let elecItemToRemoveFromPopover = (remainingCalcItems as NSArray).indexOfObject(chosenItem)
        remainingCalcItems.removeAtIndex(elecItemToRemoveFromPopover)
        
        checkButtonStatus()
        
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        var rc = false
        
        if textField.text != ""
        {
            rc = true
            let contentView = textField.superview
            let cell = contentView?.superview as! CalcCell
//            let indexPath = tableView.indexPathForCell(cell)
//            let aCalcItem = allCalcItems[indexPath!.row]

            checkCalcLabel(cell.calcLabel.text!, textField: cell.calcNumTextField.text!)
            
            if textField.text != ""
            {
                textField.resignFirstResponder()
                addButton.enabled = true
            
                if remainingCalcItems.count == 2
                {
                    addButton.enabled = false
                    calculateButton.enabled = true
                    
                    tableView.reloadData()
                }
            }
        }
        
        return rc
    }
    
    func checkCalcLabel(label: String, textField: String)
    {
        if label == "WATTS"
        {
            print("watts")
            brain.watts = Float(textField)!
        }
        if label == "VOLTS"
        {
            print("volts")
            brain.volts = Float(textField)!
        }
        if label == "AMPS"
        {
            print("amps")
            brain.amps = Float(textField)!
        }
        if label == "OHMS"
        {
            print("ohms")
            brain.ohms = Float(textField)!
        }
    }


    // MARK: - THE ACTION HANDLERS 4: FALL OF THE HANDLERS
    
    @IBAction func clearButton(sender: UIBarButtonItem)
    {
        shownCalcItems.removeAll()
        
        brain.reset()
        
        tableView.reloadData()
        
        remainingCalcItems = allCalcItems
        
        addButton.enabled = true
        
        brain.calculateFinished = false
    
    }
    
    @IBAction func calculateButton(sender: UIButton)
    {
        
        calculate()
    }
    
    func calculate()
    {
        for x in allCalcItems
        {
            if !shownCalcItems.contains(x)
            {
                shownCalcItems.append(x)
            }
            
        }
        tableView.reloadData()
        
        calculateButton.enabled = false
        
        brain.calculate()
    }
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {
        
    }
    
    func checkButtonStatus()
    {
        if shownCalcItems.count < 2
        {
            calculateButton.enabled = false
            addButton.enabled = true
        }
        else
        {
            calculateButton.enabled = true
            addButton.enabled = false
        }
    }
    
    func populateCellTexts(cell: CalcCell)
    {
        if cell.calcLabel.text == "WATTS"
        {
            print("watts")
            cell.calcNumTextField.text = brain.wattStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
        if cell.calcLabel.text == "VOLTS"
        {
            print("volts")
            cell.calcNumTextField.text = brain.voltStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
        if cell.calcLabel.text == "AMPS"
        {
            print("amps")
            cell.calcNumTextField.text = brain.ampStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
        if cell.calcLabel.text == "OHMS"
        {
            cell.calcNumTextField.text = brain.ohmStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "EqPopoverSegue"
        {
            let destVC = segue.destinationViewController as! ElecPopoverTableViewController
            destVC.elecItems = remainingCalcItems
            destVC.popoverPresentationController?.delegate = self
            //this view controller wants to control how destVC is displayed, so we set ourselves as the delgate
            
            destVC.delegate = self //<< property of characterlisttableviewcontroller
            
            let contentHeight = 44.0 * CGFloat(remainingCalcItems.count)
            destVC.preferredContentSize = CGSizeMake(200.0, contentHeight)
        }
    }
    
    // MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        //        return UIModalPresentationStyle.None
        return .None
    }
    
    func spookyScarySkeleton()
    {
        print("  ▒▒▒░░░░░░░░░░▄▐░░░░ \n ▒░░░░░░▄▄▄░░▄██▄░░░ \n ░░░░░░▐▀█▀▌░░░░▀█▄░ \n ░░░░░░▐█▄█▌░░░░░░▀█▄ \n ░░░░░░░▀▄▀░░░▄▄▄▄▄▀▀ \n ░░░░░▄▄▄██▀▀▀▀░░░░░ \n ░░░░█▀▄▄▄█░▀▀░░░░░░ \n ░░░░▌░▄▄▄▐▌▀▀▀░░░░░ \n ░░░░▌░▄▄▄▐▌▀▀▀░░░░░ \n ░▄░▐░░░▄▄░█░▀▀░░░░░ \n ░▀█▌░░░▄░▀█▀░▀░░░░░ \n ░░░░░░░░▄▄▐▌▄▄░░░░░ \n ░░░░░░░░▀███▀█░▄░░░ \n ░░░░░░░▐▌▀▄▀▄▀▐▄░░░ \n ░░░░░░░▐▀░░░░░░▐▌░░ \n ░░░░░░░█░░░░░░░░█░░ \n ░░░░░░▐▌░░░░░░░░░█░  ")
    }
}
