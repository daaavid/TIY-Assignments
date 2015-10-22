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

class CalcTableViewController: UITableViewController, ElecPopoverTableViewControllerDelegate, UIPopoverPresentationControllerDelegate
{
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    var shownCalcItems = Array<String>()
    
    let allCalcItems = ["Yup", "Nope", "Maybe"]
    var remainingCalcItems = ["Yup", "Nope", "Maybe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "yup mhm"
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CalcCell", forIndexPath: indexPath)

        let aCalc = shownCalcItems[indexPath.row]
        cell.textLabel?.text = aCalc
        cell.detailTextLabel?.text = "1+1"

        return cell
    }
    
    func elecItemWasChosenFromPopover(chosenItem: String)
    {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
        shownCalcItems.append(chosenItem)
        
        let elecItemToRemoveFromPopover = (remainingCalcItems as NSArray).indexOfObject(chosenItem)
        remainingCalcItems.removeAtIndex(elecItemToRemoveFromPopover)
        
        if remainingCalcItems.count == 0
        {
            addButton.enabled = false
        }
        
        tableView.reloadData()
    }
    
    // MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        //        return UIModalPresentationStyle.None
        return .None
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

    
    // MARK: - THE ACTION HANDLERS 4: RETURN OF THE ACTION
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {
        
    }
    
    @IBAction func clearButton(sender: UIBarButtonItem)
    {
        shownCalcItems.removeAll()
        tableView.reloadData()
        
        remainingCalcItems = allCalcItems
        
        addButton.enabled = true
    }

}
