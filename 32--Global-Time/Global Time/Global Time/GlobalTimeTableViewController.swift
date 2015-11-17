//
//  GlobalTimeTableViewController.swift
//  Global Time
//
//  Created by david on 11/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

protocol TimezonePopoverTableViewControllerDelegate
{
    func timezoneWasChosen(chosenTimezone: String)
}

class GlobalTimeTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, TimezonePopoverTableViewControllerDelegate
{
    @IBOutlet weak var addButton: UIBarButtonItem!

    let allTimezones = NSTimeZone.knownTimeZoneNames
    var shownTimezones = [String]()
    var remainingTimezones = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        remainingTimezones = allTimezones()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        if remainingTimezones.count == 0
        {
            addButton.enabled = false
        }
        else
        {
            addButton.enabled = true
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return shownTimezones.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("ClockCell", forIndexPath: indexPath) as! ClockCell
        
        let timezone = shownTimezones[indexPath.row]
        cell.timeZoneLabel.text = timezone
        cell.clockView.timezone = NSTimeZone(name: timezone)
        
        return cell
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            shownTimezones.removeAtIndex(indexPath.row)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ClockCell
            cell.clockView.animationTimer?.invalidate()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "popover"
        {
            let popover = segue.destinationViewController as! TimezonePopoverTableViewController
            popover.timezones = remainingTimezones
            popover.delegate = self
            popover.popoverPresentationController?.delegate = self
            
            let contentHeight = 44 * CGFloat(remainingTimezones.count)
            popover.preferredContentSize = CGSizeMake(200, contentHeight)
        }
    }
    
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        //        return UIModalPresentationStyle.None
        return .None
    }
    
    func timezoneWasChosen(chosenTimezone: String)
    {
        shownTimezones.append(chosenTimezone)
        
        let rowToRemove = (remainingTimezones as NSArray).indexOfObject(chosenTimezone)
        remainingTimezones.removeAtIndex(rowToRemove)
        
        tableView.reloadData()
        

    }
}
