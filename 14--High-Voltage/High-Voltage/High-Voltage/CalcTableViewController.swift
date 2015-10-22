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

    var calcButtonEnabled = false
    
    var shownCalcItems = Array<String>()
    
    var brain = Brainerino()
    
    let allCalcItems = ["AMPS", "WATTS", "VOLTS", "OHMS"]
    var remainingCalcItems = ["AMPS", "WATTS", "VOLTS", "OHMS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "electricity and also more electricity"
        
        if calcButtonEnabled == false
        {
            calculateButton.enabled = false
        }
        else
        {
            calculateButton.enabled = true
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shownCalcItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CalcCell", forIndexPath: indexPath) as! CalcCell
        


        let aCalc = shownCalcItems[indexPath.row]
        cell.calcLabel.text = aCalc
        
        if cell.calcNumTextField.text == ""
        {
            cell.calcNumTextField.becomeFirstResponder()
        }
    
        if brain.calculateFinished == true
        {
            
            if cell.calcLabel.text == "WATTS"
            {
                print("watts")
                cell.calcNumTextField.text = String(brain.watts)
            }
            if cell.calcLabel.text == "VOLTS"
            {
                print("volts")
                cell.calcNumTextField.text = String(brain.volts)
            }
            if cell.calcLabel.text == "AMPS"
            {
                print("amps")
                cell.calcNumTextField.text = String(brain.amps)
            }
            if cell.calcLabel.text == "OHMS"
            {
                cell.calcNumTextField.text = String(brain.ohms)
            }
            
        }
        
        return cell
    }
    
    func elecItemWasChosenFromPopover(chosenItem: String)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        shownCalcItems.append(chosenItem)
        
        let elecItemToRemoveFromPopover = (remainingCalcItems as NSArray).indexOfObject(chosenItem)
        remainingCalcItems.removeAtIndex(elecItemToRemoveFromPopover)
        
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
            
            textField.resignFirstResponder()
            
            if remainingCalcItems.count == 2
            {
                addButton.enabled = false
                calcButtonEnabled == true
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
            brain.watts = Float(textField)!
        }
    }

    
    // MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        //        return UIModalPresentationStyle.None
        return .None
    }

    @IBAction func calculateButton(sender: UIButton)
    {
        brain.calculate()
        
        print(" watts \(brain.watts) \n volts \(brain.volts) \n amps \(brain.amps) \n ohms \(brain.ohms)")
        
        shownCalcItems.removeAll(); for x in allCalcItems
        {
            shownCalcItems.append(x)
        }
        
        calcButtonEnabled = false
        tableView.reloadData()
        
        spookyScarySkeleton()

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "EqPopoverSegue"        {
            let destVC = segue.destinationViewController as! ElecPopoverTableViewController
            destVC.elecItems = remainingCalcItems
            destVC.popoverPresentationController?.delegate = self
            //this view controller wants to control how destVC is displayed, so we set ourselves as the delgate
            
            destVC.delegate = self //<< property of characterlisttableviewcontroller
            
            let contentHeight = 44.0 * CGFloat(remainingCalcItems.count)
            destVC.preferredContentSize = CGSizeMake(200.0, contentHeight)
        }
    }

    
    // MARK: - THE ACTION HANDLERS 4: FALL OF THE HANDLERS
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {

    }
    
    @IBAction func clearButton(sender: UIBarButtonItem)
    {
        shownCalcItems.removeAll()
        tableView.reloadData()
        
        remainingCalcItems = allCalcItems
        
        addButton.enabled = true
        
        brain.calculateFinished = false
    }
    
    func spookyScarySkeleton()
    {
        print("  ▒▒▒░░░░░░░░░░▄▐░░░░ \n ▒░░░░░░▄▄▄░░▄██▄░░░ \n ░░░░░░▐▀█▀▌░░░░▀█▄░ \n ░░░░░░▐█▄█▌░░░░░░▀█▄ \n ░░░░░░░▀▄▀░░░▄▄▄▄▄▀▀ \n ░░░░░▄▄▄██▀▀▀▀░░░░░ \n ░░░░█▀▄▄▄█░▀▀░░░░░░ \n ░░░░▌░▄▄▄▐▌▀▀▀░░░░░ \n ░░░░▌░▄▄▄▐▌▀▀▀░░░░░ \n ░▄░▐░░░▄▄░█░▀▀░░░░░ \n ░▀█▌░░░▄░▀█▀░▀░░░░░ \n ░░░░░░░░▄▄▐▌▄▄░░░░░ \n ░░░░░░░░▀███▀█░▄░░░ \n ░░░░░░░▐▌▀▄▀▄▀▐▄░░░ \n ░░░░░░░▐▀░░░░░░▐▌░░ \n ░░░░░░░█░░░░░░░░█░░ \n ░░░░░░▐▌░░░░░░░░░█░  ")
    }
}
