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
        
        shownTimezones.append("America/New_York")
        remainingTimezones = allTimezones()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        let frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        let cellClock = ClockView(frame: frame)
        cellClock.timezone = NSTimeZone(name: timezone)
        
        cellClock.tag = 1
        cell.addSubview(cellClock)

        return cell
    }


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            shownTimezones.removeAtIndex(indexPath.row)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! ClockCell
            let cellClock = cell.viewWithTag(1) as! ClockView
            cellClock.animationTimer!.invalidate()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "popover"
        {
            let popover = segue.destinationViewController as! TimezonePopoverTableViewController
            popover.delegate = self
            popover.popoverPresentationController?.delegate = self
            popover.timezones = remainingTimezones
            
            popover.preferredContentSize = CGSizeMake(100, 300)
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
