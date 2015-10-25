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
    @IBOutlet weak var errorLabel: UILabel!

    var brain = Brainerino()
    
    let allCalcItems = ["AMPS", "WATTS", "VOLTS", "OHMS"]
    var remainingCalcItems = ["AMPS", "WATTS", "VOLTS", "OHMS"]
    var shownCalcItems = Array<String>()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        title = "High Voltage"
        checkButtonStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shownCalcItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalcCell", forIndexPath: indexPath) as! CalcCell
        
        checkButtonStatus()
        
        let aCalc = shownCalcItems[indexPath.row]
        cell.calcLabel.text = aCalc
        
        cell.calcNumTextField.userInteractionEnabled = true
        
        if cell.calcNumTextField.text == "" && brain.calculateFinished == false
        {
            cell.calcNumTextField.becomeFirstResponder()
            errorLabel.text = "Enter in a number!"
        }
    
        if brain.calculateFinished == true
        {
            populateCellTexts(cell)
            errorLabel.text = "Press Clear if you want to perform another calculation!"
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
            textField.resignFirstResponder()
            checkButtonStatus()
        }
        
        return rc
    }
    
    func checkCalcLabel(label: String, textField: String)
    {
        switch label
        {
        case "WATTS":
            brain.watts = Float(textField)!
        case "VOLTS":
            brain.volts = Float(textField)!
        case "AMPS":
            brain.amps = Float(textField)!
        case "OHMS":
            brain.ohms = Float(textField)!
        default:
            print("?")
        }
    }

    // MARK: - THE ACTION HANDLERS 4: FALL OF THE HANDLERS
    
    @IBAction func clearButton(sender: UIBarButtonItem)
    {
        clear()
    }
    
    @IBAction func calculateButton(sender: UIButton)
    {
        calculate()
    }
    
    // MARK: - private
    
    func calculate()
    {
        let visibleCellsArray = self.tableView.visibleCells as! Array<CalcCell>
        
        for individualCell in visibleCellsArray
        {
            checkCalcLabel(individualCell.calcLabel.text!, textField: individualCell.calcNumTextField.text!)
        }
        
        brain.calculate()
        brain.calculateFinished = true
        calculateButton.enabled = false
        
        for x in allCalcItems
        {
            if !shownCalcItems.contains(x)
            {
                shownCalcItems.append(x)
            }
        }
        
        tableView.reloadData()
        
        spookyScarySkeleton()
    }
    
    func clear()
    {
        let visibleCellsArray = self.tableView.visibleCells as! Array<CalcCell>
        
        for individualCell in visibleCellsArray
        {
            individualCell.calcNumTextField.text = ""
        }
        
        shownCalcItems.removeAll()
        
        brain.reset()
        
        remainingCalcItems = allCalcItems
        
        brain.calculateFinished = false
        
        checkButtonStatus()
        
        tableView.reloadData()
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
        
        if brain.calculateFinished == true
        {
            calculateButton.enabled = false
        }
        
        switch shownCalcItems.count
        {
        case 0:
            errorLabel.text = "Enter two values!"
        case 1:
            errorLabel.text = "Enter one more value!"
        default:
            errorLabel.text = ""
        }
    }
    
    func populateCellTexts(cell: CalcCell)
    {
        if cell.calcLabel.text == "WATTS"
        {
            cell.calcNumTextField.text = brain.wattStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
        else if cell.calcLabel.text == "VOLTS"
        {
            cell.calcNumTextField.text = brain.voltStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
        else if cell.calcLabel.text == "AMPS"
        {
            cell.calcNumTextField.text = brain.ampStr
            cell.calcNumTextField.userInteractionEnabled = false
        }
        else if cell.calcLabel.text == "OHMS"
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
        print("This skeleton man was killed by high voltage. Rest in Peace")
    }
}
